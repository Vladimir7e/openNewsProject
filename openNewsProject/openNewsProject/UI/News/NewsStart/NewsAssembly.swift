//
//  EmailedAssembly.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit
import CarPlay

protocol INewsAssembly {
    func assemble(newsType: ModelType) -> UIViewController
}

final class NewsAssembly: INewsAssembly {
    func assemble(newsType: ModelType) -> UIViewController {
        let detailAssembly: DetailAssembly = DetailAssembly()
        let router: NewsRouter = NewsRouter(detailAssembly: detailAssembly)
        let viewModelFactory: NewsViewModelFactory = NewsViewModelFactory()
        let storage: Storage = Storage()
        
        let presenter: NewsPresenter = NewsPresenter(
            networkService: newsType.servise,
            viewModelFactory: viewModelFactory,
            router: router,
            newsType: newsType,
            storage: storage
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
