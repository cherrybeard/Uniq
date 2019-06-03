//
//  Interactive.swift
//  Uniq
//
//  Created by Steven Gusev on 30/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//
enum InteractiveStatus {
    case interactive, interacted, targetable, targetted, activatable, activated
}

protocol Interactive {
    var status: Set<InteractiveStatus> { get set }
    var targetsFilter: (Interactive) -> Bool { get }
}
