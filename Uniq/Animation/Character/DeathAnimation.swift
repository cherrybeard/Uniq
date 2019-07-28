//
//  DeathAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 15/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DeathAnimation: Animation {
    private static let moveDuration: TimeInterval = 0.5
    private static let deathDuration: TimeInterval = 0.8
    private static var action: SKAction {
        let scaleOut = SKAction.scale(to: 0.8, duration: deathDuration)
        let shaking = SKAction.shake(amplitudeX: 5, amplitudeY: 5, duration: deathDuration)
        let fadeOut = SKAction.fadeOut(withDuration: deathDuration)
        return SKAction.group([scaleOut, shaking, fadeOut])
    }
    private static let waitAction = SKAction.wait(forDuration: 0.2)
    private let formation: FormationSprite
    private let index: Int
    
    init(formation: FormationSprite, at index: Int) {
        self.formation = formation
        self.index = index
    }
    
    override func play() {
        for (i, character) in formation.characters.enumerated() {
            let xPos = formation.getXPosition(of: i, removedIndex: index)
            let position = CGPoint(x: xPos, y: 0)
            if i != index {
                let move = SKAction.move(to: position, duration: DeathAnimation.moveDuration)
                let waitAndMove = SKAction.sequence([DeathAnimation.waitAction, move])
                character.run(waitAndMove)
            } else {
                character.zPosition = -1
                character.run(DeathAnimation.action) {
                    self.formation.remove(at: self.index)
                    self.state = .finished
                }
            }
        }
    }
    
}
