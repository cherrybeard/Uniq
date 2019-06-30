//
//  Interactive.swift
//  Uniq
//
//  Created by Steven Gusev on 30/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//
enum InteractiveState: String {
    case interactive = "interactive"
    case interacted = "interacted"
    case targetable = "targetable"
    case targetted = "targetted"
    case activatable = "activatable"
    case activated = "activated"
}

protocol Interactive {
    var state: Set<InteractiveState> { get set }
    var targetsFilter: (Interactive) -> Bool { get }
}
