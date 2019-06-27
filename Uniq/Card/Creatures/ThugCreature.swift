//
//  ThugCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ThugCreature: CreatureCard {
     init() {
        super.init(name: "Thug", attack: 1, health: 8)
        /*
        whenSummoned = PassiveAbility(
            ability: { (battle: Battle, spot: Spot?) -> Bool in
                if let summonedPlayer = spot?.owner {
                    let enemySpots = battle.spots.filter { $0.owner != summonedPlayer }
                    for targetSpot in enemySpots {
                        battle.dealDamage(1, to: targetSpot)
                        return true
                    }
                }
                return false
            }
        )*/
    }
}
