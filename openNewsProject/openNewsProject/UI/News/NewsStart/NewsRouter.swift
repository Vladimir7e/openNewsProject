//
//  Router.swift
//  openNewsProject
//
//  Created by Developer on 31.05.2022.
//

import UIKit

protocol INewsRouter {
    func showDetailScreen(detailViewModel: DetailViewModel)
}

final class NewsRouter: INewsRouter {

    // Dependencies
    weak var transitionHandler: UIViewController?

    let detailAssembly: IDetailAssembly

    init(detailAssembly: IDetailAssembly) {
        self.detailAssembly = detailAssembly
    }
    
    func showDetailScreen(detailViewModel: DetailViewModel) {
        let viewController: UIViewController = detailAssembly.assemble(detailViewModel: detailViewModel)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}
