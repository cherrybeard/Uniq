//
//  Targetable.swift
//  Uniq
//
//  Created by Steven Gusev on 07/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

protocol Targetable {
    var isPossibleTarget: Bool { get set }
    var isCurrentTarget: Bool { get set }
}
