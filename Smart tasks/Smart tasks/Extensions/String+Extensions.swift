//
//  String+Extensions.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 11/06/2024.
//

import Foundation

extension String {
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter.date(from: self) ?? Date()
    }
    
}
