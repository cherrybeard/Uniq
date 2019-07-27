//
//  SetExhaustionAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 26/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SetExhaustionAnimation: Animation {
    private let character: CharacterSprite
    private let exhausted: Bool
    
    init(character: CharacterSprite, to exhausted: Bool) {
        self.character = character
        self.exhausted = exhausted
    }
    
    override func play() {
        if let abilities = character.character.actionsPanel as? AbilitiesList {
            if exhausted {
                character.state.insert(.exhausted)
                for ability in abilities.buttons {
                    ability.state.insert(.disabled)
                }
            } else {
                character.state.remove(.exhausted)
                for ability in abilities.buttons {
                    ability.state.remove(.disabled)
                }
            }
        }
        state = .finished
    }
}
