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
    func didTapRightItemButton(isSelected: Bool)
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
    
    private func some(isSelected: Bool) {
        if isSelected {
            storage.save(model: viewModel)
        } else {
            storage.remove(id: viewModel.id)
        }
    }
    
}

extension DetailPresenter: IDetailPresenter {
    
    func viewDidLoad() {
        view?.setup(with: viewModel)
        
    }
    
    func didTapRightItemButton(isSelected: Bool) {
        some(isSelected: isSelected)
    }
    
}

