//
//  TaskListRouter.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import UIKit

protocol TaskListRouterProtocol: AnyObject {
    func navigateToTaskDetail(with task: TaskModel)
    func navigateToTaskAdd()
}

class TaskListRouter {
    weak var viewController: UIViewController?
    weak var presenter: TaskListPresenter?
    
    static func createModule() -> TaskListViewController {
        let presenter = TaskListPresenter()
        let router = TaskListRouter()
        
        // View
        let storyboard =  UIStoryboard(name: Storyboards.Name.TaskList, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: Storyboards.IDs.TaskList) as! TaskListViewController
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        router.presenter = presenter
        
        return view
    }
}

// MARK: - TaskListRouterProtocol
extension TaskListRouter: TaskListRouterProtocol {
    func navigateToTaskDetail(with task: TaskModel) {
        let taskDetailViewController = TaskDetailRouter.createModule(with: task)
        viewController?.navigationController?.pushViewController(taskDetailViewController, animated: true)
    }
    
    func navigateToTaskAdd(){
        let taskAddViewController = TaskAddRouter.createModule()
        viewController?.navigationController?.pushViewController(taskAddViewController, animated: true)
    }
}
