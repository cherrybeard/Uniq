//
//  HideAbilitiesListAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class HideAbilitiesListAnimation: Animation {
    private static let action = SKAction.fadeOut(withDuration: 0.3)
    private let list: AbilitiesList
    
    init(_ list: AbilitiesList) {
        self.list = list
    }
    
    override func play() {
        list.run(HideAbilitiesListAnimation.action) {
            self.state = .finished
        }
    }
}
