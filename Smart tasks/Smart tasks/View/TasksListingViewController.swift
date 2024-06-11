//
//  TasksListingViewController.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 08/06/2024.
//

import UIKit

class TasksListingViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblTasks: UITableView! {
        didSet {
            tblTasks.delegate = self
            tblTasks.dataSource = self
            tblTasks.estimatedRowHeight = 96.0
            tblTasks.rowHeight = UITableView.automaticDimension
            tblTasks.separatorStyle = .none
        }
    }
    @IBOutlet weak var imgNoTasks: UIImageView!
    @IBOutlet weak var lblNoTasks: UILabel!
    
    // MARK: - Variables
    private var taskViewModel: TaskViewModel?
    var currentDate = Date().currentDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskViewModel = TaskViewModel()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTitle()
        taskViewModel?.filterTasks(withDate: currentDate)
    }
    
    func updateViews() {
        taskViewModel?.bindTaskViewModelToController = {
            if let array = self.taskViewModel?.tasks {
                if array.count > 0 {
                    self.showNoTasksDesign(shouldShow: false)
                    DispatchQueue.main.async {
                        self.tblTasks.reloadData()
                    }
                } else {
                    self.showNoTasksDesign()
                }
            } else {
                self.showNoTasksDesign()
            }
            
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapPrevious(_ sender: Any) {
        currentDate = currentDate.previousDate()
        setTitle()
        taskViewModel?.filterTasks(withDate: currentDate)
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        currentDate = currentDate.nextDate()
        setTitle()
        taskViewModel?.filterTasks(withDate: currentDate)
    }
    
}

// MARK: - Table view delegate and datasource methods
extension TasksListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let array = taskViewModel?.tasks {
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.taskCellIdentifier, for: indexPath) as? TaskTableViewCell {
            if let task = taskViewModel?.tasks[indexPath.section] {
                cell.setCellDesign(task: task)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let task = taskViewModel?.tasks[indexPath.section] {
            let taskStoryboard = UIStoryboard(name: "Tasks", bundle: nil)
            if let taskDetailsVC = taskStoryboard.instantiateViewController(withIdentifier: "TaskDetailsViewController") as? TaskDetailsViewController {
                taskDetailsVC.task = task
                self.navigationController?.pushViewController(taskDetailsVC, animated: true)
            }
        }
    }
    
}

// MARK: - Design update functions
extension TasksListingViewController {
    
    func showNoTasksDesign(shouldShow: Bool = true) {
        DispatchQueue.main.async {
            self.imgNoTasks.isHidden = !shouldShow
            self.lblNoTasks.isHidden = !shouldShow
            self.tblTasks.isHidden = shouldShow
        }
    }
    
    func setTitle() {
        if currentDate == Date().currentDate() {
            lblTitle.text = "Today"
        } else {
            lblTitle.text = currentDate.toDisplayDateString()
        }
    }
    
}
