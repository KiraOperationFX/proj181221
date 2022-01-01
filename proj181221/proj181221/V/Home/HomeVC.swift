//
//  HomeVC.swift
//  proj181221
//
//  Created by Kira on 19/12/2021.
//

import UIKit
import Lottie

class HomeVC: UIViewController {
    
    @IBOutlet weak var uvTopAnimation: AnimationView!
    @IBOutlet weak var uvHeaderAnimation: AnimationView!
    @IBOutlet weak var tbvContent: UITableView!
    
    lazy var vm: HomeVMProtocol = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    private func config() {
        tbvContent.register(cell: HomeTVC.self)
        tbvContent.delegate = self
        tbvContent.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        [uvTopAnimation, uvHeaderAnimation].forEach {
            $0?.loopMode = .loop
            $0?.play(completion: nil)
        }
    }
    
    @IBAction func tapBtn(_ sender: Any) {
        print("aaaaaa")
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.countTotalItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvContent.dequeue(cell: HomeTVC.self, for: indexPath)
        if let data = vm.getData(index: indexPath.row) {
            cell.imvIcon.image = data.icon
            cell.lblName.text = data.label
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // Color
            let vc = R.storyboard.colorStoryboard.colorVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = R.storyboard.brightnessStoryboard.brightnessVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        case 2: // Touch
            let vc = R.storyboard.touchStoryboard.touchVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        case 3: // Gravity
            let vc = R.storyboard.rotateStoryboard.rotateVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        case 4: // Biometrics
            let vc = R.storyboard.biometricsStoryboard.biometricsVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        case 5: // Torch
            let vc = R.storyboard.torchStoryboard.torchVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        case 6: // Vibration
            let vc = R.storyboard.vibrationStoryboard.vibrationVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
