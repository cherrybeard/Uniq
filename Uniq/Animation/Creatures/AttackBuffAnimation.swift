//
//  AttackBuffAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 26/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackBuffAnimation: Animation {
    private static var scaleUp: SKAction {
        let action = SKAction.scale(to: 2.5, duration: 0.1)
        action.timingMode = .easeOut
        return action
    }
    private static var scaleDown: SKAction {
        let action = SKAction.scale(to: 1, duration: 0.7)
        action.timingMode = .easeIn
        return action
    }
    private let label: AttackLabel
    private let attack: Int
    
    init(creature: CreatureSprite, attack: Int) {
        label = creature.attackLabel
        self.attack = attack
    }
    
    override func play() {
        label.run(AttackBuffAnimation.scaleUp) {
            self.label.isBuffed = self.attack > self.label.attack
            self.label.attack = self.attack
            self.label.run(AttackBuffAnimation.scaleDown) {
                self.state = .finished
            }
        }
    }
}
