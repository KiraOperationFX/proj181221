//
//  BrightnessVC.swift
//  proj181221
//
//  Created by Kira on 26/12/2021.
//

import UIKit

class BrightnessVC: BaseViewController {
    
    @IBOutlet var uvBackground: UIView!
    @IBOutlet weak var imvBtnDarkLight: UIImageView!
    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var seekBar: UISlider!
    
    private let currentBrightness = UIScreen.main.brightness
    
    private var isDark: Bool = true {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        seekBar.value = Float(currentBrightness)
        lblPercent.text = "\(Int(currentBrightness*100))%"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIScreen.main.brightness = self.currentBrightness
    }
    
    private func updateUI() {
        if self.isDark {
            uvBackground.backgroundColor = .black
            imvBtnDarkLight.image = R.image.darkToggleSwitchOff()
            lblPercent.textColor = .white
            lblContent.textColor = .white
        } else {
            uvBackground.backgroundColor = .white
            imvBtnDarkLight.image = R.image.lightToggleSwitchOn()
            lblPercent.textColor = .black
            lblContent.textColor = .black
        }
    }
    
    @IBAction func receiveSliderValue(_ sender: UISlider) {
        let currentValue = Int(sender.value*100)
        DispatchQueue.main.async { [weak self] in
            self?.lblPercent.text = "\(currentValue)%"
            UIScreen.main.brightness = CGFloat(sender.value)
        }
    }
    
    
    @IBAction func tapBtnDarkLight(_ sender: Any) {
        isDark = !isDark
    }
    
}
