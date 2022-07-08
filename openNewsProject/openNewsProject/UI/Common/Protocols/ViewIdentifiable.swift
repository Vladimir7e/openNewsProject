//
//  ViewIdentifiable.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

protocol ViewIdentifiable {
    static var identifier: String { get }
}

extension ViewIdentifiable {
    static var identifier: String { String(describing: Self.self) }
}
