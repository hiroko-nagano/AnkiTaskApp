//
//  ListTableViewCell.swift
//  ankiTaskApp
//
//  Created by hiroko nagano on 2020/09/01.
//  Copyright © 2020 hiroko.nagano. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    var task: Task!
    var receiveddate : String?
    
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setTaskArray(_ task: Task) {
        
        let cellText = task.title
        cellLabel.text = "\(cellText)"
        
        if task.finishbutton == false {
            self.cellLabel.textColor = UIColor.gray
            self.finishButton.tintColor = UIColor.gray
        } else {
            self.cellLabel.textColor = UIColor.black
            self.finishButton.tintColor = UIColor.systemBlue
        }
    }
    
}
