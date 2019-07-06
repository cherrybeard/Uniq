//
//  DeathAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 15/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DeathAnimation: Animation {
    private let character: CharacterSprite
    private static var action: SKAction {
        let shaking = SKAction.shake(duration: 0.5, amplitudeX: 5, amplitudeY: 5)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        return SKAction.group([shaking, fadeOut])
    }
    
    init(character: CharacterSprite) {
        self.character = character
    }
    
    override func play() {
        state = .finished
        character.run(DeathAnimation.action) {
            self.character.removeFromParent()
        }
    }
    
}
