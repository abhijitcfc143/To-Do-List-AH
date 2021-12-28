//
//  ViewController.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 24/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var sectionViewModel : SectionViewModel!
    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableViewDelegateDataSource()
    }

    

}


