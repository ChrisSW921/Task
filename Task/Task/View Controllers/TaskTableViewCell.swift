//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Chris Withers on 1/13/21.
//

import UIKit

protocol TaskCompletionDeleage: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var completionButton: UIButton!
    
    var task: Task? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDeleage?
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
    func updateViews(){
        guard let currentTask = task else{return}
        taskNameLabel.text = currentTask.name
        if currentTask.isComplete{
            //completionButton.imageView?.image = UIImage(named: "complete")
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        }else{
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
}
