//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: CharacterSprite, Targetable, Tappable {
    private let WIDTH: Int = 90
    private let HEIGHT: Int = 60
    private struct BORDER_COLOR {
        static let base: UIColor = UIColor(rgb: 0x484644, alpha: 1)
        static let tapped: UIColor = UIColor(rgb: 0x614F3F, alpha: 1)
    }
    private let FILL_COLOR: UIColor = UIColor(rgb: 0x111111, alpha: 1)
    
    var creature: CreatureCard
    private let attackLabel: StatLabel
    private let border: SKShapeNode
    
    var isPossibleTarget: Bool = false
    var isCurrentTarget: Bool = false
    
    private var _isCurrentlyTapped: Bool = false
    var isCurrentlyTapped: Bool {
        get { return _isCurrentlyTapped }
        set(newValue) {
            _isCurrentlyTapped = newValue
            _redraw()
        }
    }
    
    init(creature: CreatureCard, owner: OwnerType) {
        self.creature = creature
        
        attackLabel = StatLabel(type: .attack, value: creature.attack)
        border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        
        super.init(owner: owner)
        self.creature.summon = self
        
        _maxHealth = _health
        _health = creature.health
        _attack = creature.attack
        
        healthLabel.value = _health
        attackLabel.value = _attack
        
        attackLabel.position = CGPoint(x: -WIDTH/2 + 6, y: -HEIGHT/2 + 6)
        healthLabel.position = CGPoint(x: WIDTH/2 - 6, y: -HEIGHT/2 + 6)
        healthLabel.zPosition = 1
        
        border.lineWidth = 1
        border.fillColor = FILL_COLOR
        _redraw()
        addChild(border)
        addChild(attackLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func redrawBorder() {  // OBSOLETE
        /*
        if isTarget {
            border.strokeColor = UIColor(hue: 33.0/360.0, saturation: 70.0/100.0, brightness: 81.0/100.0, alpha: 1)
        } else if canAttack && (owner == OwnerType.player) {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 80.0/100.0, alpha: 1)
        } else {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
        }
        */
    }
    
    private func _redraw() {
        if _isCurrentlyTapped {
            border.strokeColor = BORDER_COLOR.tapped
        } else {
            border.strokeColor = BORDER_COLOR.base
        }
    }
    
    func increaseAttack(by amount: Int) {
        _attack += amount
        attackLabel.value = _attack
        attackLabel.state = .buffed
    }
    
    override func battlecry(battle: Battle) {
        creature.battlecry(battle: battle, creature: self)
    }
    
    override func deathrattle(battle: Battle) {
        creature.deathrattle(battle: battle, creature: self)
    }
}
