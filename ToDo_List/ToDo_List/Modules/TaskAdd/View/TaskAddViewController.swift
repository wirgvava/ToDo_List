//
//  TaskAddViewController.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 31.08.24.
//

import UIKit

protocol TaskAddViewProtocol: AnyObject {
    
}

class TaskAddViewController: UIViewController, TaskAddViewProtocol{
    var presenter: TaskAddPresenterProtocol?
    
    // MARK: - IBOutlets
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var headerField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - IBActions
    @IBAction func didTapOnBackButton(){
        presenter?.popViewController()
    }
    
    @IBAction func didTapOnSaveButton(){
        let title = headerField.textColor == UIColor.secondaryLabel ? "" : headerField.text ?? ""
        let description = descriptionField.textColor == UIColor.secondaryLabel ? "" : descriptionField.text ?? ""
    
        presenter?.save(title: title, description: description)
    }
    
    private func configure(){
        saveButton.isEnabled = false
        headerField.delegate = self
        descriptionField.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - UITextFieldDelegate
extension TaskAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView {
        case headerField:
            textView.text = nil
            textView.textColor = UIColor.label
        case descriptionField:
            textView.text = nil
            textView.textColor = UIColor.label
        default:
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            switch textView {
            case headerField:
                textView.text = "Header"
                textView.textColor = UIColor.secondaryLabel
            case descriptionField:
                textView.text = "What's on your mind?"
                textView.textColor = UIColor.secondaryLabel
            default:
                break
            }
            
            saveButton.isEnabled = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if headerField.text != "" || descriptionField.text != "" {
            saveButton.isEnabled = true
        } 
    }
}
