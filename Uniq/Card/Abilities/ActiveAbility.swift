//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 29/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbility {
    weak var caster: Creature? = nil
    let effect: ActiveAbilityEffect
    var cooldown: Int
    var isDisabled: Bool = false
    weak var button: AbilityButton? = nil
    var isReady: Bool {
        return (cooldown == 0) && !isDisabled
    }
    var description: String {
        guard let caster = caster else { return "" }
        return effect.description(caster: caster)
    }
    
    init(_ effect: ActiveAbilityEffect, caster: Creature) {
        self.effect = effect
        self.caster = caster
        cooldown = effect.immediatelyReady ? 0 : effect.cooldown
    }
    
    func use(battle: Battle, target: Character) {
        guard let caster = caster else { return }
        effect.effect(battle: battle, caster: caster, target: target)
    }
    
    func resetCooldown() {
        cooldown = effect.cooldown
    }
    
    func decreaseCooldown() {
        if cooldown > 0 {
            cooldown -= 1
        }
    }
}
