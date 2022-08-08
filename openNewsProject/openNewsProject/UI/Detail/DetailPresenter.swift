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
    func activityIndicatorDidCommit()
    func activityIndicatorDidFinish()
    func refreshData()
}

class DetailPresenter {
    // Dependencies
    weak var view: IDetailViewController?
    private let viewModel: DetailViewModel
    private let storage: Storable

    // MARK: - Initialization
    init(
        viewModel: DetailViewModel,
        storage: Storable
    ) {
        self.viewModel = viewModel
        self.storage = storage
    }
}

extension DetailPresenter: IDetailPresenter {
    func viewDidLoad() {
        view?.setup(with: viewModel)
    }
    
    func activityIndicatorDidCommit() {
        view?.showActivityIndicator()
    }
    
    func activityIndicatorDidFinish() {
        view?.hideActivityIndicator()
    }
    
    func refreshData() {
        view?.setup(with: viewModel)
    }
}
