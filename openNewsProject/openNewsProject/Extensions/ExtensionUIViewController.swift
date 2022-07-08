//
//  ExtensionUIViewController.swift
//  openNewsProject
//
//  Created by Developer on 07.07.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentErrorAlert(message: String) {
        
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
