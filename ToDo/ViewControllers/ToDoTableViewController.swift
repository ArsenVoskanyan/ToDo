//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 12.12.21.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = ToDo.loadeSaveToDosFile { didSet {
        ToDo.loadeSaveToDosFile = todos
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
