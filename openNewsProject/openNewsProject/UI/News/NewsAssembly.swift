//
//  EmailedAssembly.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

final class NewsAssembly {
    
    func assemble(newsType: TabBarItemType) -> UIViewController {
//        let homeViewModelFactory: HomeViewModelFactory = HomeViewModelFactory()
//        let router: HomeRouter = HomeRouter()
        let networkService: NewsNetworkService = NewsNetworkService()
        let viewModelFactory: NewsViewModelFactory = NewsViewModelFactory()
        let presenter: NewsPresenter = NewsPresenter(
            networkService: networkService,
            viewModelFactory: viewModelFactory,
            newsType: newsType
        )
        let cellTypeResolver: NewsCellTypeResolver = NewsCellTypeResolver()
        let view: NewsViewController = NewsViewController(
            presenter: presenter,
            cellTypeResolver: cellTypeResolver
        )
        presenter.view = view
//        router.transitionHandler = view

        return view
    }
}
