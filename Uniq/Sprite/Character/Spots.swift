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
    private static let START_INDEX: Int = 0
    private static let END_INDEX: Int = 12
    
    private var spots: [Spot] = []
    var startIndex: Int = START_INDEX
    var endIndex: Int = END_INDEX
    
    init(human: Player, ai: Player) {
        super.init()
        for index in startIndex ..< endIndex {
            let owner = (index > 5) ? human : ai
            let range = Spots._range(of: index)
            let column = Spots._column(of: index)
            let spot = Spot(owner: owner, range: range, column: column)
            spots.append(spot)
            let yPos = owner.type.rawValue * (Spots.DISTANCE_FROM_CENTER + spot.range.rawValue * Spots.SPACE_BETWEEN_ROWS)
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
        return spots[position]
    }
    
    static private func _column(of index: Int) -> ColumnType {
        let column = index % 3 - 1
        return ColumnType(rawValue: column) ?? .center
    }
    
    static private func _owner(of index: Int) -> PlayerType {
        return index > 5 ? .human : .ai
    }
    
    static private func _range(of index: Int) -> RangeType {
        if (index > 2) && (index < 9) {
            return .melee
        } else {
            return .range
        }
    }
    
    /// Returns indices all neighbors of the spot.
    ///
    /// - Parameters:
    ///   - index: Index of the original spot.
    ///   - sameOwner: false if allowed to include enemy spots in result.
    /// - Returns: Array of indices of all neighbors of the original spot.
    static func neighbors(of index: Int, sameOwner: Bool = true) -> [Int] {
        var neighbors: [Int] = []
        var modifiers = [-3, 3]
        if index % 3 != 2 { modifiers.append(1) }
        if index % 3 != 0 { modifiers.append(-1) }
        for modifier in modifiers {
            let newIndex = index + modifier
            if (newIndex < START_INDEX) || (newIndex >= END_INDEX) { continue }
            if !sameOwner || (Spots._owner(of: index) == Spots._owner(of: newIndex)) {
                neighbors.append(newIndex)
            }
        }
        return neighbors
    }
    
    func neighbors(of spot: Spot, sameOwner: Bool = true) -> [Spot] {
        var neighbors: [Spot] = []
        for index in Spots.neighbors(of: spot.index, sameOwner: sameOwner) {
            neighbors.append(spots[index])
        }
        return neighbors
    }
    
    func nextAttacker(activePlayer: PlayerType) -> Spot? {
        let aiOrder = [3, 0, 4, 1, 5, 2]
        let humanOrder = [6, 9, 7, 10, 8, 11]
        let attackOrder: [Int] = (activePlayer == .human) ? aiOrder + humanOrder : humanOrder + aiOrder
        for index in attackOrder {
            let attackerSpot = spots[index]
            if let attacker = attackerSpot.creature {
                if !attacker.isActionTaken && (attacker.attack > 0) && (attacker.health > 0) {
                    return attackerSpot
                }
            }
        }
        return nil
    }
    
    func target(for spot: Spot) -> Spot? {
        let sign = spot.owner.isAi ? 1 : -1
        let attackerIndex = spot.index
        for i in [3, 6, 9] {
            let targetIndex = attackerIndex + i * sign
            if (targetIndex < 0) || (targetIndex > 11) { continue }
            let targetSpot = spots[targetIndex]
            if let target = targetSpot.creature {
                if (targetSpot.owner != spot.owner) && (target.health > 0) {
                    return targetSpot
                }
            }
        }
        return nil
    }
}
