//
//  TaskDetailPresenter.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import UIKit

protocol TaskDetailPresenterProtocol: AnyObject {
    func popViewController()
    func edit(task: TaskModel)
    func editMode()
    func save(task: TaskModel)
}

class TaskDetailPresenter: TaskDetailPresenterProtocol {
    weak var view: TaskDetailViewControllerProtocol?
    var router: TaskDetailRouterProtocol?
    
    func popViewController() {
        router?.popViewController()
    }
   
    func edit(task: TaskModel) {
        router?.edit(task: task)
    }
    
    func editMode(){
        view?.editMode()
    }
    
    func save(task: TaskModel) {
        router?.save(task: task)
    }
}
