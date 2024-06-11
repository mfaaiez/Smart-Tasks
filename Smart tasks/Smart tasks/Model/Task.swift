//
//  Task.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 09/06/2024.
//

import Foundation

struct Task: Decodable {
    let taskData: [TaskData]?
    
    enum CodingKeys: String, CodingKey {
        case taskData = "tasks"
    }
}

// MARK: - EmployeeData
struct TaskData: Decodable {
    var id, targetDate, dueDate, title, description, status, comment: String?
    let priority: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case targetDate = "TargetDate"
        case dueDate = "DueDate"
        case title = "Title"
        case description = "Description"
        case priority = "Priority"
        case status
        case comment
    }
    
}
