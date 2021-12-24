//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 12.12.21.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = ToDo.todos { didSet {
        ToDo.todos = todos
    }}

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
    }

    @IBSegueAction func presentAddEditToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            return ToDoDetailTableViewController(coder: coder, delegate: self, initialToDo: todos[indexPath.row])
        } else {
            return ToDoDetailTableViewController(coder: coder, delegate: self, initialToDo: nil)
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellId", for: indexPath)
                as? ToDoCell
        else { fatalError() }

        let todo = todos[indexPath.row]
        cell.configure(todo: todo)
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

extension ToDoTableViewController: ToDoDetailTableViewControllerDelegate {
    func didTapDone(todo: ToDo) {
        if let index = todos.firstIndex(of: todo) {
            todos[index] = todo
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            todos.insert(todo, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }

}

extension ToDoTableViewController: ToDoCellDelegate {
    func checkmarkTapped(cell: ToDoCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            todos[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

