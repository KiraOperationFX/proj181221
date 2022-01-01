//
//  UIAlertController+Create.swift
//  proj181221
//
//  Created by Kira on 01/01/2022.
//

import UIKit

extension UIAlertController {
    public convenience init(title: String? = nil,
                            message: String? = nil,
                            action1Title: String? = nil,
                            action1: (() -> Void)? = nil,
                            action2Title: String? = nil,
                            action2: (() -> Void)? = nil
    ) {
        let title = title ?? ""
        let message = message ?? ""
        let action1Title = action1Title ?? ""
        self.init(title: title,
                  message: message,
                  preferredStyle: .alert)

        // Selection 1
        self.addAction(UIAlertAction(title: action1Title,
                                     style: .default,
                                     handler: { (_) in
                                        action1?()
                                     }))
        // Selection 2
        if let action2Title = action2Title,
           let action2 = action2 {
            self.addAction(UIAlertAction(title: action2Title,
                                         style: .default,
                                         handler: { (_) in
                                            action2()
                                         }))
        }
    }

    func show(in vc: UIViewController) {
        DispatchQueue.main.async {
            vc.present(self, animated: true, completion: nil)
        }
    }
}
