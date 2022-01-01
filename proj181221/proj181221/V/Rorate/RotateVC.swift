//
//  RotateVC.swift
//  proj181221
//
//  Created by Kira on 01/01/2022.
//

import UIKit
import CoreMotion

class RotateVC: BaseViewController {
    
    @IBOutlet weak var b1: UIImageView!
    @IBOutlet weak var b2: UIImageView!
    @IBOutlet weak var b3: UIImageView!
    @IBOutlet weak var b4: UIImageView!
    @IBOutlet weak var b5: UIImageView!
    @IBOutlet weak var b6: UIImageView!
    @IBOutlet weak var b7: UIImageView!
    @IBOutlet weak var b8: UIImageView!
    @IBOutlet weak var b9: UIImageView!
    @IBOutlet weak var b10: UIImageView!
    @IBOutlet weak var b11: UIImageView!
    @IBOutlet weak var b12: UIImageView!
    @IBOutlet weak var lblInfor: UILabel!
    
    var gravity: Gravity?
    var orientationLast = UIInterfaceOrientation(rawValue: 0)!
    var motionManager: CMMotionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerAdsView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gravity?.disable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.initializeMotionManager()
        }
        
        let gravityItems: [UIDynamicItem] = [
            b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12
        ]
        
        gravity = Gravity(
            gravityItems: gravityItems,
            collisionItems: nil,
            referenceView: self.view,
            boundary: UIBezierPath(rect: self.view.frame),
            queue: nil)
        gravity?.enable()
        
        showAdInterstitial(vc: self, deadline: .now()+15)
    }
    
    func initializeMotionManager() {
         motionManager = CMMotionManager()
         motionManager?.accelerometerUpdateInterval = 0.2
         motionManager?.gyroUpdateInterval = 0.2
         motionManager?.startAccelerometerUpdates(to: (OperationQueue.current)!, withHandler: {
            (accelerometerData, error) -> Void in
            if error == nil {
                self.outputAccelertionData((accelerometerData?.acceleration)!)
            }
            else {
                print("\(error!)")
            }
            })
         }
    
    func outputAccelertionData(_ acceleration: CMAcceleration) {

        var orientationNew: UIInterfaceOrientation
        if acceleration.x >= 0.75 {
            orientationNew = .landscapeLeft
            lblInfor.text = "Landscape - Left"
            print("landscapeLeft")
        }
        else if acceleration.x <= -0.75 {
            orientationNew = .landscapeRight
            lblInfor.text = "Landscape - Right"
            print("landscapeRight")
        }
        else if acceleration.y <= -0.75 {
            orientationNew = .portrait
            lblInfor.text = "Portrait"
            print("portrait")
        }
        else if acceleration.y >= 0.75 {
            orientationNew = .portraitUpsideDown
            lblInfor.text = "Portrait - Upside Down"
            print("portraitUpsideDown")
        }
        else {
            // Consider same as last time
            return
        }

        if orientationNew == orientationLast {
            return
        }
        orientationLast = orientationNew
    }
}
