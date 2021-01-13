//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Chris Withers on 1/13/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var taskNotesTextview: UITextView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var selectedTask: Task?
    var date: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else{return}
        let taskNotes = taskNotesTextview.text
        
        if let currentTask = selectedTask {
            currentTask.name = taskName
            currentTask.notes = taskNotes
            currentTask.dueDate = date
            TaskController.shared.saveToPersistenceStore()
            navigationController?.popViewController(animated: true)
        }else{
            let newTask = Task(name: taskName, notes: taskNotes, dueDate: date)
            TaskController.shared.tasks.append(newTask)
            TaskController.shared.saveToPersistenceStore()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        date = taskDueDatePicker.date
    }
    
    func updateViews(){
        if let currentTask = selectedTask {
            let taskNotes = currentTask.notes ?? "Enter notes here"
            let taskDate = currentTask.dueDate ?? Date()
            taskNotesTextview.text = taskNotes
            taskNameTextField.text = currentTask.name
            taskDueDatePicker.date = taskDate
        }
    }


}
