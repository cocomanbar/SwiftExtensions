//
//  UITableView.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UITableView {
    
    public func reloadData(completion: (() -> Void)?) {
        CATransaction.mk.perform(excute: {
            base.reloadData()
        }, completion: completion)
    }
    
    public func register(_ cellClass: UITableViewCell.Type, reuseIdentifier: String? = nil) {
        let reuseIdentifier = reuseIdentifier ?? String(describing: cellClass)
        base.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func register(_ cellClass: UITableViewHeaderFooterView.Type, reuseIdentifier: String? = nil) {
        let reuseIdentifier = reuseIdentifier ?? String(describing: cellClass)
        base.register(cellClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    public func scrollToItem(at indexPath: IndexPath, scrollPosition: UITableView.ScrollPosition, animated: Bool = true) {
        guard indexPath.item >= 0 &&
        indexPath.section >= 0 &&
        indexPath.section < base.numberOfSections &&
        indexPath.row < base.numberOfRows(inSection: indexPath.section) else {
            return
        }
        base.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}

