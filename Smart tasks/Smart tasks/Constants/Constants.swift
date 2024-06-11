//
//  Constants.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 09/06/2024.
//

import UIKit

class Constants: NSObject {

    // MARK: - Task table view cell identifier
    static let taskCellIdentifier = "taskCell"
    
    // MARK: - Date format for operations
    static let dateFormat = "yyyy-MM-dd"
    
    // MARK: - Date format for displaying dates in views
    static let displayDateFormat = "MMM dd yyyy"
    
}

// MARK: - Enum for API endpoints
enum APIEndpoint:String {
    case tasks = "http://demo1414406.mockable.io/"
}
