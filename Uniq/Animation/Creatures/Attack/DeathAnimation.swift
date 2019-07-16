//
//  DeathAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 15/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DeathAnimation: Animation {
    private static var action: SKAction {
        let shaking = SKAction.shake(duration: 0.5, amplitudeX: 5, amplitudeY: 5)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        return SKAction.group([shaking, fadeOut])
    }
    private let formation: FormationSprite
    private let index: Int
    
    init(formation: FormationSprite, at index: Int) {
        self.formation = formation
        self.index = index
    }
    
    override func play() {
        let character = formation.characters[index]
        character.run(DeathAnimation.action) {
            self.formation.remove(at: self.index)
        }
        state = .finished
    }
    
}
