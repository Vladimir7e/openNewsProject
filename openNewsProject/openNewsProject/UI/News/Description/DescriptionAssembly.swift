//
//  DescriptionAssembly.swift
//  openNewsProject
//
//  Created by Developer on 27.07.2022.
//

import UIKit

protocol IDescriptionAssembly {
    func assemble(newsModel: News) -> UIViewController
}

final class DescriptionAssembly: IDescriptionAssembly {
    func assemble(newsModel: News) -> UIViewController {
        let detailAssembly: DetailAssembly = DetailAssembly()
        let descriptionAssembly: DescriptionAssembly = DescriptionAssembly()
        let storage: Storage = Storage()
        let viewModelFactory: DescriptionViewModelFactory = DescriptionViewModelFactory()
        let router: DescriptionRouter = DescriptionRouter(detailAssembly: detailAssembly, descriptionAssembly: descriptionAssembly)
        let presenter: DescriptionPresenter = DescriptionPresenter(
            newsModel: newsModel,
            viewModelFactory: viewModelFactory,
            router: router,
            storage: storage
        )
        
        let view: DescriptionViewController = DescriptionViewController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        
        return view
    }
}
