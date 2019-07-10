//
//  AbilitiesList.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AbilitiesList: ActionsPanel {
    private static let margin = 40
    var buttons: [AbilityButton] = []
    
    init(_ abilities: [ActiveAbility]) {
        super.init()
        let total = abilities.count
        for (index, ability) in abilities.enumerated() {
            let button = AbilityButton(ability)
            buttons.append(button)
            button.position = AbilitiesList.getPosition(at: index, total: total)
            addChild(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getPosition(at index: Int, total: Int) -> CGPoint {
        let size = Int(AbilityButton.size)
        let width = total * size + (total - 1) * margin
        let left = index * (size + margin)
        let xPos = left + size / 2 - width / 2
        return CGPoint(x: xPos, y: 0)
    }
}
