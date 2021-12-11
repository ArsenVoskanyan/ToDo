//
//  ToDo.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 09.12.21.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String

    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }

    static let todosURL: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentsURL = urls.first
        else { fatalError() }

        return documentsURL.appendingPathComponent("todos").appendingPathExtension("plist")
    }()

    static var file: [ToDo] {
        get {
            guard let todosData = try? Data(contentsOf: todosURL)
            else { return loadSampleToDos}

            let todos = try? PropertyListDecoder().decode([ToDo].self, from: todosData)
            return todos ?? loadSampleToDos
        }

        set {
            guard let data = try? PropertyListEncoder().encode(newValue)
            else { return }

            try? data.write(to: todosURL)
        }
    }

    static var loadSampleToDos: [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
}
