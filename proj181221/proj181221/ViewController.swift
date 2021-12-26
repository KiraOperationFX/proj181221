//
//  ViewController.swift
//  proj181221
//
//  Created by Kira on 19/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = R.storyboard.homeVC.homeVC()!
        self.present(vc, animated: false, completion: nil)
    }

}

