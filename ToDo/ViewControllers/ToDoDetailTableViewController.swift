//
//  ToDoDetailTableViewController.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 15.12.21.
//

import UIKit

protocol ToDoDetailTableViewControllerDelegate: AnyObject {
    func didTapDone(todo: ToDo)
}

class ToDoDetailTableViewController: UITableViewController {
    init?(coder: NSCoder, delegate: ToDoDetailTableViewControllerDelegate?, initialToDo: ToDo?) {
        self.initialToDo = initialToDo
        self.delegate = delegate
        super .init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ToDoDetailTableViewControllerDelegate?
    var initialToDo: ToDo?

    var todo: ToDo? {
        guard let title = titleTextField.text,
              let notes = notesTextView.text
        else { fatalError() }

        return ToDo(
            id: initialToDo?.id ?? UUID().uuidString,
            title: title,
            isComplete: isCompleteButton.isSelected,
            dueDate: dueDatePickerView.date,
            notes: notes
        )
    }

    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        updateSaveButtonState()
        updateDueDateLabel(date: dueDatePickerView.date)
    }

    func configure() {
        if let todo = initialToDo {
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
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

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let todo = todo else { return }

        delegate?.didTapDone(todo: todo)
        dismiss(animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            dueDateLabel.textColor = .black
            updateDueDateLabel(date: dueDatePickerView.date)
            tableView.reloadData()
        }
    }
}
