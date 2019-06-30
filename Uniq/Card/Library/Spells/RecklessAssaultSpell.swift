//
//  RecklessAssaultSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class RecklessAssaultSpell: SpellCard {
    init() {
        super.init(name: "Reckless Assault")
        description = """
            Deals damage equal to your creatures count to random enemy. Repeat for each of your \
            creatures.
        """
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let damage = battle.spots.filter(SpotsFilters.ownerCreatures).count
            for _ in 1...damage {
                if let target = battle.spots.randomSpot(in: SpotsFilters.enemyCreatures) {
                    battle.dealDamage(damage, to: target)
                    battle.wait(for: 1)
                }
            }
            return true
        }
    }
}
