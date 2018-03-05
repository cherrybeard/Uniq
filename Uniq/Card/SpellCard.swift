//
//  SpellCard.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias CreatureSpriteFilter = (CreatureSprite) -> Bool

enum SpellTargetType: String {
    case all = "All"
    case allEnemyCreatures = "All enemy creatures"
    case creature = "Creature"
    case enemyCreature = "Enemy creature"
    case ownerCreature = "Owner creature"
}

class SpellCard: Card {
    var target: SpellTargetType
    var description: String
    var effect: ([CreatureSprite]) -> Void
    var targetFilter: CreatureSpriteFilter
    
    init(cost: Int, target: SpellTargetType, description: String, effect: @escaping ([CreatureSprite]) -> Void, targetFilter: @escaping CreatureSpriteFilter) {
        self.target = target
        self.description = description
        self.effect = effect
        self.targetFilter = targetFilter
        
        super.init(cost: cost)
    }
    
    init(_ card: SpellCard) {
        target = card.target
        description = card.description
        effect = card.effect
        targetFilter = card.targetFilter
        
        super.init(cost: card.cost)
    }
    
    override func copy() -> SpellCard {
        return SpellCard(self)
    }
}
