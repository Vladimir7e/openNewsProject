//
//  EmailedViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 19.05.2022.
//

import UIKit

protocol INewsViewModelFactory {
    func makeViewModel(newsModels: [News], actions: NewsActions) -> NewsViewModel
    func makeTopContainerViewModel(newsType: TabBarItemType) -> NewsTopContainerViewModel
}

final class NewsViewModelFactory: INewsViewModelFactory {

    // MARK: - INewsViewModelFactory

    func makeViewModel(newsModels: [News], actions: NewsActions) -> NewsViewModel {
        .init(cellModels: makeCellModels(newsModels: newsModels, actions: actions))
    }

    func makeTopContainerViewModel(newsType: TabBarItemType) -> NewsTopContainerViewModel {
        switch newsType {
        case .emailed:
            return .init(title: "Most Emailed")
        case .shared:
            return .init(title: "Most Shared")
        case .viewed:
            return .init(title: "Most Viewed")
        case .favorive:
            return .init(title: "Favorite")
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

    private func makeDefaultCellModel(newsModel: News, actions: NewsActions) -> NewsCellViewModel {
        .init(
            id: newsModel.id,
            imagePath: newsModel.media.first?.mediaMetadata.first?.url,
            title: newsModel.title,
            description: newsModel.publishedDate,
            tapAction: { [weak actions] in
                actions?.didTapDefaultCell(detailViewModel: .init(title: newsModel.title, url: newsModel.url))
            }
        )
    }
}
