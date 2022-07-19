//
//  ErrorAlert.swift
//  openNewsProject
//
//  Created by Developer on 11.07.2022.
//

import Foundation
import UIKit

protocol ErrorAlertProtocol {
    func presentErrorAlert(item: ErrorItemProtocol)
}

protocol ErrorItemProtocol {
    var title: String? { get }
    var message: String? { get }
}

extension ErrorAlertProtocol where Self: UIViewController {
    func presentErrorAlert(item: ErrorItemProtocol) {
        let alert: UIAlertController = UIAlertController(
            title: item.title, message: item.message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
