//
//  CityTableViewCell.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(city: CityModel) {
        self.nameLabel.text = "\(city.name), \(city.country)"
        self.coorLabel.text = "long: \(city.coord.lon), lat: \(city.coord.lat)"
    }
}
