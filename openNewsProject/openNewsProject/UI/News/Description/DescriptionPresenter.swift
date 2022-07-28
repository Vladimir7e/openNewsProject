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
}

extension DescriptionPresenter: IDescriptionPresenter {
    func viewDidLoad() {
        updateModel(with: newsModel)
        
        guard let viewModel = viewModel else {
            return
        }
        view?.setup(viewModel: viewModel)
    }
}
