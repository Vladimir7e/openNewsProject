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
}

class DescriptionPresenter {
    // Dependencies
    weak var view: IDescriptionViewController?
    private var viewModel: DescriptionViewModel?
    private let viewModelFactory: IDescriptionViewModelFactory
    private let newsModel: News
    private let storage: Storable

    // MARK: - Initialization
    init(
        newsModel: News,
        viewModelFactory: IDescriptionViewModelFactory,
        storage: Storable
    ) {
        self.newsModel = newsModel
        self.viewModelFactory = viewModelFactory
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
}

extension DescriptionPresenter: IDescriptionPresenter {
    func viewDidLoad() {
        buttonLogic()
        updateModel(with: newsModel)
        
        guard let viewModel = viewModel else {
            return
        }
        view?.setup(viewModel: viewModel)
    }
    
    func didTapRightItemButton(isSelected: Bool) {
        buttonAction(isSelected: isSelected)
    }
}
