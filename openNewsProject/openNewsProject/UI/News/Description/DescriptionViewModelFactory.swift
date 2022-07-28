//
//  DescriptionViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 28.07.2022.
//

import Foundation
import UIKit

protocol IDescriptionViewModelFactory {
    func makeViewModel(newsModels: News) -> DescriptionViewModel
}

final class DescriptionViewModelFactory: IDescriptionViewModelFactory {
    func makeViewModel(newsModels: News) -> DescriptionViewModel {
        .init(id: newsModels.id, title: newsModels.title)
    }
}
