//
//  Formation.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Formation: Collection {
    
    var startIndex = 0
    var endIndex: Int { return characters.endIndex }
    
    var characters: [Character] = []
    
    // Sptites
    var sprite = FormationSprite()
    
    func add(_ character: Character) -> Bool {
        let newIndex = generateIndex()
        if newIndex == -1 { return false }
        characters.insert(character, at: newIndex)
        for (index, character) in characters.enumerated() {
            character.formationIndex = index
        }
        return true
    }
    
    
    func generateIndex() -> Int {
        var newIndex = characters.endIndex
        if newIndex > 2 { return -1 }
        if (newIndex > 0) && characters[0] is Hero {
            newIndex = 0
        }
        return newIndex
    }
    
    subscript(position: Int) -> Character? {
        if position >= characters.count { return nil }
        return characters[position]
    }
    
    func index(after i: Int) -> Int {
        return (i + 1)
    }
    
}
