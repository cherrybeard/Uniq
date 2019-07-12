//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbility {
    let name: String
    let description: String
    var left: Int
    var cooldown: Int
    let effect: (Battle, Character?) -> ()
    let targetFilter: CharacterFilter
    let requiresTarget: Bool
    
    init(
        name: String = "",
        description: String = "",
        cooldown: Int,
        effect: @escaping (Battle, Character?) -> (),
        requiresTarget: Bool = true,
        targetFilter: @escaping CharacterFilter = CharacterFilters.none
    ) {
        self.name = name
        self.description = description
        self.cooldown = cooldown
        self.left = cooldown
        self.effect = effect
        self.requiresTarget = requiresTarget
        self.targetFilter = targetFilter
    }
    
    func copy() -> ActiveAbility {
        let ability = ActiveAbility(
           description: description,
           cooldown: cooldown,
           effect: effect,
           requiresTarget: requiresTarget,
           targetFilter: targetFilter
        )
        return ability
    }
}
