//
//  TaskDetailViewController.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import UIKit

protocol TaskDetailViewControllerProtocol: AnyObject {
    func editMode()
}

class TaskDetailViewController: UIViewController {
    var presenter: TaskDetailPresenterProtocol?
    
    // MARK: - IBOutlets
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var headerTextViewHeight: NSLayoutConstraint!
    
    // - Data
    var task: TaskModel?
    private var buttonType: ButtonType = .edit
    
    enum ButtonType {
        case edit
        case save
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - IBActions
    @IBAction func didTapOnBackButton(){
        presenter?.popViewController()
    }
    
    @IBAction func didTapOnEditButton(){
        editButtonAction()
    }
}

// MARK: - Configure
extension TaskDetailViewController {
    private func configure(){
        guard let date = task?.createdAt else { return }
        self.setup(date: date)
        self.headerTextView.text = task?.title
        self.descriptionTextView.text = task?.taskDescription
        self.headerTextViewHeight.constant = self.headerTextView.contentSize.height
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setup(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
    
    private func editButtonAction(){
        if buttonType == .edit {
            presenter?.edit(task: task!)
        } else if buttonType == .save {
            editButton.setTitle("Edit", for: .normal)
            buttonType = .edit
            headerTextView.isEditable = false
            descriptionTextView.isEditable = false
            setup(date: .now)
            task?.title = headerTextView.text
            task?.taskDescription = descriptionTextView.text
            task?.createdAt = .now
            presenter?.save(task: task!)
        }
    }
}

// MARK: - TaskDetailViewControllerProtocol
extension TaskDetailViewController: TaskDetailViewControllerProtocol {
    func editMode() {
        editButton.setTitle("Save", for: .normal)
        buttonType = .save
        headerTextView.isEditable = true
        descriptionTextView.isEditable = true
    }
}
