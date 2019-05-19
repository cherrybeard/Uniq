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
    
    private let _healthLabel = HealthLabel()
    private let _attackLabel = AttackLabel()
    private let _abilityLabel = AbilityLabel()
    private let _border: SKShapeNode
    
    var creature: CreatureCard
    weak var spot: CreatureSpotSprite? = nil
    
    var health: Int { return _healthLabel.health }
    var attack: Int { return _attackLabel.attack }
    var activeAbilityCooldown: Int { return _abilityLabel.remaining }
    var owner: Player? { return spot?.owner }

    var isActionTaken: Bool = false { didSet {
        if isActionTaken {
            _attackLabel.disable()
        } else {
            _attackLabel.enable()
        }
    } }
    var isPossibleTarget: Bool = false
    var isCurrentlyTapped: Bool = false
    var isCurrentTarget: Bool = false { didSet { _redraw() } }
    
    init(of creature: CreatureCard, spot: CreatureSpotSprite) {
        self.creature = creature
        self.spot = spot
        _border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        super.init()
        
        _border.lineWidth = 1
        _border.fillColor = FILL_COLOR
        addChild(_border)
        
        _abilityLabel.cooldown = (creature.activeAbility == nil) ? -1 : creature.activeAbility!.cooldown
        _abilityLabel.resetCooldown()
        _abilityLabel.position = CGPoint(x: 0, y: HEIGHT/2)
        addChild(_abilityLabel)
        
        _attackLabel.attack = creature.attack
        _attackLabel.position = CGPoint(x: -WIDTH/2 + 6, y: -HEIGHT/2 + 10)
        addChild(_attackLabel)
        
        _healthLabel.health = creature.health
        _healthLabel.position = CGPoint(x: WIDTH/2 - 6, y: -HEIGHT/2 + 10)
        addChild(_healthLabel)
        
        _redraw()
        name = "creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        _border.strokeColor = isCurrentTarget ? BORDER_COLOR.currentTarget : BORDER_COLOR.base
    }
    
    func increaseAttack(by amount: Int) {
        _attackLabel.increaseAttack(by: amount)
    }
    
    func decreaseAbilityCooldown() {
        _abilityLabel.decreaseCooldown()
    }
    
    func useActiveAbility(battle: Battle) -> Bool {
        if (_abilityLabel.remaining == 0) && !isActionTaken {
            if creature.activeAbility!.ability(battle, self) {
                _abilityLabel.resetCooldown()
                isActionTaken = true
                return true
            }
        }
        return false
    }
}
