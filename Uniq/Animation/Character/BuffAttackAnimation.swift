//
//  BuffAttackAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 30/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class BuffAttackAnimation: Animation {
    private let character: CharacterSprite
    private let amount: Int
    
    init(character: CharacterSprite, amount: Int) {
        self.character = character
        self.amount = amount
    }
    
    override func play() {
        character.addBuff(kind: .attack, value: amount)
        state = .finished
    }
    
}
