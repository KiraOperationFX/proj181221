//
//  ColorVC.swift
//  proj181221
//
//  Created by Kira on 26/12/2021.
//

import UIKit
import UIColor_Hex_Swift

class ColorVC: UIViewController {
    @IBOutlet weak var uvBackground: UIView!
    @IBOutlet weak var lblHexColor: UILabel!
    @IBOutlet weak var lblColorName: UILabel!
    lazy private var vm: ColorVMProtocol = ColorVM()
    private let currentBrightness = UIScreen.main.brightness
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIScreen.main.brightness = CGFloat(1.0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIScreen.main.brightness = self.currentBrightness
    }
    
    @IBAction func tapBtnChangeBgColor(_ sender: Any) {
        let hexColor = vm.getColor()
        let color = UIColor(hexColor)
        uvBackground.backgroundColor = color
        lblHexColor.text = hexColor
        lblColorName.text = color.accessibilityName
    }

}
