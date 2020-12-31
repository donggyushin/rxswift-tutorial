//
//  CalculatorController.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorController: UIViewController {
    
    // Properties
    let disposeBag = DisposeBag()
    
    private lazy var textField1:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    private lazy var textField2:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    private lazy var textField3:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    private lazy var result:UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField1, textField2, textField3, result])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    

    // MARK: Configure
    func configureUI() {
        view.backgroundColor = .systemPink
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        setResult()
    }
    
    // MARK: helpers
    func setResult() {
        Observable.combineLatest(
            textField1.rx.text.orEmpty,
            textField2.rx.text.orEmpty,
            textField3.rx.text.orEmpty
        ) { text1, text2, text3 -> Int in
            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
        }.map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }

}
