//
//  TaskDetailRouter.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import UIKit

protocol TaskDetailRouterProtocol: AnyObject {
    func popViewController()
    func edit(task: TaskModel)
    func save(task: TaskModel)
}

class TaskDetailRouter {
    weak var viewController: UIViewController?
    weak var presenter: TaskDetailPresenter?
    
    static func createModule(with task: TaskModel?) -> TaskDetailViewController {
        let presenter = TaskDetailPresenter()
        let router = TaskDetailRouter()
        
        // View
        let storyboard = UIStoryboard(name: Storyboards.Name.TaskDetail, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: Storyboards.IDs.TaskDetail) as! TaskDetailViewController
        
        view.task = task
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        router.presenter = presenter
        
        return view
    }
}

// MARK: - TaskDetailRouterProtocol
extension TaskDetailRouter: TaskDetailRouterProtocol {
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    // TODO: UPDATING TASK NOT WORKING
    func edit(task: TaskModel) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "Edit", style: .default) { _ in
            self.presenter?.editMode()
        }
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            CoreDataManager.shared.deleteTask(task: task)
            self.postNotification()
            self.popViewController()
        }
        
        alert.addAction(edit)
        alert.addAction(delete)
        viewController?.present(alert, animated: true)
    }
    
    func save(task: TaskModel) {
        postNotification()
        CoreDataManager.shared.updateTask(task: task)
    }
    
    private func postNotification(){
        let center = NotificationCenter.default
        let taskUpdated = Notifications.taskUpdated.notificationName
        center.post(name: taskUpdated, object: nil)
    }
}
