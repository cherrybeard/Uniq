//
//  SummonAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SummonAnimation: Animation {
    private let creature: CreatureSprite
    private let position: CGPoint
    private let battle: Battle
    private static let action = SKAction.scale(to: 1, duration: 0.3)
    
    init(_ creature: CreatureSprite, at spot: Spot, battle: Battle) {
        self.creature = creature
        self.position = spot.position
        self.battle = battle
    }
    
    override func play() {
        creature.setScale(1.2)
        creature.position = position
        creature.zRotation = CGFloat.random(in: -3...3) / 180 * .pi
        battle.addChild(creature)
        creature.run(SummonAnimation.action) {
            self.state = .finished
        }
    }
}
