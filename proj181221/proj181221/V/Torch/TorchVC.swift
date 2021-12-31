//
//  TorchVC.swift
//  proj181221
//
//  Created by Kira on 31/12/2021.
//

import UIKit
import Lottie
import AVFoundation

class TorchVC: UIViewController {
    
    @IBOutlet weak var uvAnimation1: AnimationView!
    @IBOutlet weak var uvAnimation2: AnimationView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblCurrentLevel: UILabel!
    @IBOutlet weak var lblInfor: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slider.setValue(0.5, animated: false)
        toggleFlash(level: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        [uvAnimation1, uvAnimation2].forEach {
            $0?.loopMode = .loop
            $0?.play(completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        toggleFlash(level: 0)
    }
    
    func toggleFlash(level: Float) {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        if (device != nil) {
            if (device!.hasTorch) {
                do {
                    try device!.lockForConfiguration()
                    if level <= 0.1 {
                        device!.torchMode = AVCaptureDevice.TorchMode.off
                    } else {
                        device!.torchMode = AVCaptureDevice.TorchMode.on
                        do {
                            try device!.setTorchModeOn(level: level)
                        } catch {
                            print(error)
                        }
                    }
                    device!.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    @IBAction func didChangeSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value*100)
        let floatValue = Float(sender.value)
        let level = (floatValue <= 0.1) ? 0 : floatValue
        toggleFlash(level: level)
        DispatchQueue.main.async { [weak self] in
            self?.lblCurrentLevel.text = "\(currentValue)"
            self?.uvAnimation2.alpha = CGFloat(sender.value)
            if currentValue == 0 {
                self?.lblCurrentLevel.isHidden = true
                self?.lblInfor.text = "Rear LED is OFF"
            } else {
                self?.lblCurrentLevel.isHidden = false
                self?.lblInfor.text = "Rear LED is ON ⚡️"
            }
        }
        
    }
    

}
