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
    
    private let _healthLabel = StatLabel(type: .health)
    private let _attackLabel = StatLabel(type: .attack)
    private let _abilityLabel = AbilityLabel()
    private let _border: SKShapeNode
    
    var creature: CreatureCard
    weak var spot: CreatureSpotSprite? = nil
    
    var health: Int { get { return _healthLabel.value } }
    var attack: Int { get { return _attackLabel.value } }
    var activeAbilityCooldown: Int { return _abilityLabel.remaining }
    var owner: Player? { get { return spot?.owner } }
    
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
        
        _attackLabel.value = creature.attack
        _attackLabel.position = CGPoint(x: -WIDTH/2 + 6, y: -HEIGHT/2 + 6)
        addChild(_attackLabel)
        
        _healthLabel.value = creature.health
        _healthLabel.position = CGPoint(x: WIDTH/2 - 6, y: -HEIGHT/2 + 6)
        _healthLabel.zPosition = 1
        addChild(_healthLabel)
        
        _redraw()
        name = "creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        if _isCurrentTarget {
            _border.strokeColor = BORDER_COLOR.currentTarget
        } else {
            _border.strokeColor = BORDER_COLOR.base
        }
    }
    
    func increaseAttack(by amount: Int) {
        _attackLabel.value += amount
        _attackLabel.state = .buffed    // TODO: Move to the StatLabel class
    }
    
    func decreaseAbilityCooldown() {
        _abilityLabel.decreaseCooldown()
    }
    
    func useActiveAbility(battle: Battle) -> Bool {
        if (creature.activeAbility != nil) && (_abilityLabel.remaining == 0) {
            if creature.activeAbility!.ability(battle, self) {
                _abilityLabel.resetCooldown()
                return true
            }
        }
        return false
    }
}
