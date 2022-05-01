//
//  PhotoViewerCell.swift
//  SwiftTemplate
//
//  Created by Bradley.yoon on 2022/04/28.
//

import UIKit

class PhotoViewerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.scrollView.delegate = self
            self.scrollView.maximumZoomScale = 4
            self.scrollView.minimumZoomScale = 1
        }
        
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

extension PhotoViewerCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
