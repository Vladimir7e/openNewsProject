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

}

class DetailPresenter {

    // Dependencies
    weak var view: IDetailViewController?
    private let networkService: NewsNetworkServiceProtocol
    private let viewModel: DetailViewModel

    // MARK: - Initialization

    init(
        networkService: NewsNetworkServiceProtocol,
        viewModel: DetailViewModel
    ) {
        self.networkService = networkService
        self.viewModel = viewModel
    }
}

extension DetailPresenter: IDetailPresenter {
    
    func viewDidLoad() {
        view?.setup(with: viewModel)
        
    }
}

