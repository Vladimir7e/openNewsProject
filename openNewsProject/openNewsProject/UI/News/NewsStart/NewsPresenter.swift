//
//  MainPresenter.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation
import UIKit

protocol NewsActions: AnyObject {
    func didTapDefaultCell(detailViewModel: DetailViewModel)
}

protocol INewsPresenter: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    var viewModel: NewsViewModel { get }
}

class NewsPresenter {

    // Dependencies
    weak var view: INewsViewController?
    private let networkService: NewsNetworkServiceProtocol
    private let viewModelFactory: INewsViewModelFactory
    private let router: INewsRouter
    private let storage: Storable
    
    let newsType: TabBarItemType
    
    // Properties
    private(set) var viewModel: NewsViewModel = .empty
    var isFirstAppear = true
    // MARK: - Initialization

    init(
        networkService: NewsNetworkServiceProtocol,
        viewModelFactory: INewsViewModelFactory,
        router: INewsRouter,
        newsType: TabBarItemType,
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
        switch newsType {
        case .emailed:
            getMostEmailed()
        case .shared:
            getMostShared()
        case .viewed:
            getMostviewed()
        case .favorites:
            getFavorites()
            view?.reloadData()
        }
    }

    private func getMostEmailed() {
        networkService.getMostEShV(type: .pathEmailed) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.updateModel(with: response.results)
                    self?.view?.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getMostShared() {
        networkService.getMostEShV(type: .pathShared) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.updateModel(with: response.results)
                    self?.view?.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getMostviewed() {
        networkService.getMostEShV(type: .pathViewed) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.updateModel(with: response.results)
                    self?.view?.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getFavorites() {
        viewModel = viewModelFactory.makeViewModelFavorites(model: storage.fetchData(), actions: self)
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
}

extension NewsPresenter: NewsActions {
    func didTapDefaultCell(detailViewModel: DetailViewModel) {
        router.showDetailScreen(detailViewModel: detailViewModel)
    }
}

