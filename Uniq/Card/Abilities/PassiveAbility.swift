//
//  PassiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class PassiveAbility {
    var name: String = ""
    var description: String = ""
    let effect: (Battle, Spot?) -> Bool
    
    init(ability: @escaping (Battle, Spot?) -> Bool ) {
        self.effect = ability
    }
}
