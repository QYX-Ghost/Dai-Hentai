//
//  ListCell.swift
//  Dai-Hentai
//
//  Created by DaidoujiChen on 2019/10/31.
//  Copyright © 2019 DaidoujiChen. All rights reserved.
//

import Foundation

class ListCell: UICollectionViewCell {
    
    // MARK: - Property
    // UI
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var blurCoverView: UIVisualEffectView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var progress: UILabel!
    
    // Data
    @objc var progressTimer: Timer?
    
    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (DBUserPreference.info().blurCover?.boolValue ?? false) {
            // 模糊封面
            blurCoverView.isHidden = false
        } else {
            // 不模糊封面
            blurCoverView.isHidden = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbImageView.image = nil
        progress.text = ""
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    // MARK: Method
    private func shadow(on view: UIView, opacity: Float, radius: CGFloat) {
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = .zero
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
    
}
