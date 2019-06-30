//
//  HarmlessAffairSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//
//
class HarmlessAffairSpell: SpellCard {
    
    init() {
        super.init(
            name: "Harmless Affair",
            requiresTarget: false
        )
        description = "Summon 0/4 Fairies into your melee positions."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let spots = battle.spots.filter {
                $0.owner.isActive && ($0.range == .melee) && $0.isFree
            }
            for spot in spots {
                battle.summon("Fairy", to: spot.index)
            }
            return true
        }
    }
}
