//
//  Router.swift
//  openNewsProject
//
//  Created by Developer on 31.05.2022.
//

import UIKit

protocol INewsRouter {
//    func showDetailScreen(detailViewModel: DetailViewModel)
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
    
    func showDescriptionScreen(newsModel: News) {
        let viewController: UIViewController = descriptionAssembly.assemble(newsModel: newsModel)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
    
//    func showDetailScreen(detailViewModel: DetailViewModel) {
//        let viewController: UIViewController = detailAssembly.assemble(detailViewModel: detailViewModel)
//        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
//    }
}
