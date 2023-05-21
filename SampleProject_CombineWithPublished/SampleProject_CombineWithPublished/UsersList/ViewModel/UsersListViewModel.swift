//
//  UsersListViewModel.swift
//  SampleProject_CombineWithPublished
//
//  Created by Sunil Kumar Reddy Sanepalli on 21/05/23.
//

import Foundation
import Combine
class UsersListViewModel {
    
    @Published var usersList = [Users]()
    private var cancellables = Set<AnyCancellable>()
    
    func getUserList() {
        NetworkManager.shared.getData(endpoint: UrlsList.usersList, type: Users.self)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { usersData in
                self.usersList = usersData
            }
            .store(in: &self.cancellables)
    }
}
