//
//  TaskListPresenter.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import Foundation

protocol TaskListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func deinitialize()
    func reloadData()
    func numberOfTasks() -> Int
    func task(at index: Int) -> TaskModel?
    func updateTask(at index: Int, isCompleted: Bool)
    func openTaskDetail(with task: TaskModel)
    func navToTaskAdd()
}

class TaskListPresenter {
    weak var view: TaskListViewProtocol?
    var router: TaskListRouterProtocol?
    
    // Data
    private var tasks: [TaskModel] = []

    // fetch tasks from API at first launch
    func fetchAndSaveTasks() {
        CoreDataManager.shared.fetchTasksFromAPI { [weak self] success in
            guard let self = self else { return }
            if success {
                self.viewDidLoad()
            } else {
                print("Failed to fetch tasks from API.")
            }
        }
    }
}

// MARK: - TaskListPresenterProtocol
extension TaskListPresenter: TaskListPresenterProtocol {
    func viewDidLoad() {
        CoreDataManager.shared.fetchTasks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tasks):
                self.tasks = tasks.sorted(by: { $0.createdAt! > $1.createdAt! })
                self.view?.reloadData()
            case .failure(let error):
                print("Failed to fetch tasks: \(error)")
            }
        }
        
        subscribe()
    }
    
    func deinitialize() {
        unsubscribe()
    }
    
    func updateTask(at index: Int, isCompleted: Bool) {
        let task = tasks[index]
        task.isCompleted = isCompleted
        CoreDataManager.shared.updateTask(task: task)
        self.view?.reloadData()
    }
    
    func openTaskDetail(with task: TaskModel) {
        router?.navigateToTaskDetail(with: task)
    }
    
    func navToTaskAdd() {
        router?.navigateToTaskAdd()
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func task(at index: Int) -> TaskModel? {
        return tasks[index]
    }
    
    func reloadData() {
        self.view?.reloadData()
    }
}

// MARK: - Notifications
extension TaskListPresenter {
    private func unsubscribe(){
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    private func subscribe(){
        let center = NotificationCenter.default
        let taskUpdated = Notifications.taskUpdated.notificationName
        center.addObserver(self, selector: #selector(taskUpdated(_:)), name: taskUpdated, object: nil)
    }
    
    @objc func taskUpdated(_ sender: Notification){
        self.viewDidLoad()
    }
}
