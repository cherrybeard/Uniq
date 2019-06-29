//
//  FanOfKnivesSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class FanOfKnivesSpell: SpellCard {
    static private let damage: Int = 1
    
    init() {
        super.init(name: "Fan of Knives")
        description = "Deal \(FanOfKnivesSpell.damage) damage to selected target and draw a card."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let targets = battle.spots.filter { !$0.owner.isActive && ($0.creature != nil) }
            for spot in targets {
                battle.dealDamage(FanOfKnivesSpell.damage, to: spot)
            }
            return true
        }
    }
}
