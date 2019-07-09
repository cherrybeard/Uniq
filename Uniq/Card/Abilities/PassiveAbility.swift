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
    let effect: (Battle, Character?) -> ()
    
    init(effect: @escaping (Battle, Character?) -> () ) {
        self.effect = effect
    }
}
