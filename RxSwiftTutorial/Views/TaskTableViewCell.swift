//
//  TaskTableViewCell.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var task:Task? {
        didSet {
            guard let task = self.task else { return }
            self.taskLabel.text = task.title
        }
    }
    
    private lazy var taskLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(taskLabel)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        taskLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
