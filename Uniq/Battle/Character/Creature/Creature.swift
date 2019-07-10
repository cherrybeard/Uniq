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
    
    //var attack: Value
    //var whenSummoned: PassiveAbility?
    //var onSummon: OnSummonAbility?

    
    init(of card: CreatureCard) {
        self.card = card
        abilities = card.abilities  // TODO: Copy abilities?
        super.init(name: card.name, health: card.health)
    }
    
    override func generateSprite() -> CharacterSprite {
        return CreatureSprite(self)
    }
    
    override func generatePanel() -> ActionsPanel {
        return AbilitiesList(abilities)
    }
    
}
