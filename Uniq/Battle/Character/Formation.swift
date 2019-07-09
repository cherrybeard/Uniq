//
//  Formation.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class Formation: SKNode {   // TODO: FormationSprite?
    static let margin = 25
    static let marginFromCenter = 60
    var characters: [CharacterSprite] = []
    
    static func getPosition(of index: Int, total: Int) -> CGPoint {
        let width = total * CharacterSprite.width + (total - 1) * margin
        let left = index * (CharacterSprite.width + margin)
        let xPos = left + CharacterSprite.width / 2 - width / 2
        return CGPoint(x: xPos, y: 0)
    }
}
