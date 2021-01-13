//
//  File.swift
//  Task
//
//  Created by Chris Withers on 1/13/21.
//

import Foundation

class TaskController {
    
    static var shared = TaskController()
    
    var tasks: [Task] = []
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?){
        guard let taskNotes = notes else {return}
        guard let taskDate = dueDate else {return}
        let newTask = Task(name: name, notes: taskNotes, dueDate: taskDate)
        tasks.append(newTask)
        saveToPersistenceStore()
        
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        guard let newNotes = notes else {return}
        guard let newDate = dueDate else {return}
        task.name = name
        task.notes = newNotes
        task.dueDate = newDate
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    func delete(task: Task){
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK:- Persistence functions
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Task.json")
        return fileURL
        
    }
    
    //save
    func saveToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL())
        }catch{
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    //load
    func loadFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: fileURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        }catch {
            print("Error loading data \(error.localizedDescription)")
        }
        
    }
    
}
