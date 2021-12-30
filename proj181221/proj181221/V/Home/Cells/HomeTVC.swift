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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imvIcon.image = nil
        lblName.text?.removeAll()
    }
}
