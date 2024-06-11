//
//  CoreDataHandler.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 11/06/2024.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    static let shared = CoreDataHandler()
    
    func insertTasks(tasksArray: [TaskData]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "Tasks", in: managedContext)!
        for task in tasksArray {
            let taskObject = NSManagedObject(entity: taskEntity, insertInto: managedContext)
            taskObject.setValue(task.id, forKey: "id")
            taskObject.setValue("Unresolved", forKey: "status")
            taskObject.setValue("", forKey: "comment")
        }
        do {
            try managedContext.save()
        } catch {
            print("error saving data")
        }
    }
    
    func fetchTasks(onSuccess: @escaping ([TaskData]?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            var tasksArray = [TaskData]()
            for data in result as! [NSManagedObject]
            {
                var task = TaskData(priority: 0)
                task.id = data.value(forKey: "id") as? String ?? ""
                task.status = data.value(forKey: "status") as? String ?? ""
                task.comment = data.value(forKey: "comment") as? String ?? ""
                tasksArray.append(task)
            }
            onSuccess(tasksArray)
        } catch {
            print("Failed to fetch data")
        }
    }
    
    func updateTaskStatus(task: TaskData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        request.predicate = NSPredicate(format: "id = %@", task.id ?? "")
        do {
            let data = try managedContext.fetch(request)
            let objectToUpdate = data.first as! NSManagedObject
            objectToUpdate.setValue(task.id, forKey: "id")
            objectToUpdate.setValue(task.status, forKey: "status")
            objectToUpdate.setValue(task.comment, forKey: "comment")
            do {
                try managedContext.save()
            } catch {
                print("error updating data")
            }
        } catch {
            print("Provided data not found in database.")
        }
    }
    
}
