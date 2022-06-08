//
//  DetailPresenter.swift
//  openNewsProject
//
//  Created by Developer on 31.05.2022.
//

import Foundation
import UIKit

protocol IDetailPresenter: AnyObject {
    func viewDidLoad()
    func didTapSaveButton()

}

class DetailPresenter {

    // Dependencies
    weak var view: IDetailViewController?
    private let networkService: NewsNetworkServiceProtocol
    private let viewModel: DetailViewModel
    private let storage: Storable

    // MARK: - Initialization

    init(
        networkService: NewsNetworkServiceProtocol,
        viewModel: DetailViewModel,
        storage: Storable
    ) {
        self.networkService = networkService
        self.viewModel = viewModel
        self.storage = storage
    }
}

extension DetailPresenter: IDetailPresenter {
    
    func viewDidLoad() {
        view?.setup(with: viewModel)
        
    }
    
    func didTapSaveButton() {
        storage.save(model: viewModel)
    }
    
}

