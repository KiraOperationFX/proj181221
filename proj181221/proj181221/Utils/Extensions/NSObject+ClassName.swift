//
//  NSObject+ClassName.swift
//  proj181221
//
//  Created by Kira on 19/12/2021.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
