//
//  TaskAddRouter.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 31.08.24.
//

import UIKit

protocol TaskAddRouterProtocol: AnyObject {
    func popViewcontroller()
    func save(title: String, description: String)
}

class TaskAddRouter {
    weak var viewController: UIViewController?
    weak var presenter: TaskAddPresenter?
    
    static func createModule() -> TaskAddViewController {
        let presenter = TaskAddPresenter()
        let router = TaskAddRouter()
        
        // View
        let storyboard = UIStoryboard(name: Storyboards.Name.TaskAdd, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: Storyboards.IDs.TaskAdd) as! TaskAddViewController
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        router.presenter = presenter
        
        return view
    }
}

extension TaskAddRouter: TaskAddRouterProtocol {
    func popViewcontroller() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func save(title: String, description: String) {
        CoreDataManager.shared.addTask(title: title, description: description)
        postNotification()
    }
    
    private func postNotification(){
        let center = NotificationCenter.default
        let taskUpdated = Notifications.taskUpdated.notificationName
        center.post(name: taskUpdated, object: nil)
    }
}
