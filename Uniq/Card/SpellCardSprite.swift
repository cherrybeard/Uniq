//
//  SpellCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellCardSprite: CardSprite {
    var spellCard: SpellCard
    var descriptionLabel = SKLabelNode(text: "Boom!")
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(card: SpellCard) {
        spellCard = card
        super.init(card: card)
        
        descriptionLabel.text = spellCard.spell.description
        descriptionLabel.fontColor = SKColor.white
        descriptionLabel.fontName = "AvenirNext-Bold"
        descriptionLabel.fontSize = 8
        descriptionLabel.preferredMaxLayoutWidth = 48
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.position = CGPoint(x: 0, y: -40)
        addChild(descriptionLabel)
        
        name = "player-spell-card"
    }
}
