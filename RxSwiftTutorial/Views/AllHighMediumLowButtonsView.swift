//
//  AllHighMediumLowButtonsView.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import RxSwift

class AllHighMediumLowButtonsView: UIView {
    
    // MARK: Properties
    var selectedIndex:Int = 0
    
    private lazy var selectedIndexSubject = PublishSubject<Int>()
    
    var selectedIndexObservable:Observable<Int> {
        return selectedIndexSubject.asObservable()
    }
    
    private lazy var all:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("All", for: UIControl.State.normal)
        bt.backgroundColor = .systemBlue
        bt.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        bt.tag = 0
        return bt
    }()
    
    private lazy var high:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("High", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        bt.tag = 1
        return bt
    }()
    
    private lazy var medium:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("Medium", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        bt.tag = 2
        return bt
    }()
    
    private lazy var low:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("Low", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        bt.tag = 3
        return bt
    }()
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [all, high, medium, low])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 8
        return stack
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
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: Selectors
    @objc func buttonTapped(sender:UIButton) {
        makeAllButtonsWhite()
        
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sender.backgroundColor = .systemBlue
        
        selectedIndex = sender.tag
        self.selectedIndexSubject.onNext(sender.tag)
    }
    
    // MARK: Helpers
    func makeAllButtonsWhite() {
        all.backgroundColor = .white
        all.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        high.backgroundColor = .white
        high.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        medium.backgroundColor = .white
        medium.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        
        low.backgroundColor = .white
        low.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
    }
}
