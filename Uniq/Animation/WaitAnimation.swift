//
//  WaitAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class WaitAnimation: Animation {
    private let delay: TimeInterval
    private let battle: Battle
    private var action: SKAction {
        return SKAction.wait(forDuration: delay)
    }
    
    internal init(battle: Battle, delay: TimeInterval) {
        self.battle = battle
        self.delay = delay
    }

    override func play() {
        battle.run(action) {
            self.state = .finished
        }
    }
}
