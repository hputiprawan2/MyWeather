//
//  HourlyTableViewCell.swift
//  MyWeather
//
//  Created by Hanna Putiprawan on 1/8/21.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    static let identifier = "HourlyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
