//
//  EmailedViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 19.05.2022.
//

import UIKit

protocol IEmailedViewModelFactory {
    func makeViewModel(newsModels: [MostEmailed], actions: EmailedActions) -> EmailedViewModel
}

final class EmailedViewModelFactory: IEmailedViewModelFactory {

    // MARK: - IEmailedViewModelFactory

    func makeViewModel(newsModels: [MostEmailed], actions: EmailedActions) -> EmailedViewModel {
        .init(cellModels: makeCellModels(newsModels: newsModels, actions: actions))
    }

    // MARK: - Private

    private func makeCellModels(newsModels: [MostEmailed], actions: EmailedActions) -> [EmailedCellViewModel] {
        var cellModels: [EmailedCellViewModel] = []

        newsModels.forEach {
            cellModels.append(
                .defaultCell(
                    makeDefaultCellModel(newsModel: $0, actions: actions)
                )
            )
        }

        return cellModels
    }

    private func makeDefaultCellModel(newsModel: MostEmailed, actions: EmailedActions) -> NewsCellViewModel {
        .init(
            id: newsModel.id,
            imagePath: newsModel.url,
            title: newsModel.title,
            description: newsModel.publishedDate ?? "non set",
            tapAction: { [weak actions] in
                actions?.didTapDefaultCell()
            }
        )
    }
}
