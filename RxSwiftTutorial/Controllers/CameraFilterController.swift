//
//  CameraFilterController.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import RxSwift

class CameraFilterController: UIViewController {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Camera Filter"
        return label
    }()
    
    private lazy var plusButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.contactAdd)
        bt.addTarget(self, action: #selector(plustButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private lazy var filterButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("Apply", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(applyButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    

    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: plusButton)
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        view.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    // MARK: Selectors
    @objc func plustButtonTapped() {
        let photosController = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        photosController.selectedPhoto.subscribe(onNext: {photo in
            self.imageView.image = photo
        }).disposed(by: disposeBag)
        navigationController?.pushViewController(photosController, animated: true)
    }
    
    @objc func applyButtonTapped() {
        // filter 버튼 클릭
        guard let image = self.imageView.image else { return }
        FilterService().applyFilter(to: image)
            .subscribe(onNext: { image in
                self.imageView.image = image
            }).disposed(by: disposeBag)
    }
}
