//
//  ToDo.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 12.12.21.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?

    static var loadSampleToDos: [ToDo] {
        return [
            ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes1"),
            ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes2"),
            ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes3")
        ]
    }

    static let todosURL: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let todosURL = urls.first
        else { fatalError() }

        return todosURL.appendingPathComponent("todos").appendingPathExtension("plist")
    }()

    static var loadeSaveToDosFile: [ToDo] {
        get {
            guard let data = try? Data(contentsOf: todosURL)
            else { return loadSampleToDos}

            let todos = try? PropertyListDecoder().decode([ToDo].self, from: data)
            return todos ?? loadSampleToDos
        }

        set {
            guard let data = try? PropertyListEncoder().encode(newValue)
            else { return }

            try? data.write(to: todosURL)
        }
    }

    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }

}
