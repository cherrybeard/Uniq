//
//  Spots.swift
//  Uniq
//
//  Created by Steven Gusev on 28/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class Spots: SKNode, Collection {
    private static let SPACE_BETWEEN_COLUMNS: Int = 113
    private static let SPACE_BETWEEN_ROWS: Int = 90
    private static let DISTANCE_FROM_CENTER: Int = 78
    
    private var _spots: [Spot] = []
    var startIndex: Int = 0
    var endIndex: Int = 12
    
    override init() {
        super.init()
        for index in startIndex ..< endIndex {
            let spot = Spot(at: index)
            _spots.append(spot)
            let yPos = spot.owner.rawValue * (Spots.DISTANCE_FROM_CENTER + spot.range.rawValue * Spots.SPACE_BETWEEN_ROWS)
            let xPos = spot.column.rawValue * Spots.SPACE_BETWEEN_COLUMNS
            spot.position = CGPoint(x: xPos, y: yPos)
            addChild(spot)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func index(after i: Int) -> Int {
        return (i + 1)
    }
    
    subscript(position: Int) -> Spot {
        return _spots[position]
    }
    
    func neighbors(of spot: Spot, sameOwner: Bool = true) -> [Spot] {
        var neighbors: [Spot] = []
        let index = spot.index
        var modifiers = [-3, 3]
        if index % 3 != 2 { modifiers.append(1) }
        if index % 3 != 0 { modifiers.append(-1) }
        for modifier in modifiers {
            let newIndex = index + modifier
            if (newIndex < startIndex) || (newIndex >= endIndex) { continue }
            let neighbor = _spots[newIndex]
            if !sameOwner || (neighbor.owner == spot.owner) {
                neighbors.append(neighbor)
            }
        }
        return neighbors
    }
    
    func nextAttacker(activePlayer: PlayerType) -> Spot? {
        let aiOrder = [3, 0, 4, 1, 5, 2]
        let humanOrder = [6, 9, 7, 10, 8, 11]
        let attackOrder: [Int] = (activePlayer == .human) ? aiOrder + humanOrder : humanOrder + aiOrder
        for index in attackOrder {
            let attackerSpot = _spots[index]
            if let attacker = attackerSpot.creature {
                if !attacker.isActionTaken && (attacker.attack > 0) {
                    return attackerSpot
                }
            }
        }
        return nil
    }
    
    func target(for spot: Spot) -> Spot? {
        let sign = (spot.owner == .ai) ? 1 : -1
        let attackerIndex = spot.index
        for i in [3, 6, 9] {
            let targetIndex = attackerIndex + i * sign
            if (targetIndex < 0) || (targetIndex > 11) { continue }
            let targetSpot = _spots[targetIndex]
            if let target = targetSpot.creature {
                if (targetSpot.owner != spot.owner) && (target.health > 0) {
                    return targetSpot
                }
            }
        }
        return nil
    }
}
