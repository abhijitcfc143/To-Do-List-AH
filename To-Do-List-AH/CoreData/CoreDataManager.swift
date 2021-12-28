//
//  CoreDataManager.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 27/12/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchTasks() -> [NSManagedObject]?{

        do {
            // return CoreData's item
            let fetchedCoreData = try context.fetch(ToDoTask.fetchRequest())
            return fetchedCoreData
        } catch  {
            print("Error Fetching the tasks")
        }
        
        return nil
    }
    
    func createTask(title: String,taskDescription:String?,taskType:String?){
        let task = ToDoTask(context:context)
        task.title = title
        task.taskDescription = taskDescription
        task.taskType = taskType
        
        do {
            try context.save()
        } catch  {
            print("Error Creating the task")
        }
    }
    
    func deleteTask(task:ToDoTask){
        context.delete(task)        
        do {
            try context.save()
        } catch  {
            print("Error Deleting the task")
        }
    }
    
    func updateTask(task:ToDoTask, newTitle:String, newTaskDescription:String?){
        task.title = newTitle
        task.taskDescription = newTaskDescription
        
        do {
            try context.save()
        } catch  {
            print("Error Updating the task")
        }
    }
}
