//
//  PlayerHand.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class HandSprite: SKNode {
    //static let ANGLE: CGFloat = .pi / 45
    //var cards: [CardSprite] = []
    
    static func cardPosition(at index: Int, total: Int) -> (CGPoint, CGFloat)  {
        let center = CGFloat(total + 1) / 2
        let shift = CGFloat(index) - center
        let xPos = shift * CGFloat(CardSprite.WIDTH  + 10)
        //let yPos = -10 * abs(shift)
        let yPos: CGFloat = 0
        let position = CGPoint(x: xPos, y: yPos)
        //let rotation = -HandSprite.ANGLE * shift
        let rotation: CGFloat = 0
        return (position, rotation)
    }
}
