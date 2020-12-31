//
//  TaskListController.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit
import RxSwift
import RxCocoa

private let taskTableViewCell = "taskTableViewCell"


class TaskListController: UIViewController {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTask = [Task]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "List"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var plusButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.contactAdd)
        bt.addTarget(self, action: #selector(addButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var buttons:AllHighMediumLowButtonsView = {
        let bts = AllHighMediumLowButtonsView()
        bts.selectedIndexObservable.subscribe(onNext: { selectedIndex in
            let priority = Priority(rawValue: selectedIndex - 1)
            self.filterTasks(priority: priority)
        }).disposed(by: disposeBag)
        return bts
    }()

    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: taskTableViewCell)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: plusButton)
        
        view.addSubview(buttons)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        buttons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        buttons.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        buttons.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttons.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: buttons.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: Selectors
    @objc func addButtonTapped() {
        let addTaskController = AddTaskViewController()
        addTaskController.taskSubjectObservable.subscribe(onNext: { task in
            
            let priority = Priority(rawValue: self.buttons.selectedIndex - 1)
            
            
            var values = self.tasks.value
            values.append(task)
            self.tasks.accept(values)
            self.filterTasks(priority: priority)
        }).disposed(by: disposeBag)
        self.present(addTaskController, animated: true, completion: nil)
    }
    
    // MARK: Helpers
    func filterTasks(priority:Priority?) {
        
        if priority == nil {
            self.filteredTask = self.tasks.value
        }else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: {tasks in
                self.filteredTask = tasks
            }).disposed(by: self.disposeBag)
        }
        
    }

}


extension TaskListController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: taskTableViewCell) as! TaskTableViewCell
        cell.task = self.filteredTask[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
