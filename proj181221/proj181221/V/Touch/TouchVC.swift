//
//  TouchVC.swift
//  proj181221
//
//  Created by Kira on 26/12/2021.
//

import UIKit
import SwiftyDraw
import Lottie

class TouchVC: UIViewController {
    
    @IBOutlet weak var uvAnimation: AnimationView!
    @IBOutlet weak var uvDrawnArea: SwiftyDrawView!
    @IBOutlet weak var lblContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uvDrawnArea.isEnabled = true
        uvDrawnArea.brush.color = Color(.red)
        uvDrawnArea.brush.width = 40
        uvDrawnArea.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uvAnimation.loopMode = .playOnce
        uvAnimation.play { [weak self] _ in
            self?.uvAnimation.stop()
            self?.uvAnimation.alpha = 0
        }
        lblContent.fadeIn()
    }


}

extension TouchVC: SwiftyDrawViewDelegate {
    func swiftyDraw(shouldBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) -> Bool {
        self.lblContent.fadeOut()
        return true
    }
    
    func swiftyDraw(didBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    func swiftyDraw(isDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    func swiftyDraw(didFinishDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    func swiftyDraw(didCancelDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
}
