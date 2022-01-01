//
//  BaseViewController.swift
//  proj181221
//
//  Created by Kira on 01/01/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func insertBottomAds() {
        let viewAds = UIView()
        self.view.addSubview(viewAds)
        self.view.bringSubviewToFront(viewAds)
        viewAds.backgroundColor = .blue
        viewAds.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewAds.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewAds.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            viewAds.heightAnchor.constraint(equalToConstant: 50),
            viewAds.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
}
