//
//  RootViewController.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    private lazy var timeLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var callButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("API 호출", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(callButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var textView:UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .systemBackground
        return tv
    }()

    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(callSetTimeLabelText), userInfo: nil, repeats: true)
    }
    
    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemOrange
        
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        view.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        callButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        callButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 10).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: Selectors
    @objc func callSetTimeLabelText() {
        self.setTimeLabelText()
    }
    
    @objc func callButtonTapped() {
//        NewsApiService.shared.fetchNews { (news, error) in
//            if let error = error {
//                print("에러 발생:\(error.localizedDescription)")
//            }
//            
//            if let news = news {
//                self.textView.text = news
//            }
//        }
        
        
        NewsApiService.shared.fetchNewsRx().subscribe(onNext: {news in
            self.textView.text = news
        }, onError: {error in
            print("에러 발생: \(error.localizedDescription)")
        }).disposed(by: disposeBag)
    }
    
    
    
    
    // MARK: Helpers
    func setTimeLabelText() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(Calendar.Component.hour, from: date)
        let minute = calendar.component(Calendar.Component.minute, from: date)
        let second = calendar.component(Calendar.Component.second, from: date)
        let nanoSecond = calendar.component(Calendar.Component.nanosecond, from: date)
        
        self.timeLabel.text = "\(hour):\(minute):\(second):\(nanoSecond)"
    }

}
