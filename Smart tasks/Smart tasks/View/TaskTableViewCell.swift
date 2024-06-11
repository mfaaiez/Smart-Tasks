//
//  TaskTableViewCell.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 09/06/2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var lblDaysLeft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellDesign(task:TaskData) {
        lblTitle.text = task.title
        lblDueDate.text = task.dueDate
        lblDaysLeft.text = String(Calendar(identifier: .gregorian).numberOfDaysBetween(Date().currentDate(), and: task.dueDate?.toDate() ?? Date()))
        if task.status?.lowercased() == "resolved" {
            lblTitle.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
            lblDueDate.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
            lblDaysLeft.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
        } else {
            lblTitle.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            lblDueDate.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            lblDaysLeft.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
        }
    }

}
