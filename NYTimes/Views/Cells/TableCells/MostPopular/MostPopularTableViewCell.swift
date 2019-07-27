//
//  MostPopularTableViewCell.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

protocol MostPopularCellContentProtocol {
    
    var imageUrl: String? {get}
    var heading: String? {get}
    var content: String? {get}
    var date: String? {get}
    var section: String? {get}
}

class MostPopularTableViewCell: UITableViewCell {

    // MARK:- IBOutlets -
    
    @IBOutlet weak var avatar: CustomImageView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var section: UILabel!
    
    // MARK:- Cell Life Cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:- Class Helpers -
    
    func populateInfo(_ info: DataObserver<MostPopularCellViewModel>?) {
        
        guard var info = info else { return }
        
        func populateContent(_ info:MostPopularCellViewModel) {

            avatar.setImage(forUrl: info.imageUrl, placeholderImage: nil)
            heading.text = info.heading
            content.text = info.content
            date.text = info.date
            section.text = info.section
        }
        
        info.singleBind { (cellModel) in
            
            populateContent(cellModel)
        }
        populateContent(info.value)
    }
}
