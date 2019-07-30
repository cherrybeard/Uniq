//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbilityEffect {
    
    let name: String
    var cooldown: Int
    let immediatelyReady: Bool
    let targetFilter: CharacterFilter
    let requiresTarget: Bool
    
    init(
        name: String = "",
        cooldown: Int,
        immediatelyReady: Bool = true,
        requiresTarget: Bool = true,
        targetFilter: @escaping CharacterFilter = CharacterFilters.none
    ) {
        self.name = name
        self.cooldown = cooldown
        self.immediatelyReady = immediatelyReady
        self.requiresTarget = requiresTarget
        self.targetFilter = targetFilter
    }
    
    func effect(battle: Battle, caster: Creature, target: Character) {
        
    }
    
    func description(caster: Creature) -> String {
        return ""
    }
}
