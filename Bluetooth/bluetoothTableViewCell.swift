//
//  bluetoothTableViewCell.swift
//  Bluetooth
//
//  Created by Rahul Avale on 2/21/18.
//  Copyright © 2018 Rahul Avale. All rights reserved.
//

import UIKit

class bluetoothTableViewCell: UITableViewCell {

    @IBOutlet weak var peripheralNameLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
