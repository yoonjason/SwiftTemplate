//
//  ThumbPhotoCell.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import UIKit

class ThumbPhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }
    
    func bind(_ image: UIImage) {
        self.imageView.alpha = 0.2
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.imageView.image = image
            self.imageView.alpha = 1
        } completion: { _ in
        }
    }

}
