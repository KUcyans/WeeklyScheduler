//
//  Task.swift
//  WeeklyScheduler
//
//  Created by Cyan on 14/05/2024.
//

import Foundation

struct Task: Identifiable{
    let id = UUID()
    var name: String
    var done: Bool = false
}
