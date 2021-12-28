//
//  ViewController+Extension.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 24/12/21.
//

import Foundation

extension ViewController : SectionViewModelDelegate{
    // MARK:- Fetch Data after CRUD operation of CoreData
    func getDataSuccessfully() {
        DispatchQueue.main.async {
            self.tasksTableView.reloadData()
        }
    }
    
    // MARK:- Initial Setup for controller
    func setupUI() {
        self.title = "Tasks"
        self.sectionViewModel = SectionViewModel(sectionVMDelegate: self)
        self.sectionViewModel.fetchData()
    }
}
