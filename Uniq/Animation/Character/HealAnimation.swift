//
//  HealAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 30/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class HealAnimation: DamageAnimation {
    override func play() {
        label.amount = amount
        character.healthLabel.heal(amount)
        label.run(DamageAnimation.action) {
            self.label.removeFromParent()
            self.state = .finished
        }
    }
}
