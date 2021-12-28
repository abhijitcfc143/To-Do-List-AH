//
//  SectionHeaderTableViewCell.swift
//  To-Do-List-AH
//
//  Created by Abhijit Hadkar on 25/12/21.
//

import UIKit

protocol AddTaskButtonDelegate {
    func addTaskButtonPressed(section: Int,indexPath:IndexPath?)
}

class SectionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    var section : Int! = 0
    var addButtonDelegate : AddTaskButtonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK:- Add Button Action
    @IBAction func addButtonTapped(_ sender: Any) {
        self.addButtonDelegate?.addTaskButtonPressed(section:section,indexPath: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
