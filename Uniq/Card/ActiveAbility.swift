//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbility {
    let description: String
    var left: Int
    var cooldown: Int
    let effect: (Battle, Spot?) -> Bool
    
    init(description: String = "", cooldown: Int, effect: @escaping (Battle, Spot?) -> Bool) {
        self.description = description
        self.cooldown = cooldown
        self.left = cooldown
        self.effect = effect
    }
    
    func copy() -> ActiveAbility {
        let ability = ActiveAbility(
           description: description,
           cooldown: cooldown,
           effect: effect
        )
        return ability
    }
}
