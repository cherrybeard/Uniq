//
//  Character.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Character {
    // Stats
    var name: String
    var owner: Player? = nil
    var formationIndex: Int = -1
    var health: HealthLabel.Health
    var attack: Int
    var isExhausted: Bool = true
    var isDead: Bool { return health.current <= 0 }
    var isDamaged: Bool { return health.current < health.max }
    
    // Sprites
    weak var sprite: CharacterSprite? = nil
    var actionsPanel: ActionsPanel? = nil
    
    init(name: String, health: HealthLabel.Health, attack: Int) {
        self.name = name
        self.health = health
        self.attack = attack
    }
    
    func generateSprite() -> CharacterSprite {
        return CharacterSprite(self)
    }
    
    func generatePanel() -> ActionsPanel {
        return ActionsPanel()
    }
    
    func dealDamage(_ amount: Int) {
        health.current -= amount
    }
    
    func heal(_ amount: Int) -> Int {
        var healed = health.max - health.current
        if healed > amount {
            healed = amount
        }
        health.current += healed
        return healed
    }
    
    func giveArmor(_ amount: Int) {
        health.armor += amount
    }
    
    func buffAttack(by amount: Int) {
        attack += amount
    }
    
}
