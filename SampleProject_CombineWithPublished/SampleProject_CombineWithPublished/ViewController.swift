//
//  ViewController.swift
//  SampleProject_CombineWithPublished
//
//  Created by Sunil Kumar Reddy Sanepalli on 21/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: UsersListViewModel = UsersListViewModel()
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bindViewModel()
    }
    
    @IBAction func usersListButtonTapped(_ sender: UIButton) {
        getData()
    }
    
    func getData() {
        viewModel.getUserList()
    }
    
    func bindViewModel() {
        viewModel.$usersList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.tableView.reloadData()
        }
        .store(in: &self.cancellables)

    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") {
            cell.textLabel?.text = "\(viewModel.usersList[indexPath.row].name) (id: \(viewModel.usersList[indexPath.row].id))"
            return cell
        }
        return UITableViewCell()
    }
}

