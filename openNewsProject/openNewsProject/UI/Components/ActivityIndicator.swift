//
//  ActivityIndicator.swift
//  openNewsProject
//
//  Created by Developer on 11.07.2022.
//

import Foundation
import UIKit

protocol ActivityIndicatorProtocol {
    var activityIndicator: UIActivityIndicatorView { get }

    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicatorProtocol where Self: UIViewController {
    func showActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
