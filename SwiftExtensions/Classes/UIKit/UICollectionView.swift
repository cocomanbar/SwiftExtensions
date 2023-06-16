//
//  UICollectionView.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UICollectionView {
    
    public func reloadData(completion: (() -> Void)?) {
        CATransaction.mk.perform(excute: {
            base.reloadData()
        }, completion: completion)
    }
    
    public func register(_ cellClass: UICollectionViewCell.Type, reuseIdentifier: String? = nil) {
        let reuseIdentifier = reuseIdentifier ?? String(describing: cellClass)
        base.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    public func register(_ reusableView: UICollectionReusableView.Type, viewOfKind: String, reuseIdentifier: String? = nil) {
        let reuseIdentifier = reuseIdentifier ?? String(describing: reusableView)
        base.register(reusableView, forSupplementaryViewOfKind: viewOfKind, withReuseIdentifier: reuseIdentifier)
    }
    
    public func scrollToItem(at indexPath: IndexPath, scrollPosition: UICollectionView.ScrollPosition, animated: Bool = true) {
        guard indexPath.item >= 0 &&
        indexPath.section >= 0 &&
        indexPath.section < base.numberOfSections &&
        indexPath.item < base.numberOfItems(inSection: indexPath.section) else {
            return
        }
        base.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
}
