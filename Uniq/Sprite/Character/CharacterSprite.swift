//
//  CharacterSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 09/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

enum OwnerType: Int {
    case player = 0, computer
}

class CharacterSprite: SKNode {
    var owner: OwnerType = .player
    var destroyed: Bool = false         //TODO: Combine with dead in one state var
    var dead: Bool = false
    
    internal var _maxHealth: Int = 1
    internal var _health: Int = 1
    var health: Int {
        get { return _health }
    }
    
    internal var _attack: Int = 0
    var attack: Int {
        get { return _attack }
    }
    
    private var _isTarget: Bool = false
    var isTarget: Bool {
        get { return _isTarget }
        set(newValue) {
            _isTarget = newValue
            redrawBorder()
        }
    }
    
    private var _canAttack: Bool = false
    var canAttack: Bool {
        get { return _canAttack }
        set(newValue) {
            _canAttack = newValue
            redrawBorder()
        }
    }
    
    var isFullHealth: Bool {
        get { return _health == _maxHealth }
    }
    
    let healthLabel: StatLabel
    let damageLabel = DamageLabel()
    
    static let destroyAction: SKAction = SKAction.sequence([
        SKAction.wait(forDuration: 0.3),
        SKAction.fadeOut(withDuration: 0.2),
        SKAction.wait(forDuration: 0.1)
    ])
    
    init(owner: OwnerType) {
        self.owner = owner
        healthLabel = StatLabel(type: .health, value: _health)
        
        super.init()
        
        damageLabel.position = CGPoint(x: 0, y: -10)
        damageLabel.zPosition = 200
        addChild(healthLabel)
        addChild(damageLabel)
        
        name = NodeType.character.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func redrawBorder() { }
    
    func dealDamage(_ damage: Int) {
        applyDamage(damage)
        showDamage(damage)
    }
    
    func applyDamage(_ damage: Int) {
        _health -= damage
        if _health <= 0 { dead = true }
    }
    
    func showDamage(_ damage: Int) {
        healthLabel.value -= damage
        damageLabel.show(damage: damage)
        healthLabel.state = .damaged
        
        if healthLabel.value <= 0 {
            self.run(CreatureSprite.destroyAction, completion: {
                self.destroyed = true
            })
        }
    }
    
    func increaseHealth(by amount: Int) {
        _health += amount
        _maxHealth += amount
        healthLabel.value = _health
        if healthLabel.state == .initial {
            healthLabel.state = .buffed
        }
    }
    
    func restoreHealth(by amount: Int) {
        let newHealth = _health + amount
        if newHealth >= _maxHealth {
            _health = _maxHealth
            healthLabel.state = .buffed
        } else {
            _health = newHealth
        }
    }
}
