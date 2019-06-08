//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbility {
    let cooldown: Int
    let ability: (Battle, Spot?) -> Bool
    
    init(description: String = "", cooldown: Int, ability: @escaping (Battle, Spot?) -> Bool) {
        self.cooldown = cooldown
        self.ability = ability
    }
}
