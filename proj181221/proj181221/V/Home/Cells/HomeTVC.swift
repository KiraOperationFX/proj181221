//
//  HomeTVC.swift
//  proj181221
//
//  Created by Kira on 19/12/2021.
//

import UIKit

class HomeTVC: UITableViewCell {
    
    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long Press")
//            imvBackground.image = R.image.img94776()
            imvIcon.alpha = 0.3
            lblName.alpha = 0.3
        }
        if gesture.state == .ended {
//            imvBackground.image = R.image.img94754()
            imvIcon.alpha = 1
            lblName.alpha = 1
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
