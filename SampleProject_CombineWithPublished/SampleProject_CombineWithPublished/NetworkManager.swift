//
//  NetworkManager.swift
//  SampleProject_CombineWithPublished
//
//  Created by Sunil Kumar Reddy Sanepalli on 21/05/23.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Decodable>(endpoint: String, type: T.Type) -> Future<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
            guard let url = URL(string: endpoint) else { return promise(.failure(NetworkError.invalidURL)) }
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let responseData = response as? HTTPURLResponse, 200...299 ~= responseData.statusCode else {throw NetworkError.invalidResponse}
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        default:
                            promise(.failure(NetworkError.decodingError))
                        }
                    }
                } receiveValue: { decodeData in
                    promise(.success(decodeData))
                }
                .store(in: &self!.cancellables)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
