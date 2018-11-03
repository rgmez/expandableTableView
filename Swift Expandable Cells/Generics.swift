//
//  VBGenerics.swift
//  Swift Expandable Cells
//
//  Created by Roberto Gómez on 23/03/2018.
//  Copyright © 2018 Roberto Gomez. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionViewCell: Reusable { }

// MARK: - UITableView
extension UITableView {
    
    @discardableResult
    public func register(_ cellClass: Reusable.Type) -> UITableView {
        
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
        
        return self
    }
    
    @discardableResult
    public func registerNib(_ cellClass: Reusable.Type) -> UITableView {
        let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
        
        return self
    }
    
    public func dequeueCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

// MARK: - UICollectionView
extension UICollectionView {
    
    @discardableResult
    public func register(_ cellClass: Reusable.Type) -> UICollectionView {
        
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        
        return self
    }
    
    @discardableResult
    public func registerNib(_ cellClass: Reusable.Type) -> UICollectionView {
        
        let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        
        return self
    }
    
    public func dequeueCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
