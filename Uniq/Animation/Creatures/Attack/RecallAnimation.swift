//
//  RecallAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 30/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//


import SpriteKit

class RecallAnimation: Animation {
    private static let duration: TimeInterval = 0.5
    private static var action: SKAction {
        let rotate = SKAction.rotate(toAngle: 0, duration: RecallAnimation.duration)
        let fadeOut = SKAction.fadeOut(withDuration: RecallAnimation.duration)
        let scale = SKAction.scale(to: 1.2, duration: RecallAnimation.duration)
        let group = SKAction.group([rotate, fadeOut, scale])
        group.timingMode = .easeOut
        return group
    }
    private let creature: CreatureSprite
    
    init(creature: CreatureSprite) {
        self.creature = creature
    }
    
    override func play() {
        creature.run(RecallAnimation.action) {
            self.creature.removeFromParent()
            self.state = .finished
        }
    }
    
}
