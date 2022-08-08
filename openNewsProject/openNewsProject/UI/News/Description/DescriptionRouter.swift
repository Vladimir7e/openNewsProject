//
//  DescriptionRouter.swift
//  openNewsProject
//
//  Created by Developer on 01.08.2022.
//

import UIKit

protocol IDescriptionRouter {
    func showDetailScreen(detailViewModel: DetailViewModel)

}

final class DescriptionRouter: IDescriptionRouter {
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
    
    func showDetailScreen(detailViewModel: DetailViewModel) {
        let viewController: UIViewController = detailAssembly.assemble(detailViewModel: detailViewModel)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}