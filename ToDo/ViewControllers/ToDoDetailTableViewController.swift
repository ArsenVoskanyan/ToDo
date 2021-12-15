//
//  ToDoDetailTableViewController.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 15.12.21.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateSaveButtonState()
        updateDueDateLabel(date: dueDatePickerView.date)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    func updateSaveButtonState() {
        let isValid = !(titleTextField.text?.isEmpty ?? true)
        saveButton.isEnabled = isValid
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }

    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
}
