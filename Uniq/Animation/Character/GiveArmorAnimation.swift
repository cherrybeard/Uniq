//
//  GiveArmorAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 29/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class GiveArmorAnimation: DamageAnimation {
    override func play() {
        label.amount = amount
        character.healthLabel.heal(0, armor: amount)
        label.run(DamageAnimation.action) {
            self.label.removeFromParent()
            self.state = .finished
        }
    }
}
