//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

enum OwnerType: Int {
    case player = 0, computer
}

class CreatureSprite: SKNode {
    var creature: CreatureCard
    var owner: OwnerType
    var destroyed: Bool = false
    var dead: Bool = false
    
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
        get { return healthLabel.state != .damaged }
    }
    
    var health: Int {
        get { return Int(healthLabel.text)! }
        set(newValue) { healthLabel.text = String(newValue) }
    }
    
    private let healthLabel: StatLabel
    private let attackLabel: StatLabel
    private let border: SKShapeNode
    private let damageLabel: DamageLabel
    
    static let destroyAction: SKAction = SKAction.sequence([
        SKAction.wait(forDuration: 0.3),
        SKAction.fadeOut(withDuration: 0.2),
        SKAction.wait(forDuration: 0.1)
    ])
    
    private let width: Int = 50
    private let height: Int = 90
    
    init(creature: CreatureCard, owner: OwnerType) {
        self.creature = creature
        self.owner = owner
        
        attackLabel = StatLabel(type: .attack, text: String(creature.attack))
        healthLabel = StatLabel(type: .health, text: String(creature.health))
        border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        damageLabel = DamageLabel()
        
        super.init()
        
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.lineWidth = 1
        redrawBorder()
        addChild(border)
        
        attackLabel.position = CGPoint(x: -width/2 + 6, y: -height/2 + 6)
        addChild(attackLabel)
        
        healthLabel.position = CGPoint(x: width/2 - 6, y: -height/2 + 6)
        addChild(healthLabel)
        
        damageLabel.position = CGPoint(x: 0, y: -10)
        addChild(damageLabel)
        
        name = (self.owner == .player) ? "player-creature" : "computer-creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redrawBorder() {
        if isTarget {
            border.strokeColor = UIColor(hue: 33.0/360.0, saturation: 70.0/100.0, brightness: 81.0/100.0, alpha: 1)
        } else if canAttack && (owner == OwnerType.player) {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 80.0/100.0, alpha: 1)
        } else {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
        }
    }
    
    func dealDamage(_ damage: Int) {
        applyDamage(damage)
        showDamage(damage)
    }
    
    func applyDamage(_ damage: Int) {
        creature.health -= damage
        if creature.health <= 0 {
            dead = true
        }
    }
    
    func showDamage(_ damage: Int) {
        health -= damage
        damageLabel.show(damage: damage)
        healthLabel.state = .damaged
        
        if health <= 0 {
            self.run(CreatureSprite.destroyAction, completion: {
                self.destroyed = true
            })
        }
    }
    
    func increaseHealth(amount: Int) {
        creature.health += amount
        healthLabel.state = .buffed
    }
}
