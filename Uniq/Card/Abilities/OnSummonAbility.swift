//
//  OnSummonAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 01/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class OnSummonAbility {
    var name: String = ""
    var description: String = ""
    let effect: (Battle, Spot, Spot) -> ()
    //var filter: (Creature, Creature) -> Bool = { _ in true }
    
    init(effect: @escaping (Battle, Spot, Spot) -> () ) {
        self.effect = effect
    }
}
