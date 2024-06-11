//
//  UIViewController+Extensions.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 11/06/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(withYesHandler yes: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: "Confirmation!", message: "Do you want to left comment", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add Comment"
        }
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            yes(textField?.text)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [weak alert] (_) in
            print(alert!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
