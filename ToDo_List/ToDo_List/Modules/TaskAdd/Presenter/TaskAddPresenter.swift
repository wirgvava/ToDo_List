//
//  TaskAddPresenter.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 31.08.24.
//

import Foundation

protocol TaskAddPresenterProtocol: AnyObject {
    func popViewController()
    func save(title: String, description: String)
}

class TaskAddPresenter: TaskAddPresenterProtocol {
    weak var view: TaskAddViewProtocol?
    var router: TaskAddRouterProtocol?
    
    func save(title: String, description: String) {
        router?.save(title: title, description: description)
        router?.popViewcontroller()
    }
    
    func popViewController() {
        router?.popViewcontroller()
    }
}
