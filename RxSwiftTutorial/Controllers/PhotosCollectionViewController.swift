//
//  PhotosCollectionViewController.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import Photos
import RxSwift

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto:Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }

    // MARK: Lifecylces
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        populatePhotos()

        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    
    // MARK: Configures
    func configureUI() {
        collectionView.backgroundColor = .systemBackground
    }
    
    func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                // access the photos from photo library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
            }
        }
    }
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        // Configure the cell
        cell.photo = self.images[indexPath.row]
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: PHImageContentMode.aspectFit, options: nil) { (image, info ) in
            guard let info = info else { return }
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                if let image = image {
                    self.selectedPhotoSubject.onNext(image)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }


}


extension PhotosCollectionViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 4) - 3, height: (view.frame.width / 4) - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
