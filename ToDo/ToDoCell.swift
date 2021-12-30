//
//  ToDoCell.swift
//  ToDo
//
//  Created by Arsen Voskanyan on 25.12.21.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(cell: ToDoCell)
}

class ToDoCell: UITableViewCell {

    weak var delegate: ToDoCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(todo: ToDo) {
        titleLabel.text = todo.title
        isCompleteButton.isSelected = todo.isComplete
    }

    @IBAction func completedButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(cell: self)
    }
}
