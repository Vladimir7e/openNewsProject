//
//  CellSizeProtocol.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol CellSizeProtocol {
    static func size(for size: CGSize, itemsPerRow: CGFloat) -> CGSize
}
