//
//  TomeOfIntelligenceSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class TomeOfIntelligenceSpell: SpellCard {
    private static let ability = ActiveAbility(
        description: "Research",
        cooldown: 3,
        effect: { (battle: Battle, spot: Spot?) -> Bool in
            if let owner = spot?.owner {
                _ = battle.draw(for: owner)
                return true
            }
            return false
        }
    )
    
    init() {
        super.init(
            name: "Tome Of Intelligence",
            spotsFilter: SpotsFilters.ownerCreatures
        )
        description = """
            Replaces allied creature's ability with \(TomeOfIntelligenceSpell.ability.description).
        """
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                battle.replaceAbility(of: creature, with: TomeOfIntelligenceSpell.ability)
                return true
            }
            return false
        }
    }
}
