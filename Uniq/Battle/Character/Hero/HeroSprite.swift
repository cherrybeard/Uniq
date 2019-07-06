//
//  HeroSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class HeroSprite: SKNode, CharacterSprite {
    static let width: Int = 54
    static let height: Int = 54
    private static let strokeColor = UIColor(rgb: 0x32302F)
    private static let fillColor: UIColor = UIColor(rgb: 0x111111)
    
    private let border = SKShapeNode(
        rectOf: CGSize(width: HeroSprite.width, height: HeroSprite.height),
        cornerRadius: 3
    )
    
    let healthLabel = StatLabel(type: .health)
    
    init(health: Value) {
        super.init()
        
        border.lineWidth = 1
        border.fillColor = HeroSprite.fillColor
        border.strokeColor = HeroSprite.strokeColor
        addChild(border)
        
        let xPos = HeroSprite.width/2 - 6
        let yPos = HeroSprite.height/2 - 10
        healthLabel.changeValue(to: health)
        healthLabel.position = CGPoint(x: +xPos, y: -yPos)
        addChild(healthLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
