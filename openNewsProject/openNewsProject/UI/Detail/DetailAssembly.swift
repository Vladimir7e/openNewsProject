//
//  DetailAssembly.swift
//  openNewsProject
//
//  Created by Developer on 31.05.2022.
//

import UIKit

protocol IDetailAssembly {
    func assemble(detailViewModel: DetailViewModel) -> UIViewController
}

final class DetailAssembly: IDetailAssembly {
    
    func assemble(detailViewModel: DetailViewModel) -> UIViewController {
        let networkService: NewsNetworkService = NewsNetworkService()

        let presenter: DetailPresenter = DetailPresenter(
            networkService: networkService,
            viewModel: detailViewModel
        )
        
        let view: DetailViewController = DetailViewController(presenter: presenter)
        presenter.view = view

        return view
    }
}
