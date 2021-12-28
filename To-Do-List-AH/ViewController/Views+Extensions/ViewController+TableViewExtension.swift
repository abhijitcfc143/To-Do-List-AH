//
//  ViewController+TableViewExtension.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 24/12/21.
//

import Foundation
import UIKit

enum TaskType : String {
    case today = "today"
    case tomorrow = "tomorrow"
    case upcoming = "upcoming"
}

extension ViewController : UITableViewDelegate,UITableViewDataSource,AddTaskButtonDelegate{
    
    // MARK:- Delegate and Common method to Add/Update the task
    func addTaskButtonPressed(section: Int,indexPath:IndexPath?) {
        let alertTitle = indexPath == nil ? "Add" : "Update"
        let alert = UIAlertController(title: alertTitle + " Task", message: "", preferredStyle: .alert)
        
        alert.addTextField { [weak self] (title) in
            title.text = indexPath == nil ? "" : self?.sectionViewModel.taskSections[indexPath!.section].tasks![indexPath!.row].title
            title.placeholder = "Task Title:"
        }
        alert.addTextField { [weak self] (taskDescription) in
            taskDescription.text = indexPath == nil ? "" : self?.sectionViewModel.taskSections[indexPath!.section].tasks![indexPath!.row].taskDescription
            taskDescription.placeholder = "Task Description:"
        }
        
        
        alert.addAction(UIAlertAction(title: alertTitle, style: .default, handler: { [weak self]_ in
            guard let titleTextField = alert.textFields?.first,let title = titleTextField.text,!title.isEmpty else{
                return
            }
            
            let taskDescriptionTextField = alert.textFields![1]
            
            var taskType = TaskType.today.rawValue
            
            switch section {
            case 0:
                taskType = TaskType.today.rawValue
            case 1:
                taskType = TaskType.tomorrow.rawValue
            case 2:
                taskType = TaskType.upcoming.rawValue
            default:
                taskType = TaskType.today.rawValue
            }
            
            if (indexPath == nil){
                    self?.sectionViewModel.createTask(title: title, taskDescription: taskDescriptionTextField.text, taskType: taskType)
            }else{
                let oldTask = self?.sectionViewModel.taskSections[indexPath!.section].tasks![indexPath!.row]
                
                self?.sectionViewModel.updateTask(task: oldTask!, newTitle: title,newTaskDescription:taskDescriptionTextField.text)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Setup Initial things for TableView
    func setupTableViewDelegateDataSource() {
        self.tasksTableView.delegate = self
        self.tasksTableView.dataSource = self
        self.tasksTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tasksTableView.register(UINib(nibName: TableViewCells.sectionHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCells.sectionHeaderTableViewCell)
        self.tasksTableView.estimatedRowHeight = 100
        self.tasksTableView.rowHeight = UITableView.automaticDimension
        self.tasksTableView.separatorStyle = .singleLine
    }
    
    // MARK:- TableView Delegates and DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionViewModel.taskSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !(self.sectionViewModel.taskSections.isEmpty) ? (self.sectionViewModel.taskSections[section].tasks?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var content = cell?.defaultContentConfiguration()
        content?.text = self.sectionViewModel.taskSections[indexPath.section].tasks![indexPath.row].title
        content?.secondaryText = self.sectionViewModel.taskSections[indexPath.section].tasks![indexPath.row].taskDescription
        cell?.contentConfiguration = content
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Task", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertAction.Style.default, handler: { [weak self] editAction in
            self?.addTaskButtonPressed(section: indexPath.section, indexPath: indexPath)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { [weak self] deleteAction in
            
            guard let task = self?.sectionViewModel.taskSections[indexPath.section].tasks![indexPath.row] else {
                return
            }
            self?.sectionViewModel.deleteTask(task: task)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.sectionHeaderTableViewCell) as! SectionHeaderTableViewCell
        headerCell.addButtonDelegate = self
        headerCell.section = section
        headerCell.sectionHeaderLabel.text = self.sectionViewModel.taskSections[section].sectionTitle
        return headerCell
    }
    
}
