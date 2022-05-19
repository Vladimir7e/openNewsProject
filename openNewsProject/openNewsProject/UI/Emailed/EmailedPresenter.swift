//
//  MainPresenter.swift
//  openNewsProject
//
//  Created by Developer on 13.05.2022.
//

import Foundation

protocol EmailedActions: AnyObject {
    func didTapDefaultCell()
}

protocol IEmailedPresenter: AnyObject {
    func viewDidLoad()
    var viewModel: EmailedViewModel { get }
}

class EmailedPresenter {

    // Dependencies
    weak var view: IEmailedViewController?
    let networkService: EmailedNetworkServiceProtocol
    let viewModelFactory: IEmailedViewModelFactory

    // Properties
    private(set) var viewModel: EmailedViewModel = .empty

    // MARK: - Initialization

    init(
        networkService: EmailedNetworkServiceProtocol,
        viewModelFactory: IEmailedViewModelFactory
    ) {
        self.networkService = networkService
        self.viewModelFactory = viewModelFactory
    }

    // MARK: - Private

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

    private func updateModel(with mostEmailed: [MostEmailed]) {
        viewModel = viewModelFactory.makeViewModel(newsModels: mostEmailed, actions: self)
    }
}

extension EmailedPresenter: IEmailedPresenter {
    func viewDidLoad() {
        getMostEmailed()
    }
}

extension EmailedPresenter: EmailedActions {
    func didTapDefaultCell() {
        print(#function)
    }
}
