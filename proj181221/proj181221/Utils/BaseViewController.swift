//
//  BaseViewController.swift
//  proj181221
//
//  Created by Kira on 01/01/2022.
//

import UIKit
import GoogleMobileAds

class BaseViewController: UIViewController {
    
    var stopAds: Bool = true
    let bannerAdsView = UIView()
    
    private var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(backFromBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        RemoteConfigManager.shared.fetchRemoteConfig()
        
        // Ads
        setupAdsBanner()
        setupAdsInterstitial()
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
    
    // Setup ads banner
    func setupAdsBanner() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
    }
    
    // Setup ads interstitial
    func setupAdsInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
    }
    
    // Show ads ads interstitial
    func showAdInterstitial(vc: UIViewController) {
        if stopAds { return }
        if interstitial != nil {
            interstitial?.present(fromRootViewController: vc)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    // Show ads ads interstitial with time interval
    func showAdInterstitial(vc: UIViewController, deadline: DispatchTime) {
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            self?.showAdInterstitial(vc: vc)
        }
    }
    
    func checkToShowAds() {
        if let build = Int(Bundle.main.buildVersionNumber ?? "0"),
           let buildShowAds = Int(RemoteConfigManager.shared.getValue(fromKey: .buildShowAds)) {
            print("ads app: \(build)")
            print("ads cfg: \(buildShowAds)")
            if build <= buildShowAds {
                stopAds = false
                showBannerAds()
            } else {
                removeBannerAds()
            }
        }
    }
    
    func showBannerAds() {
        bannerAdsView.tag = 696969
        self.view.addSubview(bannerAdsView)
        self.view.bringSubviewToFront(bannerAdsView)
        bannerAdsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerAdsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bannerAdsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bannerAdsView.heightAnchor.constraint(equalToConstant: 50),
            bannerAdsView.widthAnchor.constraint(equalToConstant: 320)
        ])
        
        // Add real banner
        addBannerViewToView(bannerView, to: bannerAdsView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView, to view: UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func removeBannerAds() {
        if let view = self.view.viewWithTag(696969) {
            view.removeFromSuperview()
        }
    }
}

extension BaseViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
}

extension BaseViewController: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        setupAdsInterstitial()
    }
}
