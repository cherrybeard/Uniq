//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class Creature: SKNode {
    private static let WIDTH: Int = 90
    private static let HEIGHT: Int = 60
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0x775534)
        static let interacted = UIColor(rgb: 0xAC7D4E)
        static let targetable = UIColor(rgb: 0x3752A1)
        static let targetted = UIColor(rgb: 0x1A54FB)
    }
    private let FILL_COLOR: UIColor = UIColor(rgb: 0x111111)
    
    private let _healthLabel: HealthLabel
    private let _attackLabel = AttackLabel()
    private let _abilityLabel = AbilityLabel()
    private let _border = SKShapeNode(rectOf: CGSize(width: Creature.WIDTH, height: Creature.HEIGHT), cornerRadius: 3)
    
    var card: CreatureCardBlueprint
    var spot: Spot
    
    var health: Int { return _healthLabel.health }
    var attack: Int { return _attackLabel.attack }
    var activeAbilityCooldown: Int { return _abilityLabel.remaining }

    var isActionTaken: Bool = false { didSet {  // TODO: Move to Spot
        if isActionTaken {
            _abilityLabel.disable()
            _attackLabel.disable()
        } else {
            _abilityLabel.enable()
            _attackLabel.enable()
        }
    } }
    
    var status: Set<InteractiveStatus> = [] { didSet { _redraw() } }
    
    var isPossibleTarget: Bool = false { didSet { _redraw() } }
    var isCurrentlyTapped: Bool = false { didSet { _redraw() } }
    var isPosssibleToTap: Bool = false { didSet { _redraw() } }
    var isCurrentTarget: Bool = false { didSet { _redraw() } }
    var isCurrentlyHold: Bool = false
    
    init(of card: CreatureCardBlueprint, spot: Spot) {
        self.card = card
        self.spot = spot
        _healthLabel = HealthLabel(maxHealth: card.health)
        super.init()
        
        _border.lineWidth = 1
        _border.fillColor = FILL_COLOR
        addChild(_border)
        
        _abilityLabel.cooldown = (card.activeAbility == nil) ? -1 : card.activeAbility!.cooldown
        _abilityLabel.resetCooldown()
        _abilityLabel.position = CGPoint(x: 0, y: Creature.HEIGHT/2)
        addChild(_abilityLabel)
        
        _attackLabel.attack = card.attack
        _attackLabel.position = CGPoint(x: -Creature.WIDTH/2 + 6, y: -Creature.HEIGHT/2 + 10)
        addChild(_attackLabel)
        
        _healthLabel.health = card.health
        _healthLabel.position = CGPoint(x: Creature.WIDTH/2 - 6, y: -Creature.HEIGHT/2 + 10)
        addChild(_healthLabel)
        
        _redraw()
        name = "creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        if status.contains(.targetted) {
            _border.strokeColor = BORDER_COLOR.targetted
        } else if status.contains(.targetable) {
            _border.strokeColor = BORDER_COLOR.targetable
        } else if status.contains(.interacted) {
            _border.strokeColor = BORDER_COLOR.interacted
        } else if status.contains(.interactive) {
            _border.strokeColor = BORDER_COLOR.interactive
        } else {
            _border.strokeColor = BORDER_COLOR.base
        }
    }
    
    func increaseAttack(by amount: Int) {
        _attackLabel.increaseAttack(by: amount)
    }
    
    func dealDamage(_ amount: Int) {
        _healthLabel.health -= amount
    }
    
    func decreaseAbilityCooldown() {
        _abilityLabel.decreaseCooldown()
    }
    
    func useActiveAbility(battle: Battle) -> Bool {
        if (_abilityLabel.remaining == 0) && !isActionTaken {
            if card.activeAbility!.ability(battle, spot) {
                _abilityLabel.resetCooldown()
                isActionTaken = true
                return true
            }
        }
        return false
    }
}
