//
//  MainPresenter.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation
import UIKit

protocol NewsActions: AnyObject {
    func didTapDefaultCell(newsModel: News)
}

protocol INewsPresenter: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func refreshData()
    var viewModel: NewsViewModel { get }
}

class NewsPresenter {
    // Dependencies
    weak var view: INewsViewController?
    private let networkService: NewsServiceProtocol
    private let viewModelFactory: INewsViewModelFactory
    private let router: INewsRouter
    private let storage: Storable
    let newsType: ModelType
    
    // Properties
    private(set) var viewModel: NewsViewModel = .empty
    var isFirstAppear: Bool = true
    
    // MARK: - Initialization
    init(
        networkService: NewsServiceProtocol,
        viewModelFactory: INewsViewModelFactory,
        router: INewsRouter,
        newsType: ModelType,
        storage: Storable
    ) {
        self.networkService = networkService
        self.viewModelFactory = viewModelFactory
        self.router = router
        self.newsType = newsType
        self.storage = storage
    }

    // MARK: - Private
    private func getNews() {
        view?.showActivityIndicator()
        networkService.getNews { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.updateModel(with: response.results)
                    self?.view?.reloadData()
                case .failure(let error):
                    self?.view?.presentErrorAlert(item: error)
                }
                self?.view?.hideActivityIndicator()
                self?.view?.endRefreshing()
            }
        }
    }

    private func updateModel(with news: [News]) {
        viewModel = viewModelFactory.makeViewModel(newsModels: news, actions: self)
    }
}

extension NewsPresenter: INewsPresenter {
    func viewDidLoad() {
        view?.setupTopContainer(with: viewModelFactory.makeTopContainerViewModel(newsType: newsType))
        getNews()
    }
    
    func viewWillAppear() {
        if isFirstAppear {
            isFirstAppear = false
        } else {
            getNews()
        }
    }
    
    func refreshData() {
        getNews()
    }
}

extension NewsPresenter: NewsActions {
    func didTapDefaultCell(newsModel: News) {
        router.showDescriptionScreen(newsModel: newsModel)
    }
}
