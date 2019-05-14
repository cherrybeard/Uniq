//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: SKNode, Targetable, Tappable {
    private let WIDTH: Int = 90
    private let HEIGHT: Int = 60
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644, alpha: 1)
        static let tapped = UIColor(rgb: 0x614F3F, alpha: 1)
        static let currentTarget = UIColor(rgb: 0x614F3F, alpha: 1)
    }
    private let FILL_COLOR: UIColor = UIColor(rgb: 0x111111, alpha: 1)
    
    var owner: Player
    var creature: CreatureCard
    
    private var _maxHealth: Int
    private var _health: Int
    var health: Int {
        get { return _health }
    }
    
    private var _attack: Int
    var attack: Int {
        get { return _attack }
    }
    
    private var _activeAbilityCooldown: Int = -1
    var activeAbilityCooldown: Int {
        get { return _activeAbilityCooldown }
    }
    
    private let healthLabel: StatLabel
    private let attackLabel: StatLabel
    private let border: SKShapeNode
    
    var isPossibleTarget: Bool = false
    var isCurrentlyTapped: Bool = false
    
    private var _isCurrentTarget: Bool = false
    var isCurrentTarget: Bool {
        get { return _isCurrentTarget }
        set(newValue) {
            _isCurrentTarget = newValue
            _redraw()
        }
    }
    
    init(of creature: CreatureCard, owner: Player) {
        self.creature = creature
        self.owner = owner
        
        _attack = creature.attack
        _maxHealth = creature.health
        _health = _maxHealth
        _activeAbilityCooldown = creature.activeAbilityCooldown
        
        border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        attackLabel = StatLabel(type: .attack, value: creature.attack)
        healthLabel = StatLabel(type: .health, value: _health)
        
        super.init()
        
        self.creature.summon = self
        
        healthLabel.value = _health
        attackLabel.value = _attack
        attackLabel.position = CGPoint(x: -WIDTH/2 + 6, y: -HEIGHT/2 + 6)
        healthLabel.position = CGPoint(x: WIDTH/2 - 6, y: -HEIGHT/2 + 6)
        healthLabel.zPosition = 1
        
        border.lineWidth = 1
        border.fillColor = FILL_COLOR
        
        addChild(border)
        addChild(attackLabel)
        addChild(healthLabel)
        _redraw()
        name = "creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        if _isCurrentTarget {
            border.strokeColor = BORDER_COLOR.currentTarget
        } else {
            border.strokeColor = BORDER_COLOR.base
        }
    }
    
    func increaseAttack(by amount: Int) {
        _attack += amount
        attackLabel.value = _attack
        attackLabel.state = .buffed
    }
    
    func decreaseAbilityCooldown() {
        if _activeAbilityCooldown > 0 {
            _activeAbilityCooldown -= 1
        }
    }
    
    func useActiveAbility(battle: Battle) -> Bool {
        if _activeAbilityCooldown != 0 { return false }
        creature.useActiveAbility(battle: battle)
        _activeAbilityCooldown = creature.activeAbilityCooldown
        return true
    }
    
    /*
    override func battlecry(battle: Battle) {
        creature.battlecry(battle: battle, creature: self)
    }
    
    override func deathrattle(battle: Battle) {
        creature.deathrattle(battle: battle, creature: self)
    }
    */
}
