//
//  CountriesTableViewCell.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/10/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import UIKit

//This is for the cells in the table
class CountriesTableViewCell: UITableViewCell {

    //THis is the lable for the country name
    @IBOutlet weak var countryName: UILabel!
    
    //TODO: Add flags to the cell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
