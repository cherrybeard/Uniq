//
//  AbilityDescription.swift
//  Uniq
//
//  Created by Steven Gusev on 27/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AbilityDescription: SKNode {  // TODO: Rename to AbilityLabel?
    private let nameLabel = SKLabelNode()
    private let descriptionLabel = SKLabelNode()
    
    override init() {
        super.init()
        
        nameLabel.fontName = "Copperplate"
        nameLabel.fontSize = 16
        nameLabel.fontColor = UIColor(rgb: 0xE4D4C5)
        nameLabel.horizontalAlignmentMode = .center
        nameLabel.verticalAlignmentMode = .baseline
        addChild(nameLabel)
        
        descriptionLabel.fontName = "Futura-Medium"
        descriptionLabel.fontSize = 12
        descriptionLabel.fontColor = UIColor(rgb: 0xC69F78)
        descriptionLabel.horizontalAlignmentMode = .center
        descriptionLabel.verticalAlignmentMode = .top
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.preferredMaxLayoutWidth = 250
        descriptionLabel.position = CGPoint(x: 0, y: -10)
        addChild(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, description: String, cooldown: Int) {
        nameLabel.text = "\(name.uppercased()) (\(cooldown))"
        descriptionLabel.text = description
    }
    
    func set(to ability: ActiveAbility) {
        set(name: ability.effect.name, description: ability.description, cooldown: ability.effect.cooldown)
    }
}
