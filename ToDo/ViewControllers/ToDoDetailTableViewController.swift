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
}
