//
//  SummonAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SummonAnimation: Animation {
    private static let moveDuration: TimeInterval = 0.3
    private static let appearDuration: TimeInterval = 0.3
    private static var action: SKAction {
        let wait = SKAction.wait(forDuration: SummonAnimation.moveDuration)
        let move = SKAction.scale(to: 1, duration: SummonAnimation.appearDuration)
        let fadeIn = SKAction.fadeIn(withDuration: SummonAnimation.appearDuration)
        let appear = SKAction.group([move, fadeIn])
        return SKAction.sequence([wait, appear])
    }
    
    private let character: CharacterSprite
    private let formation: FormationSprite
    private let index: Int
    
    init(_ character: CharacterSprite, to formation: FormationSprite, at index: Int) {
        self.character = character
        self.formation = formation
        self.index = index
    }
    
    override func play() {
        formation.add(character, at: index)
        
        for (i, character) in formation.characters.enumerated() {
            let xPos = formation.getXPosition(of: i)
            let position = CGPoint(x: xPos, y: 0)
            if i != index {
                let move = SKAction.move(to: position, duration: SummonAnimation.moveDuration)
                character.run(move)
            } else {
                character.position = position
                character.run(SummonAnimation.action) {
                    self.state = .finished
                }
            }
        }
    }
    
}
