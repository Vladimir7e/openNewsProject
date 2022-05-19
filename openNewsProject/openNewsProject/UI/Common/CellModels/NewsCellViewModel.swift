//
//  NewsCellViewModel.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

struct NewsCellViewModel {
    let id: Int
    let imagePath: String?
    let title: String
    let description: String
    let tapAction: () -> Void
}
