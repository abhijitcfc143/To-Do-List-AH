//
//  SectionViewModel.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 27/12/21.
//

import Foundation

protocol SectionViewModelDelegate : AnyObject{
    func getDataSuccessfully()
}

class SectionViewModel{
    var taskSections = [TaskSection]()
    weak var sectionVMDelegate : SectionViewModelDelegate?
    
    init(sectionVMDelegate: SectionViewModelDelegate) {
        self.sectionVMDelegate = sectionVMDelegate
        
    }
        
    // MARK:- Create Default Section
    func createSections(){
        
        for i in 0..<3{
            var sectionTitle = ""
            switch i {
            case 0:
                sectionTitle = TaskType.today.rawValue.capitalized
            case 1:
                sectionTitle = TaskType.tomorrow.rawValue.capitalized
            case 2:
                sectionTitle = TaskType.upcoming.rawValue.capitalized
            default:
                sectionTitle = TaskType.today.rawValue.capitalized
            }
            
            let section = TaskSection(sectionIndex: i, sectionTitle: sectionTitle, tasks: [])
            taskSections.append(section)
        }
    }
    
    // MARK:- Fetch Data from CoreData
    func fetchData() {
        self.taskSections.removeAll()
        self.createSections()
        guard let fetchedCoreData = CoreDataManager.shared.fetchTasks() as? [ToDoTask] else{
            return
        }
                        
        // Segregate Data in the Sections Based on TaskType
        for coreDataObj in fetchedCoreData{
                            
            switch coreDataObj.taskType {
            case TaskType.today.rawValue:
                    taskSections[0].tasks?.append(coreDataObj)
            case TaskType.tomorrow.rawValue:
                    taskSections[1].tasks?.append(coreDataObj)
            case TaskType.upcoming.rawValue:
                    taskSections[2].tasks?.append(coreDataObj)
            default:
                print("No section")
            }
        }
        sectionVMDelegate?.getDataSuccessfully()
    }
    
    // MARK:- Create ToDoTask
    func createTask(title: String, taskDescription: String?, taskType: String?) {        
        CoreDataManager.shared.createTask(title: title, taskDescription: taskDescription, taskType: taskType)
        self.fetchData()
        sectionVMDelegate?.getDataSuccessfully()
    }
    
    // MARK:- Delete ToDoTask
    func deleteTask(task: ToDoTask) {
        CoreDataManager.shared.deleteTask(task: task)
        self.fetchData()
        sectionVMDelegate?.getDataSuccessfully()
    }
    
    // MARK:- Update ToDoTask
    func updateTask(task:ToDoTask, newTitle:String, newTaskDescription:String?){
        CoreDataManager.shared.updateTask(task: task, newTitle: newTitle, newTaskDescription: newTaskDescription)
        self.fetchData()
        sectionVMDelegate?.getDataSuccessfully()
    }
}
