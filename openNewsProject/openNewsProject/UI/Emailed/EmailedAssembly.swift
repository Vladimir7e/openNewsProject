//
//  EmailedAssembly.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

final class EmailedAssembly {
    
    func assemble() -> UIViewController {
//        let homeViewModelFactory: HomeViewModelFactory = HomeViewModelFactory()
//        let router: HomeRouter = HomeRouter()
        let networkService: EmailedNetworkService = EmailedNetworkService()
        let viewModelFactory: EmailedViewModelFactory = EmailedViewModelFactory()
        let presenter: EmailedPresenter = EmailedPresenter(
            networkService: networkService,
            viewModelFactory: viewModelFactory
        )
        let cellTypeResolver: EmailedCellTypeResolver = EmailedCellTypeResolver()
        let view: EmailedViewController = EmailedViewController(
            presenter: presenter,
            cellTypeResolver: cellTypeResolver
        )
        presenter.view = view
//        router.transitionHandler = view

        return view
    }
}
