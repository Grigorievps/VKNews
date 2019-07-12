//
//  NewsFeedCell.swift
//  VKNews
//
//  Created by Павел Григорьев on 12/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedCell: UITableViewCell {
    
    static let reusedId = "NewsFeedCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var postLable: UILabel!
    @IBOutlet weak var likesLable: UILabel!
    @IBOutlet weak var commentsLable: UILabel!
    @IBOutlet weak var sharesLable: UILabel!
    @IBOutlet weak var viewsLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
