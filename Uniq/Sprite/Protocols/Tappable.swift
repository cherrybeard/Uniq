//
//  Tappable.swift
//  Uniq
//
//  Created by Steven Gusev on 11/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import Foundation

protocol Tappable {
    var isPosssibleToTap: Bool { get set }
    var isCurrentlyTapped: Bool { get set }
}
