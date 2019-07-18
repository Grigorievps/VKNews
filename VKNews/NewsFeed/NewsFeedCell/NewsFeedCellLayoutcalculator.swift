//
//  NewsFeedCellLayoutcalculator.swift
//  VKNews
//
//  Created by Павел Григорьев on 15/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation
import UIKit

final class NewsFeedCellLayoutcalculator: NewsFeedCellLayoutcalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Setting PostLable Frame
        
        var postLableFrame = CGRect(origin: CGPoint(x: Constants.postLableInsets.left, y: Constants.postLableInsets.top),
                                    size: .zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLableInsets.left - Constants.postLableInsets.right
            let height = text.height(width: width, font: Constants.postLableFont)
            
            postLableFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Setting Attachment Frame
        
        let attachmentTop = postLableFrame.size == CGSize.zero ? Constants.postLableInsets.top : postLableFrame.maxY + Constants.postLableInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        if let attachment = photoAttachment {
            let ratio = CGFloat(attachment.height) / CGFloat(attachment.width)
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        // MARK: Setting Attachment Frame
        
        let bottomViewTop = max(postLableFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        // MARK: Setting Total height
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLableFrame: postLableFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}

protocol NewsFeedCellLayoutcalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLableFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLableInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLableFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}
