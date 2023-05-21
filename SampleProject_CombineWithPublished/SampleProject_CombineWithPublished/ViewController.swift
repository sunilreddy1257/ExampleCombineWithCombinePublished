//
//  ViewController.swift
//  SampleProject_CombineWithPublished
//
//  Created by Sunil Kumar Reddy Sanepalli on 21/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: UsersListViewModel = UsersListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func usersListButtonTapped(_ sender: UIButton) {
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") {
            cell.textLabel?.text = "\(viewModel.usersList[indexPath.row].name) (id: \(viewModel.usersList[indexPath.row].id)"
            return cell
        }
        return UITableViewCell()
    }
}

