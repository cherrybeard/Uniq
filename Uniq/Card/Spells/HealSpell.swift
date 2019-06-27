//
//  HealSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class HealSpell: SpellCard {
    static private let heal: Int = 4
    
    init() {
        super.init(name: "Heal")
        description = "Heals \(HealSpell.heal) to selected target."
        requiresTarget = true
        spotsFilter = { $0.owner.isActive && ($0.creature?.isDamaged ?? false) }
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if spot?.creature != nil {
                battle.heal(HealSpell.heal, to: spot!)
                return true
            }
            return false
        }
    }
}
