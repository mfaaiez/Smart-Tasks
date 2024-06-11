//
//  TaskDetailsViewController.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 11/06/2024.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var lblNoOfDays: UILabel!
    @IBOutlet weak var lblTaskStatus: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var stackTaskActions: UIStackView!
    @IBOutlet weak var imgTaskStatus: UIImageView!
    
    // MARK: - Variables
    var task: TaskData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designViews()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapResolve(_ sender: Any) {
        self.showAlert { text in
            DispatchQueue.main.async {
                self.task.status = "Resolved"
                self.task.comment = text
                CoreDataHandler.shared.updateTaskStatus(task: self.task)
                self.stackTaskActions.isHidden = true
                self.designViews()
            }
        }
    }
    
    @IBAction func didTapCantResolve(_ sender: Any) {
        self.showAlert { text in
            DispatchQueue.main.async {
                self.task.status = "Can't Resolve"
                self.task.comment = text
                CoreDataHandler.shared.updateTaskStatus(task: self.task)
                self.stackTaskActions.isHidden = true
                self.designViews()
            }
        }
    }
}

// MARK: - Design update functions
extension TaskDetailsViewController {
    func designViews() {
        if let task = task {
            lblTitle.text = task.title
            lblDueDate.text = task.dueDate
            lblNoOfDays.text = String(Calendar(identifier: .gregorian).numberOfDaysBetween(Date().currentDate(), and: task.dueDate?.toDate() ?? Date()))
            lblTaskStatus.text = task.status?.isEmpty ?? true ? "Unresolved" : task.status
            txtDescription.text = task.description
            lblTitle.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            lblDueDate.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            lblTaskStatus.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            lblNoOfDays.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            if task.status?.lowercased() == "unresolved" {
                stackTaskActions.isHidden = false
                imgTaskStatus.isHidden = true
                lblTaskStatus.textColor = #colorLiteral(red: 1, green: 0.8709999919, blue: 0.3799999952, alpha: 1)
            } else if task.status?.lowercased() == "resolved" {
                stackTaskActions.isHidden = true
                imgTaskStatus.isHidden = false
                imgTaskStatus.image = UIImage(named: "sign_resolved")
                lblTitle.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
                lblDueDate.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
                lblTaskStatus.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
                lblNoOfDays.textColor = #colorLiteral(red: 0, green: 0.5370000005, blue: 0.4819999933, alpha: 1)
            } else if task.status?.lowercased() == "can't resolve" {
                stackTaskActions.isHidden = true
                imgTaskStatus.isHidden = false
                imgTaskStatus.image = UIImage(named: "unresolved_sign")
                lblTaskStatus.textColor = #colorLiteral(red: 0.9369999766, green: 0.2939999998, blue: 0.3689999878, alpha: 1)
            }
        }
    }
}
