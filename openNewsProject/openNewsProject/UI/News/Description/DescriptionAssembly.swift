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
        let storage: Storage = Storage()
        let viewModelFactory: DescriptionViewModelFactory = DescriptionViewModelFactory()
        let presenter: DescriptionPresenter = DescriptionPresenter(
            newsModel: newsModel,
            viewModelFactory: viewModelFactory,
            storage: storage
        )
        
        let view: DescriptionViewController = DescriptionViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
