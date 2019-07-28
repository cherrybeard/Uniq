//
//  FormationSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 11/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class FormationSprite: SKNode {
    static let margin = 25
    static let marginFromCenter = 60
    
    var characters: [CharacterSprite] = []
    
    func getXPosition(of index: Int, removedIndex: Int = -1) -> CGFloat {
        var total = characters.count
        var targetIndex = index
        if removedIndex != -1 {
            total -= 1
            if targetIndex > removedIndex {
                targetIndex -= 1
            }
        }
        let characterWidth = CharacterSprite.width
        let width = total * characterWidth + (total - 1) * FormationSprite.margin
        let left = targetIndex * (characterWidth + FormationSprite.margin)
        return CGFloat(left + characterWidth / 2 - width / 2)
    }
    
    func add(_ character: CharacterSprite, at index: Int) {
        let xPos = getXPosition(of: index)
        character.alpha = 0
        character.setScale(1.2)
        character.position = CGPoint(x: xPos, y: 0)
        characters.insert(character, at: index)
        addChild(character)
    }
    
    func remove(at index: Int) {
        let character = characters.remove(at: index)
        character.removeFromParent()
    }
    
}
