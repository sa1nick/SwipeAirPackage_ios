//
//  AddressTableViewCell.swift
//  SwipeAirPackage
//
//  Created by apple on 22/07/25.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellSubTitle: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    static let identifier = "AddressTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "AddressTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSubTitle.numberOfLines = 0
        cellSubTitle.lineBreakMode = .byWordWrapping
    }

    
}
