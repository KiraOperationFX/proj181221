//
//  UITableView+Reusable.swift
//  proj181221
//
//  Created by Kira on 19/12/2021.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cell type: T.Type) {
        let className = type.className
        if Bundle.main.path(forResource: className, ofType: "nib") != nil {
            let nib = UINib(nibName: className, bundle: nil)
            register(nib, forCellReuseIdentifier: className)
        } else {
            register(type, forCellReuseIdentifier: className)
        }
    }

    // MARK: - Dequeue
    func dequeue<T: UITableViewCell>(cell type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
