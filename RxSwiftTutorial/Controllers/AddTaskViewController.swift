//
//  AddTaskViewController.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    // MARK: Properties
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable:Observable<Task> {
        return taskSubject.asObservable()
    }
    
    private lazy var saveButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("Save", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(saveTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var buttons:HighMediumLowButtons = {
        let bts = HighMediumLowButtons()
        return bts
    }()
    
    private lazy var textField:TextField = {
        let tf = TextField()
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        return tf
    }()
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        view.addSubview(buttons)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        buttons.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        buttons.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        buttons.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        buttons.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: buttons.bottomAnchor, constant: 20).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true 
    }
    
    // MARK: Selectors
    @objc func saveTapped() {
        guard let priority = Priority(rawValue: buttons.selectedIndex) else { return }
        guard let text = textField.text else { return }
        if text.isEmpty { return }
        let task = Task(title: text, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }

}
