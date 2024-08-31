//
//  TaskCell.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var isCompletedBtn: UIButton!
    
    var index = 0
    private var isCompleted: Bool = false
    weak var view: TaskListViewProtocol?
    
    // - IBActions
    @IBAction func didTapOnIsCompletedBtn(){
        view?.updateTask(at: index, isCompleted: !isCompleted)
    }
    
    // - Set
    func configure(with task: TaskModel) {
        self.isCompleted = task.isCompleted
        title.text = task.title
        taskDescription.text = task.taskDescription
        isCompletedBtn.setTitle("", for: .normal)
        isCompletedBtn.setImage(task.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle"), for: .normal)
        set(date: task.createdAt)
    }
    
    private func set(date: Date?){
        guard let date = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLbl.text = dateFormatter.string(from: date)
    }
}
