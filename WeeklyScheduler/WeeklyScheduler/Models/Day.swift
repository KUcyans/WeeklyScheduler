//
//  Day.swift
//  WeeklyScheduler
//
//  Created by Cyan on 14/05/2024.
//

import Foundation

struct Day: Identifiable{
    let id = UUID()
    let name: String
    var tasks: [Task]
}
