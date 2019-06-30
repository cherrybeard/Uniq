//
//  ChainLightningSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ChainLightningSpell: SpellCard {
    static private let damage: Int = 8
    
    init() {
        super.init(
            name: "Chain Lightning",
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = """
            Deals \(ChainLightningSpell.damage) to selected target. Deals 2 times less damage to \
            the random target next to it. Repeat it 2 times more.
        """
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if !(spot?.isFree ?? true) {
                var targetSpot = spot!
                for multiplier in [1, 0.5, 0.25, 0.125] {
                    let damage = Int(Double(ChainLightningSpell.damage) * multiplier)
                    battle.dealDamage(damage, to: targetSpot)
                    battle.wait(for: 0.7)
                    let neighbors = battle.spots.neighbors(of: targetSpot, sameOwner: false)
                    let notEmptyNeighbors = neighbors.filter(SpotsFilters.creatures)
                    if notEmptyNeighbors.count <= 0 { return true }
                    targetSpot = notEmptyNeighbors.randomElement()!
                }
            }
            return false
        }
    }
}
