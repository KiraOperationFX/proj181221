//
//  BiometricsVC.swift
//  proj181221
//
//  Created by Kira on 30/12/2021.
//

import UIKit
import LocalAuthentication
import Lottie

class BiometricsVC: BaseViewController {
    
    @IBOutlet weak var uvAnimation1: AnimationView!
    @IBOutlet weak var uvAnimation2: AnimationView!
    @IBOutlet weak var lblTouchIdOK: UILabel!
    @IBOutlet weak var lblFaceIdOK: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        [uvAnimation1,
         uvAnimation2].forEach {
            $0?.loopMode = .loop
            $0?.play(completion: nil)
        }
        startAuthentication()
    }
    
    // Process to use biometrics for authentication
    private func startAuthentication() {
        let context = LAContext()
        let reason = "Use biometrict for testing"
        // If biometric avaiable, setup authen biometric
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, evaluateError in
                DispatchQueue.main.async { [weak self] in
                    guard let wSelf = self else { return }
                    switch success {
                    case true:
                        if context.evaluatedPolicyDomainState == nil {
                            /// Nhập đúng passcode của máy khi sai nhiều lần liên tiếp. OS sẽ show màn hình passcode của thiết bị.
                            /// Nếu nhập đúng thì sẽ vào đây và xử lý logic tại đây.
                            wSelf.navigationController?.popViewController(animated: true)
                        } else {
                            /// Xác thực thành công. Xử lý logic
                            if context.biometryType == .faceID {
                                wSelf.didFaceIdDone()
                            } else  {
                                wSelf.didTouchIdDone()
                            }
                            wSelf.showAdInterstitial(vc: wSelf, deadline: .now()+3)
                        }
                    case false:
                        /// Xác thực thất bại. Xử lý logic thất bại
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func didFaceIdDone() {
        uvAnimation2.isHidden = true
        lblFaceIdOK.isHidden = false
    }
    
    private func didTouchIdDone() {
        uvAnimation1.isHidden = true
        lblTouchIdOK.isHidden = false
    }
}
