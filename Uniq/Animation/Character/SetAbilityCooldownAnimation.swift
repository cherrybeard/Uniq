//
//  SetAbilityCooldownAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 27/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SetAbilityCooldownAnimation: Animation {
    private let ability: AbilityButton
    private let cooldown: Int
    
    init(ability: AbilityButton, cooldown: Int) {
        self.ability = ability
        self.cooldown = cooldown
    }
    
    override func play() {
        ability.cooldown = cooldown
        state = .finished
    }
}
