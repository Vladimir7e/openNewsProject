//
//  MainPresenter.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation
import UIKit

protocol NewsActions: AnyObject {
    func didTapDefaultCell()
}

protocol INewsPresenter: AnyObject {
    func viewDidLoad()
    var viewModel: NewsViewModel { get }
}

class NewsPresenter {

    // Dependencies
    weak var view: INewsViewController?
    let networkService: NewsNetworkServiceProtocol
    let viewModelFactory: INewsViewModelFactory
    
    let newsType: TabBarItemType
    
    // Properties
    private(set) var viewModel: NewsViewModel = .empty

    // MARK: - Initialization

    init(
        networkService: NewsNetworkServiceProtocol,
        viewModelFactory: INewsViewModelFactory,
        newsType: TabBarItemType
    ) {
        self.networkService = networkService
        self.viewModelFactory = viewModelFactory
        self.newsType = newsType
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
        case .favorive:
            break
        }
    }

    private func getMostEmailed() {
        networkService.getMostEmailed { [weak self] result in
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
        networkService.getMostShared { [weak self] result in
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
        networkService.getMostViewed { [weak self] result in
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

    private func updateModel(with news: [News]) {
        viewModel = viewModelFactory.makeViewModel(newsModels: news, actions: self)
    }
}

extension NewsPresenter: INewsPresenter {
    func viewDidLoad() {
        view?.setupTopContainer(with: viewModelFactory.makeTopContainerViewModel(newsType: newsType))
        getNews()
    }
}

extension NewsPresenter: NewsActions {
    func didTapDefaultCell() {
        print(#function)
    }
}
