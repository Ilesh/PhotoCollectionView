//
//  PhotoCollectionView.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit

@objc public protocol PhotoCollectionViewDataSource: NSObjectProtocol {
    func photoColletionView(_ photoCollectionView: PhotoCollectionView, imageAt index: Int) -> UIImage
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int
}

@IBDesignable
open class PhotoCollectionView: UIView {
    var margin: CGFloat = 1
    var maxImage = 4
    var photoViews: [PhotoView] = []
    
    weak open var dataSource: PhotoCollectionViewDataSource?
    @IBInspectable open var moreTextColor: UIColor! = UIColor.white
    @IBInspectable open var moreTextBackgroundColor: UIColor! = UIColor(white: 0.2, alpha: 0.6)
    open var moreTextFont: UIFont! = UIFont.systemFont(ofSize: 17)
    
    override open var bounds: CGRect {
        didSet {
            reloadData()
        }
    }
    
    open func reloadData() {
        while photoViews.count > 0 {
            let view = photoViews.removeFirst()
            view.removeFromSuperview()
        }
        
        guard let dataSource = dataSource else {
            return
        }
        let numImage = dataSource.numPhotos(in: self)
        let numShow = min(maxImage, numImage)
        
        let size = bounds.size
        var isVertical = false
        var nextOffset = CGPoint.zero
        
        for i in 0..<numShow {
            let image = dataSource.photoColletionView(self, imageAt: i)
            if i == 0 {
                isVertical = image.size.width < image.size.height
            }
            var itemSize = CGSize.zero
            let offset = nextOffset
            
            if numShow == 1 {
                itemSize.width = size.width
                itemSize.height = size.height
            } else {
                let remainCount = CGFloat(numShow - 1)
                if isVertical {
                    itemSize.width = (size.width - margin) / 2
                    if i == 0 {
                        itemSize.height = size.height
                        nextOffset.x += itemSize.width + margin
                    } else {
                        itemSize.height = (size.height - margin * (remainCount - 1)) / remainCount
                        nextOffset.y += itemSize.height + margin
                    }
                } else {
                    itemSize.height = (size.height - margin) / 2
                    if i == 0 {
                        itemSize.width = size.width
                        nextOffset.y += itemSize.height + margin
                    } else {
                        itemSize.width = (size.width - margin * (remainCount - 1)) / remainCount
                        nextOffset.x += itemSize.width + margin
                    }
                }
            }

            let photoView = PhotoView(frame: CGRect(origin: offset, size: itemSize))
            photoView.setImage(image)
            if numImage > maxImage && i == numShow - 1 {
                addMoreLabel(in: photoView, numMore: numImage - numShow)
            }
            photoViews.append(photoView)
            addSubview(photoView)
        }
    }
    
    fileprivate func addMoreLabel(in photoView: PhotoView, numMore: Int) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = moreTextBackgroundColor
        label.textColor = moreTextColor
        label.font = moreTextFont
        label.textAlignment = .center
        label.text = "+\(numMore)"
        
        photoView.addSubview(label)
        photoView.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        photoView.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
    }
}

