//
//  ShieldAlliesAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 16/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ShieldAlliesAbility: ActiveAbilityEffect {
    let armor: Int
    
    init(armor: Int) {
        self.armor = armor
        super.init(
            name: "Shield allies",
            cooldown: 1,
            targetFilter: { $0.sprite?.state.contains(.selected) ?? false }
        )
    }
    
    override func description(caster: Creature) -> String {
        return "Taunt. Increase all allies armor by \(armor)."
    }
    
    override func effect(battle: Battle, caster: Creature, target: Character) {
        guard let allies = caster.owner?.formation.characters else { return }
        for ally in allies {
            battle.giveArmor(armor, to: ally)
        }
    }
}
