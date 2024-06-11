//
//  Date+Extensions.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 09/06/2024.
//

import Foundation

extension Date {
    
    func currentDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        let dateString = dateFormatter.string(from: Date())
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    func nextDate() -> Date {
        var dateComponents = DateComponents()
        let calendar = Calendar.current
        dateComponents.day = 1
        let futureDate = calendar.date(byAdding: dateComponents, to: self)
        return futureDate ?? currentDate()
    }
    
    func previousDate() -> Date {
        var dateComponents = DateComponents()
        let calendar = Calendar.current
        dateComponents.day = -1
        let futureDate = calendar.date(byAdding: dateComponents, to: self)
        return futureDate ?? currentDate()
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        return dateFormatter.string(from: self)
    }
    
    func toDisplayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.displayDateFormat
        return dateFormatter.string(from: self)
    }
    
}
