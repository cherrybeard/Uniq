//
//  BuffCardStatAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 30/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class BuffCardStatAnimation: Animation {
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
    
    init(card: CreatureCardSprite, stat: StatLabel.Kind, by amount: Int) {
        switch stat {
        case .attack:
            label = card.attackLabel
        default:
            label = card.healthLabel
        }
        self.amount = amount
        self.absolute = false
    }
    
    init(card: CreatureCardSprite, stat: StatLabel.Kind, to amount: Int) {
        switch stat {
        case .attack:
            label = card.attackLabel
        default:
            label = card.healthLabel
        }
        self.amount = amount
        self.absolute = true
    }
    
    override func play() {
        label.run(BuffCardStatAnimation.scaleUp) {
            if self.absolute {
                self.label.changeValue(to: self.amount, changeBase: false)
            } else {
                self.label.changeValue(by: self.amount)
            }
            self.label.run(BuffCardStatAnimation.scaleDown) {
                self.state = .finished
            }
        }
    }
}
