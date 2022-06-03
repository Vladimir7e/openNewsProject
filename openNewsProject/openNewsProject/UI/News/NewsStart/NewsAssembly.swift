//
//  EmailedAssembly.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol INewsAssembly {
    func assemble(newsType: TabBarItemType) -> UIViewController
}

final class NewsAssembly: INewsAssembly {
    
    func assemble(newsType: TabBarItemType) -> UIViewController {
        let detailAssembly: DetailAssembly = DetailAssembly()
        let router: NewsRouter = NewsRouter(detailAssembly: detailAssembly)
        let networkService: NewsNetworkService = NewsNetworkService()
        let viewModelFactory: NewsViewModelFactory = NewsViewModelFactory()
        
        let presenter: NewsPresenter = NewsPresenter(
            networkService: networkService,
            viewModelFactory: viewModelFactory,
            router: router,
            newsType: newsType
        )
        
        let cellTypeResolver: NewsCellTypeResolver = NewsCellTypeResolver()
        
        let view: NewsViewController = NewsViewController(
            presenter: presenter,
            cellTypeResolver: cellTypeResolver
        )
        
        presenter.view = view
        router.transitionHandler = view

        return view
    }
}
