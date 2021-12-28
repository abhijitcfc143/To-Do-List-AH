//
//  TaskSection.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 25/12/21.
//

import Foundation

class TaskSection {
    var sectionIndex : Int?
    var sectionTitle : String?
    var tasks : [ToDoTask]?
    
    init(sectionIndex:Int?,sectionTitle:String?,tasks:[ToDoTask]?) {
        self.sectionIndex = sectionIndex
        self.sectionTitle = sectionTitle
        self.tasks = tasks
    }
}
