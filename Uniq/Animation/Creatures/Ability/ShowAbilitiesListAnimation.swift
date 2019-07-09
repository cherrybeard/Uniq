//
//  ShowAbilitiesListAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class ShowAbilitiesListAnimation: Animation {
    // TODO: Add a fly-in from the side
    private static let action = SKAction.fadeIn(withDuration: 0.3)
    private let character: CharacterSprite
    private let list: AbilitiesList
    
    init(of character: CharacterSprite) {
        self.character = character.sprite
        self.list = character.abilitiesList
    }
    
    override func play() {
        character.isSelected = true
        character.abilitiesList.run(ShowAbilitiesListAnimation.action) {
            self.state = .finished
        }
    }
}
