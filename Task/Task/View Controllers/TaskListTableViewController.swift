//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Chris Withers on 1/13/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self

        cell.textLabel?.text = TaskController.shared.tasks[indexPath.row].name
        cell.task = TaskController.shared.tasks[indexPath.row]
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            TaskController.shared.delete(task: TaskController.shared.tasks[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTask"{
            if let destinationVC = segue.destination as? TaskDetailViewController{
                if let indexPath = tableView.indexPathForSelectedRow{
                    let selectedTask = TaskController.shared.tasks[indexPath.row]
                    destinationVC.selectedTask = selectedTask
                }
            }
        }
    }
    

}

extension TaskListTableViewController: TaskCompletionDeleage {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let taskToChange = sender.task else {return}
        TaskController.shared.toggleIsComplete(task: taskToChange)
        sender.updateViews()
    }
    
    
}
