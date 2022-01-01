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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkToShowAds()
    }
    
    func checkToShowAds() {
        RemoteConfigManager.shared.fetchRemoteConfig()
        if let build = Int(Bundle.main.buildVersionNumber ?? "0"),
           let buildShowAds = Int(RemoteConfigManager.shared.getValue(fromKey: .buildShowAds)) {
            print("build app: \(build)")
            print("build cfg: \(buildShowAds)")
            
            if build <= buildShowAds {
                showBannerAds()
            } else {
                hideBannerAds()
            }
        }
    }
    
    func showBannerAds() {
        let viewAds = UIView()
        viewAds.tag = 696969
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
    
    func hideBannerAds() {
        if let view = self.view.viewWithTag(696969) {
            view.removeFromSuperview()
        }
    }
}
