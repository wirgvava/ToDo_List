//
//  TaskListViewController.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import UIKit

protocol TaskListViewProtocol: AnyObject {
    func reloadData()
    func setupNavBar()
    func updateTask(at index: Int, isCompleted: Bool)
}

class TaskListViewController: UIViewController {
    var presenter: TaskListPresenterProtocol?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavBar()
    }
    
    deinit {
        presenter?.deinitialize()
    }
    
    // MARK: - Methods
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - IBAction
    @IBAction func didTapOnAddButton(){
        presenter?.navToTaskAdd()
    }
}

// MARK: - TaskListViewProtocol
extension TaskListViewController: TaskListViewProtocol {
    func setupNavBar(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func updateTask(at index: Int, isCompleted: Bool) {
        presenter?.updateTask(at: index, isCompleted: isCompleted)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView
extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfTasks() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskCell,
              let task = presenter?.task(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.view = self
        cell.index = indexPath.row
        cell.configure(with: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = presenter?.task(at: indexPath.row) else { return }
        presenter?.openTaskDetail(with: task)
    }
}
