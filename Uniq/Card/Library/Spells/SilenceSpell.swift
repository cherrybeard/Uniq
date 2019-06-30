//
//  SilenceSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class SilenceSpell: SpellCard {
    init() {
        super.init(
            name: "Silence",
            spotsFilter: { !$0.owner.isActive && ($0.creature?.ability != nil) }
        )
        description = "Remove target creature's active ability."
        effect = {(batte: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                batte.replaceAbility(of: creature, with: nil)
                return true
            }
            return false
        }
    }
}
