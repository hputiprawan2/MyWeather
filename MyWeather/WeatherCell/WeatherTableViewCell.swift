//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by Hanna Putiprawan on 1/8/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let identifier = "WeatherTableViewCell"
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTemp: UILabel!
    @IBOutlet var lowTemp: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with model: DailyWeather) {
        print(model.temp.min)
        print(model.temp.max)
        self.lowTemp.text = "\(Int(model.temp.min))°"
        self.highTemp.text = "\(Int(model.temp.max))°"
//        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
//        self.iconImageView.image = UIImage(named: "Sun")
    }
    
    private func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM" // Monday
        return formatter.string(from: inputDate)
    }
    
}
