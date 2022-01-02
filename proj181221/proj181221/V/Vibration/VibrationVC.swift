//
//  VibrationVC.swift
//  proj181221
//
//  Created by Kira on 26/12/2021.
//

import UIKit
import Lottie
import AudioToolbox

class VibrationVC: BaseViewController {
    
    @IBOutlet weak var uvAnimation: AnimationView!
    @IBOutlet weak var uvAnimationCenter: AnimationView!
    @IBOutlet weak var lblLabel: UILabel!
    
    private var workItem: DispatchWorkItem?
    private var timer: Timer?
    private var isActived: Bool = false {
        didSet {
            active()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        [uvAnimation, uvAnimationCenter].forEach {
            $0?.loopMode = .loop
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        distroy()
    }
    
    private func distroy() {
        self.workItem?.cancel()
        timer?.invalidate()
        timer = nil
    }
    
    private func vibrate() {
        isActived = !isActived
    }
    
    private func active() {
        if isActived {
            lblLabel.text = "Tap\nto\nStop"
            uvAnimation.alpha = 1
            uvAnimation.play(completion: nil)
            uvAnimationCenter.play(completion: nil)
            
            self.workItem = DispatchWorkItem {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
                DispatchQueue.global().async(execute: self.workItem!)
            }
        } else {
            lblLabel.text = "Tap\nto\nStart"
            distroy()
            uvAnimation.alpha = 0
            uvAnimation.stop()
            uvAnimationCenter.stop()
        }
    }
    
    
    @IBAction func tapAction(_ sender: Any) {
        vibrate()
    }
}
