//
//  TaskViewModel.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 09/06/2024.
//

import UIKit

class TaskViewModel: NSObject {

    private(set) var tasks : [TaskData]! {
        didSet {
            self.bindTaskViewModelToController()
        }
    }
    
    private var tasksArrayOriginial = [TaskData]()
    var bindTaskViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        performNetworkRequestToFetchTasks()
    }
    
    func performNetworkRequestToFetchTasks() {
        NetworkHandler.shared.fetchTask(urlString: APIEndpoint.tasks.rawValue) { (result : Result<Task,Error>) in
            switch result {
            case .success(let task):
                self.tasksArrayOriginial = task.taskData ?? [TaskData]()
                DispatchQueue.main.async {
                    CoreDataHandler.shared.insertTasks(tasksArray: self.tasksArrayOriginial)
                }
                self.filterTasks(withDate: Date().currentDate())
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func filterTasks(withDate date:Date) {
        var array = tasksArrayOriginial.filter { $0.targetDate?.toDate() == date }
        array.sort { (object1, object2) -> Bool in
            if object1.priority == object2.priority {
                guard let date1 = object1.targetDate?.toDate(), let date2 = object2.targetDate?.toDate() else {return false}
                return date1 < date2
            } else {
                guard let priority1 = object1.priority, let priority2 = object2.priority else {return false}
                return priority1 > priority2
            }
        }
        DispatchQueue.main.async {
            CoreDataHandler.shared.fetchTasks { tasks in
                if let tasks = tasks {
                    for (index, object1) in array.enumerated() {
                        if let indexInArray2 = tasks.firstIndex(where: { $0.id == object1.id }) {
                            // Replace object in array1 with corresponding object from array2
                            array[index].status = tasks[indexInArray2].status
                            array[index].comment = tasks[indexInArray2].comment
                        }
                    }
                }
                self.tasks = array
            }
        }
    }
    
}
