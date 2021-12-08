//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 08.12.21.
//

import UIKit

class ToDoListViewController: UIViewController {
    var todos = [ToDo]()

    @IBOutlet weak var tableView: UITableView! { didSet {
        tableView.dataSource = self
        tableView.delegate = self
    }}

    override func viewDidLoad() {
        super.viewDidLoad()

        if let loadToDos = ToDo.file {
            todos = loadToDos
        } else {
            todos = ToDo.loadSampleToDos
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(
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
