//
//  DescriptionPresenter.swift
//  openNewsProject
//
//  Created by Developer on 27.07.2022.
//

import Foundation
import UIKit


protocol IDescriptionPresenter: AnyObject {
    func viewDidLoad()
    func didTapRightItemButton(isSelected: Bool)
    func some1()
}

class DescriptionPresenter {
    // Dependencies
    weak var view: IDescriptionViewController?
    private var viewModel: DescriptionViewModel?
    private let viewModelFactory: IDescriptionViewModelFactory
    private let router: IDescriptionRouter
    private let newsModel: News
    private let storage: Storable

    // MARK: - Initialization
    init(
        newsModel: News,
        viewModelFactory: IDescriptionViewModelFactory,
        router: IDescriptionRouter,
        storage: Storable
    ) {
        self.newsModel = newsModel
        self.viewModelFactory = viewModelFactory
        self.router = router
        self.storage = storage
    }
    
    private func updateModel(with news: News) {
        viewModel = viewModelFactory.makeViewModel(newsModels: news)
    }
    
    private func buttonAction(isSelected: Bool) {
        guard let viewModel = viewModel else {
            return
        }
        if isSelected {
           
            storage.save(model: viewModel)
        } else {
            storage.remove(id: viewModel.id)
        }
    }
    
    private func buttonLogic() {
        let models: [DescriptionViewModel] = storage.fetchData()
        guard let viewModel = viewModel else {
            return
        }
        for model in models where model.id == viewModel.id {
            view?.setButtonState(isSelected: true)
        }
    }
    
    private func showDetailScreen(detailViewModel: DetailViewModel) {
        router.showDetailScreen(detailViewModel: detailViewModel)
    }
}

extension DescriptionPresenter: IDescriptionPresenter {
    func viewDidLoad() {
        updateModel(with: newsModel)
        
        guard let viewModel = viewModel else {
            return
        }
        buttonLogic()
        view?.setup(viewModel: viewModel)
    }
    
    func didTapRightItemButton(isSelected: Bool) {
        buttonAction(isSelected: isSelected)
    }
    
    func some1() {
        guard let viewModel = viewModel else {
            return
        }
        showDetailScreen(detailViewModel: .init(id: viewModel.id, title: viewModel.title, url: viewModel.url))
    }
}
