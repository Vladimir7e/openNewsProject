//
//  TabBarPresenter.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

protocol ITabBarPresenter {
    
    func viewWillAppear()
}

final class TabBarPresenter: ITabBarPresenter {
    
    // Dependencies
    weak var view: ITabBarController?
    private let viewModelFactory: ITabBarViewModelFactory
    
    // MARK: - Initialization
    
    init(
         viewModelFactory: ITabBarViewModelFactory
    ) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - ITabBarPresenter
    
    func viewWillAppear() {
        
        let viewModels: [TabBarViewModel] = viewModelFactory.makeViewModels()
        view?.setup(viewModels: viewModels)
    }
}
