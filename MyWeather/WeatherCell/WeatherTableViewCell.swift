//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by Hanna Putiprawan on 1/8/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
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
