//
//  Hero.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Hero: Character {
    var sprite: CharacterSprite
    var health: Value
    var isDead: Bool { return health.current <= 0 }
    
    init() {
        health = Value(16)
        sprite = HeroSprite(health: health)
    }
    
    func dealDamage(_ amount: Int) {
        health.current -= amount
    }
}
