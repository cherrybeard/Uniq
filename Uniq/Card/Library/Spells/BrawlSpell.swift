//
//  BrawlSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BrawlSpell: SpellCard {
    
    init() {
        super.init(name: "Brawl")
        description = "Destroy all creatures except random one."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            var spots = battle.spots.shuffledSpots { $0.creature != nil }
            _ = spots.remove(at: 0)
            for spot in spots {
                if let creature = spot.creature {
                    battle.dealDamage(creature.health, to: spot)
                    battle.wait(for: 0.7)
                }
            }
            return true
        }
    }
}
