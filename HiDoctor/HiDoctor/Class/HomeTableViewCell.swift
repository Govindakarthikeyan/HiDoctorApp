//
//  HomeTableViewCell.swift
//  HiDoctor
//
//  Created by chandramouli venkatesan on 9/11/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var patientEduBtn: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var ratingBtn1: UIButton!
    @IBOutlet weak var companyTxtLbl: UILabel!
    @IBOutlet weak var ratingBtn2: UIButton!
    @IBOutlet weak var ratingBtn3: UIButton!
    @IBOutlet weak var ratingBtn4: UIButton!
    @IBOutlet weak var ratingBtn5: UIButton!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var readIndicator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        readIndicator.layer.cornerRadius = readIndicator.frame.size.height/2;
        readIndicator.clipsToBounds = true;

        // Initialization code
    }

//    @IBAction func ratingsViewTouchesBegan(sender: AnyObject) {
//        
//        if sender.tag == 1 {
//            
//            let starimage: UIImage = UIImage(named: "star_icon.png")!
//            ratingBtn1.setImage(starimage, forState: UIControlState.Normal)
//            
//        }
//    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
