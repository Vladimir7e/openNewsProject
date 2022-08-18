//
//  Router.swift
//  openNewsProject
//
//  Created by Developer on 31.05.2022.
//

import UIKit

protocol INewsRouter {
    func showDescriptionScreen(newsModel: News)
}

final class NewsRouter: INewsRouter {
    // Dependencies
    weak var transitionHandler: UIViewController?
    let detailAssembly: IDetailAssembly
    let descriptionAssembly: IDescriptionAssembly

    // MARK: - Initialization
    init(detailAssembly: IDetailAssembly,
         descriptionAssembly: IDescriptionAssembly) {
        self.detailAssembly = detailAssembly
        self.descriptionAssembly = descriptionAssembly
    }
    
//    func showDescriptionScreen(newsModel: News) {
//        let viewController: UIViewController = descriptionAssembly.assemble(newsModel: newsModel)
//        let nc: UINavigationController = UINavigationController(rootViewController: viewController)
//        nc.modalPresentationStyle = .overFullScreen
//        transitionHandler?.navigationController?.present(nc, animated: true, completion: nil)
//    }
    
    func showDescriptionScreen(newsModel: News) {
        let viewController: UIViewController = descriptionAssembly.assemble(newsModel: newsModel)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}
