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
    func activityIndicatorDidCommit()
    func activityIndicatorDidFinish()
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
    
    private func buttonAction(isSelected: Bool) {
        if isSelected {
            storage.save(model: viewModel)
        } else {
            storage.remove(id: viewModel.id)
        }
    }
    
    private func buttonLogic() {
        let models: [DetailViewModel] = storage.fetchData()
        for model in models where model.id == viewModel.id {
            view?.setButtonState(isSelected: true)
        }
    }
}

extension DetailPresenter: IDetailPresenter {
    func viewDidLoad() {
        buttonLogic()
        view?.setup(with: viewModel)
    }
    
    func didTapRightItemButton(isSelected: Bool) {
        buttonAction(isSelected: isSelected)
    }
    
    func activityIndicatorDidCommit() {
        view?.showActivityIndicator()
    }
    
    func activityIndicatorDidFinish() {
        view?.hideActivityIndicator()
    }
}
