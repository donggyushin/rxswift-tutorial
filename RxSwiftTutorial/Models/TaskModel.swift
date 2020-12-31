//
//  TaskModel.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import Foundation

enum Priority:Int {
    case high
    case medium
    case low
}


struct Task {
    let title:String
    let priority: Priority
}
