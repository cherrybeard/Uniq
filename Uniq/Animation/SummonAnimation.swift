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
    private let formation: Formation
    
    init(_ character: CharacterSprite, to formation: Formation) {
        self.character = character
        self.formation = formation
    }
    
    override func play() {
        var newIndex = formation.characters.endIndex
        if (newIndex > 0) && formation.characters[0] is HeroSprite {
            newIndex = 0
        }
        formation.characters.insert(character, at: newIndex)
        
        character.alpha = 0
        character.setScale(1.2)
        formation.addChild(character)
        
        let total = formation.characters.count
        for (index, character) in formation.characters.enumerated() {
            let position = Formation.getPosition(of: index, total: total)
            if index != newIndex {
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
