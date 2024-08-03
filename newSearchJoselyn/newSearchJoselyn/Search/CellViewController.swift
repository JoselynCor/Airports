//
//  CellViewController.swift
//  newSearchJoselyn
//
//  Created by Joselyn Cordero on 02/08/24.
//

import Foundation
import UIKit

class CellViewController: UITableViewCell {
    
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(with airport: Airport){
        nameLabel.text = airport.name
        placeLabel.text = airport.iataCode ?? "N/A"
    }
}


