//
//  CreatureCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureCard: Card {
    var attack: Value
    var health: HealthLabel.Health
    var abilities: [ActiveAbility] = []
    var hasRush: Bool = false
    var power: Int = 0
    
    init(name: String, attack: Int, health: Int) {
        self.attack = Value(attack)
        self.health = HealthLabel.Health(health)
        super.init(name: name, requiresTarget: false)
        sprite = CreatureCardSprite()
        sprite.card = self
    }
    
    init(name: String, attack: Value, health: HealthLabel.Health) {
        self.attack = attack
        self.health = health
        super.init(
            name: name,
            requiresTarget: false
        )
        sprite = CreatureCardSprite()
        sprite.card = self
    }
    
    override func play(battle: Battle, for player: Player?, target: Character?) {
        let creature = Creature(of: self)
        _ = battle.place(creature, for: player ?? battle.activePlayer)
    }
    /*
    func increaseStat(_ stat: StatLabel.Kind, by amount: Int) {
        switch stat {
        case .attack:
            attack.current += amount
            attack.max += amount
        default:
            health.current += amount
            health.max += amount
        }
    }*/
    
    override func copy() -> CreatureCard {
        let card = CreatureCard(name: name, attack: attack, health: health)
        card.description = description
        card.abilities = abilities
        card.hasRush = hasRush
        card.power = power
        return card
    }
}
