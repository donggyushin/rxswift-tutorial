//
//  PhotoCell.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import Photos

class PhotoCell: UICollectionViewCell {
    
    // MARK: Properties
    var photo:PHAsset? {
        didSet {
            guard let photo = self.photo else { return }
            let manager = PHImageManager.default()
            manager.requestImage(for: photo, targetSize: CGSize(width: 100, height: 100), contentMode: PHImageContentMode.aspectFit, options: nil) { (image, _) in
                self.imageView.image = image
            }
        }
    }
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true 
        return iv
    }()
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configureUI() {
        backgroundColor = .systemBackground
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

