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
            return ToDoDetailTableViewController(coder: coder, delegate: self, todo: todos[indexPath.row])
        } else {
            return ToDoDetailTableViewController(coder: coder, delegate: self, todo: nil)
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellId", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
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
    
}

