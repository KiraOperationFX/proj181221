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
        
        NotificationCenter.default.addObserver(self, selector: #selector(backFromBackground), name: UIApplication.willEnterForegroundNotification, object: nil)

        RemoteConfigManager.shared.fetchRemoteConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkToShowAds()
        checkForceUpdate()
    }
    
    @objc func backFromBackground() {
        print("back from background")
        checkForceUpdate()
    }
    
    func checkForceUpdate() {
        if let build = Int(Bundle.main.buildVersionNumber ?? "0"),
           let buildForceUpdate = Int(RemoteConfigManager.shared.getValue(fromKey: .buildForceUpdate)),
           let url = URL(string: RemoteConfigManager.shared.getValue(fromKey: .buildForceUpdateUrl)) {
            print("ads app: \(build)")
            print("ads cfg: \(buildForceUpdate)")
            
            if build < buildForceUpdate {
                DispatchQueue.main.async { [weak self] in
                    guard let wSelf = self else { return }
                    UIAlertController(title: "Please update app to the latest version!",
                                      action1Title: "OK", action1:  {
                        UIApplication.shared.open(url)
                        wSelf.checkForceUpdate()
                    }).show(in: wSelf)
                }
            }
        }
    }
    
    func checkToShowAds() {
        if let build = Int(Bundle.main.buildVersionNumber ?? "0"),
           let buildShowAds = Int(RemoteConfigManager.shared.getValue(fromKey: .buildShowAds)) {
            print("ads app: \(build)")
            print("ads cfg: \(buildShowAds)")
            
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
