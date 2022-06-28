//
//  EmailedViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 19.05.2022.
//

import UIKit

protocol INewsViewModelFactory {
    func makeViewModel(newsModels: [News], actions: NewsActions) -> NewsViewModel
    func makeViewModelFavorites(model: [DetailViewModel], actions: NewsActions) -> NewsViewModel
    func makeTopContainerViewModel(newsType: TabBarItemType) -> NewsTopContainerViewModel
}

final class NewsViewModelFactory: INewsViewModelFactory {

    // MARK: - INewsViewModelFactory

    func makeViewModel(newsModels: [News], actions: NewsActions) -> NewsViewModel {
        .init(cellModels: makeCellModels(newsModels: newsModels, actions: actions))
    }
    
    func makeViewModelFavorites(model: [DetailViewModel], actions: NewsActions) -> NewsViewModel {
        .init(cellModels: makeCellModelsFavorites(model: model, actions: actions))
    }

    func makeTopContainerViewModel(newsType: TabBarItemType) -> NewsTopContainerViewModel {
        switch newsType {
        case .emailed:
            return .init(title: NSLocalizedString("Most Emailed", comment: ""))
        case .shared:
            return .init(title: NSLocalizedString("Most Shared", comment: ""))
        case .viewed:
            return .init(title: NSLocalizedString("Most Viewed", comment: ""))
        case .favorites:
            return .init(title: NSLocalizedString("Favorites", comment: ""))
        }
    }

    // MARK: - Private

    private func makeCellModels(newsModels: [News], actions: NewsActions) -> [CellViewModel] {
        var cellModels: [CellViewModel] = []

        newsModels.forEach {
            cellModels.append(
                .defaultCell(
                    makeDefaultCellModel(newsModel: $0, actions: actions)
                )
            )
        }
        
        return cellModels
    }
    
    private func makeCellModelsFavorites(model: [DetailViewModel], actions: NewsActions) -> [CellViewModel] {
        var cellModels: [CellViewModel] = []

        model.forEach {
            cellModels.append(
                .defaultCell(
                    makeDefaultCellModelFavorites(model: $0, actions: actions)
                )
            )
        }

        return cellModels
    }

    private func makeDefaultCellModel(newsModel: News, actions: NewsActions) -> NewsCellViewModel {
        .init(
            id: newsModel.id,
            imagePath: newsModel.media.first?.mediaMetadata.first?.url,
            title: newsModel.title,
            description: newsModel.publishedDate,
            tapAction: { [weak actions] in
                actions?.didTapDefaultCell(detailViewModel: .init(
                    id: newsModel.id,
                    title: newsModel.title,
                    url: newsModel.url,
                    imagePath: newsModel.media.first?.mediaMetadata.first?.url,
                    publishedDate: newsModel.publishedDate))
            }
        )
    }
    
    private func makeDefaultCellModelFavorites(model: DetailViewModel, actions: NewsActions) -> NewsCellViewModel {
        .init(
            id: model.id,
            imagePath: model.imagePath,
            title: model.title,
            description: model.publishedDate,
            tapAction: { [weak actions] in
                actions?.didTapDefaultCell(detailViewModel: .init(
                    id: model.id,
                    title: model.title,
                    url: model.url,
                    imagePath: model.imagePath,
                    publishedDate: model.publishedDate))
            }
        )
    }
}
