//
//  MessageCell.swift
//  Dai-Hentai
//
//  Created by DaidoujiChen on 2019/10/31.
//  Copyright © 2019 DaidoujiChen. All rights reserved.
//

import Foundation

class MessageCell: UICollectionViewCell {

    // MARK: Property
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var placeholderView: UIImageView!
    
    // MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        layer.borderWidth = 0.5
//        layer.borderColor = UIColor.gray.cgColor
    }
    
}
