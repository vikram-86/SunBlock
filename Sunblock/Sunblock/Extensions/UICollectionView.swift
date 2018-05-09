//
//  UICollectionView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 25.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

extension UICollectionView{

    final func register<T: UICollectionViewCell>(cell: T.Type) where T: NibReusable{
        self.register(cell.nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    final func register<T: UICollectionViewCell>(cell: T.Type) where T: Reusable{
        self.register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable{
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand")
        }
        return cell
    }
}
