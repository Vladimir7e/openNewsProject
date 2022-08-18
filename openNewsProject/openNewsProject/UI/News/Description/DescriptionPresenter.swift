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
    func didTapDetailScreenButton()
    var viewModel: DescriptionViewModel? { get }
    func didTapShareButton()
}

class DescriptionPresenter {
    // Dependencies
    weak var view: IDescriptionViewController?
    internal var viewModel: DescriptionViewModel?
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
    
    // MARK: - Private
    private func updateModel(with news: News) {
        viewModel = viewModelFactory.makeViewModel(newsModels: news)
    }
    
    private func updateFavoritesTab(isSelected: Bool) {
        guard let viewModel = viewModel else {
            return
        }
        if isSelected {
            storage.save(model: viewModel)
        } else {
            storage.remove(id: viewModel.id)
        }
    }
    
    private func setSaveButtonState() {
        let models: [DescriptionViewModel] = storage.fetchData()
        guard let viewModel = viewModel else {
            return
        }
        for model in models where model.id == viewModel.id {
            view?.setButtonState(isSelected: true)
        }
    }
}

extension DescriptionPresenter: IDescriptionPresenter {
    func viewDidLoad() {
        updateModel(with: newsModel)
        
        guard let viewModel = viewModel else {
            return
        }
        setSaveButtonState()
        view?.setup(viewModel: viewModel)
    }
    
    func didTapRightItemButton(isSelected: Bool) {
        updateFavoritesTab(isSelected: isSelected)
    }
    
    func didTapDetailScreenButton() {
        guard let viewModel = viewModel else {
            return
        }
        router.showDetailScreen(detailViewModel: DetailViewModel(id: viewModel.id, title: viewModel.title, url: viewModel.url))
    }
    
    func didTapShareButton() {
        guard let  url: URL = URL(string: viewModel?.url ?? "") else {
            return
        }
        router.showSharingScreen(url: url)
    }
}
