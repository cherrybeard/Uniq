//
//  Character.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

protocol Character {
    var health: Value { get }
    var sprite: CharacterSprite { get }
    var isDead: Bool { get }
    func dealDamage(_ amount: Int)
}
