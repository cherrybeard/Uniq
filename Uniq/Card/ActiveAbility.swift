//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbility {
    let cooldown: Int
    let ability: (Battle, Creature?) -> Bool
    
    init(description: String = "", cooldown: Int, ability: @escaping (Battle, Creature?) -> Bool) {
        self.cooldown = cooldown
        self.ability = ability
    }
}
