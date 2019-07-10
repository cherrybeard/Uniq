//
//  Character.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Character {
    // stats
    var name: String
    var owner: Player? = nil
    var health: Value
    var isSelected: Bool = false
    var isExhausted: Bool = true
    var isDead: Bool { return health.current <= 0 }
    var isDamaged: Bool { return health.current < health.max }
    
    // sprites
    weak var sprite: CharacterSprite? = nil
    var actionsPanel: ActionsPanel? = nil
    
    init(name: String, health: Value) {
        self.name = name
        self.health = health
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
    
}
