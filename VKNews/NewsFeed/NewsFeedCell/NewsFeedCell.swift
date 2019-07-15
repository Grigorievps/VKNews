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
    
    func set(viewModel: FeedCellViewModel) {
        nameLable.text = viewModel.name
        dateLable.text = viewModel.date
        postLable.text = viewModel.text
        likesLable.text = viewModel.likes
        commentsLable.text = viewModel.cooments
        sharesLable.text = viewModel.shares
        viewsLable.text = viewModel.views
    }
}

protocol FeedCellViewModel {
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var cooments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var iconURLString: String { get }
}
