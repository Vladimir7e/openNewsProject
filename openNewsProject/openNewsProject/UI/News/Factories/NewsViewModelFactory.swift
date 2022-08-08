//
//  EmailedViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 19.05.2022.
//

import UIKit

protocol INewsViewModelFactory {
    func makeViewModel(newsModels: [News], actions: NewsActions) -> NewsViewModel
    func makeTopContainerViewModel(newsType: ModelType) -> NewsTopContainerViewModel
}

final class NewsViewModelFactory: INewsViewModelFactory {
    func makeViewModel(newsModels: [News], actions: NewsActions) -> NewsViewModel {
        .init(cellModels: makeCellModels(newsModels: newsModels, actions: actions))
    }

    func makeTopContainerViewModel(newsType: ModelType) -> NewsTopContainerViewModel {
        switch newsType {
        case .emailed:
            return .init(title: R.string.localizable.mostEmailed())
        case .shared:
            return .init(title: R.string.localizable.mostShared())
        case .viewed:
            return .init(title: R.string.localizable.mostViewed())
        case .favorites:
            return .init(title: R.string.localizable.favorites())
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
        var dateString: String = newsModel.publishedDate
        
        if let date: Date = DateFormatter.dateFormatterGet.date(from: dateString) {
            dateString = DateFormatter.dateFormatterPrint.string(from: date)
        }
        return .init(
            id: newsModel.id,
            imagePath: newsModel.media.first?.mediaMetadata.first?.url,
            title: newsModel.title,
            description: dateString,
            tapAction: { [weak actions] in
                actions?.didTapDefaultCell(
                    newsModel: newsModel
                )
            }
        )
    }
}
