//
//  DeathAnimaiton.swift
//  Uniq
//
//  Created by Steven Gusev on 15/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DeathAnimation: Animation {
    private let spot: Spot
    private var action: SKAction {
        let shaking = SKAction.shake(duration: 0.5, amplitudeX: 5, amplitudeY: 5)
        let targetFadeOut = SKAction.fadeOut(withDuration: 1)
        return SKAction.group([shaking, targetFadeOut])
    }
    
    init(spot: Spot) {
        self.spot = spot
    }
    
    override func play() {
        self.state = .finished
        if let creature = spot.creature?.sprite {
            creature.run(action) {
                creature.removeFromParent()
            }
        }
    }
    
}
