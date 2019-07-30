//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class Creature: Character {
    var card: CreatureCard
    var abilities: [ActiveAbility] = []
    override var isExhausted: Bool { didSet {
        for ability in abilities {
            ability.isDisabled = isExhausted
        }
    } }
    
    //var whenSummoned: PassiveAbility?
    //var onSummon: OnSummonAbility?

    init(of card: CreatureCard) {
        self.card = card
        super.init(name: card.name, health: card.health, attack: card.attack.base)
        
        for ability in card.abilities {
            abilities.append(
                ActiveAbility(ability, caster: self)
            )
        }
    }
    
    override func generateSprite() -> CharacterSprite {
        return CreatureSprite(self)
    }
    
    override func generatePanel() -> ActionsPanel {
        return AbilitiesList(abilities)
    }
    
}
