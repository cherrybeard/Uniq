//
//  BuffStatAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 26/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class BuffStatAnimation: Animation {
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
    private let label: StatLabel
    private let amount: Int
    private let absolute: Bool
    
    init(creature: CreatureSprite, stat: StatLabel.Kind, by amount: Int) {
        switch stat {
        case .attack:
            label = creature.attackLabel
        default:
            label = creature.healthLabel
        }
        self.amount = amount
        self.absolute = false
    }
    
    init(creature: CreatureSprite, stat: StatLabel.Kind, to amount: Int) {
        switch stat {
        case .attack:
            label = creature.attackLabel
        default:
            label = creature.healthLabel
        }
        self.amount = amount
        self.absolute = true
    }
    
    override func play() {
        label.run(BuffStatAnimation.scaleUp) {
            if self.absolute {
                self.label.changeValue(to: self.amount, changeBase: false)
            } else {
                self.label.changeValue(by: self.amount)
            }
            self.label.run(BuffStatAnimation.scaleDown) {
                self.state = .finished
            }
        }
    }
}
