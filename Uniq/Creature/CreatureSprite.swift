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
    
    private let healthLabel: SKLabelNode
    private let attackLabel: SKLabelNode
    private let border: SKShapeNode
    let damageLabel: SKLabelNode
    private let actionAvailableBorder = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)
    private let defaultBorder = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
    
    private let damageAction: SKAction
    private let destroyAction: SKAction = SKAction.sequence([
        SKAction.wait(forDuration: 0.3),
        SKAction.fadeOut(withDuration: 0.2),
        SKAction.wait(forDuration: 0.1)
    ])
    
    private var _canAttack: Bool = false
    var canAttack: Bool {
        get { return _canAttack }
        set(newValue) {
            _canAttack = newValue
            redrawBorder()
        }
    }
    
    var dead: Bool = false
    
    var health: Int {
        get { return Int(healthLabel.text!)! }
        set(newValue) {
            healthLabel.text = String(newValue)
        }
    }
    
    let width: Int = 50
    let height: Int = 90
    
    init(creature: CreatureCard, owner: OwnerType) {
        self.creature = creature
        self.owner = owner
        
        attackLabel = SKLabelNode(text: String(creature.attack))
        healthLabel = SKLabelNode(text: String(creature.health))
        border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        damageLabel = SKLabelNode(text: "-1")
        
        let damageAppear = SKAction.group([
            SKAction.fadeIn(withDuration: 0.1),
            SKAction.scale(to: 1.4, duration: 0.1)
            ])
        damageAppear.timingMode = .easeIn
        
        let damageHide = SKAction.fadeOut(withDuration: 0.1)
        damageHide.timingMode = .easeIn
        
        damageAction = SKAction.sequence([
            damageAppear,
            SKAction.scale(to: 1, duration: 0.1),
            SKAction.wait(forDuration: 0.5),
            damageHide
        ])
        
        super.init()
        
        redrawBorder()
        addChild(border)
        
        let attackBorder = SKShapeNode(circleOfRadius: 12)
        attackBorder.position = CGPoint(x: -width/2 + 6, y: -height/2 + 6)
        attackBorder.lineWidth = 0
        attackBorder.fillColor = UIColor(hue: 353.0/360.0, saturation: 90.0/100.0, brightness: 69.0/100.0, alpha: 1)
        addChild(attackBorder)
        
        setLabelStyle(label: attackLabel)
        attackLabel.position = CGPoint(x: -width/2 + 6, y: -height/2 - 7 + 6)
        addChild(attackLabel)
        
        let healthBorder = SKShapeNode(circleOfRadius: 12)
        healthBorder.position = CGPoint(x: width/2 - 6, y: -height/2 + 6)
        healthBorder.lineWidth = 0
        healthBorder.fillColor = UIColor(hue: 35.0/360.0, saturation: 76.0/100.0, brightness: 72.0/100.0, alpha: 1)
        addChild(healthBorder)
        
        setLabelStyle(label: healthLabel)
        healthLabel.position = CGPoint(x: width/2 - 1 - 6, y: -height/2 - 7 + 6)
        addChild(healthLabel)
        
        damageLabel.fontColor = SKColor.white
        damageLabel.fontName = "AvenirNext-Bold"
        damageLabel.fontSize = 32
        damageLabel.position = CGPoint(x: 0, y: -10)
        damageLabel.alpha = 0
        addChild(damageLabel)
        
        name = (self.owner == OwnerType.player) ? "player-creature" : "computer-creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabelStyle(label: SKLabelNode) {
        label.fontColor = SKColor.white
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 17
    }
    
    func redrawBorder() {
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.strokeColor = (canAttack && (owner == OwnerType.player)) ? actionAvailableBorder : defaultBorder
        border.lineWidth = 1
    }
    
    func applyDamage(damage: Int) {
        creature.health -= damage
    }
    
    func showDamage(damage: Int) {
        damageLabel.setScale(0.5)
        damageLabel.text = "-" + String(damage)
        health -= damage
        damageLabel.run(damageAction)
        
        if health <= 0 {
            self.run(destroyAction, completion: {
                self.dead = true
            })
        }
    }
    
    func increaseHealth(amount: Int) {
        creature.health += amount
    }
}
