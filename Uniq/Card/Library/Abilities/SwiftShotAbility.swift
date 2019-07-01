//
//  SwiftShotAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 01/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class SwiftShotAbility: PassiveAbility {
    private static let damage: Int = 2
    private static let targetsCount: Int = 2
    
    init() {
        super.init(
            effect: { (battle: Battle, spot: Spot?) -> Bool in
                var spots = battle.spots.filter(SpotsFilters.enemyCreatures).shuffled()
                for _ in 0..<SwiftShotAbility.targetsCount {
                    if let targetSpot = spots.first {
                        battle.dealDamage(SwiftShotAbility.damage, to: targetSpot)
                        spots.removeFirst()
                    } else {
                        break
                    }
                }
                return true
            }
        )
        name = "Swift Shot"
        description = """
            Deals \(SwiftShotAbility.damage) damage to \(SwiftShotAbility.targetsCount) random \
            enemy creatures.
        """
    }
}
