//
//  Spots.swift
//  Uniq
//
//  Created by Steven Gusev on 28/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit
import GameplayKit

class Spots: SKNode, Collection {
    private static let hrzMargin: Int = 113
    private static let vrtMargin: Int = 90
    private static let marginFromCenter: Int = 78
    private static let start: Int = 0
    private static let end: Int = 12
    
    private var spots: [Spot] = []
    var startIndex: Int = start
    var endIndex: Int = end
    
    init(human: Player, ai: Player) {
        super.init()
        for index in startIndex ..< endIndex {
            let owner = (index > 5) ? human : ai
            let range = Spots.range(of: index)
            let column = Spots.column(of: index)
            let spot = Spot(owner: owner, range: range, column: column)
            spots.append(spot)
            let yPos = owner.type.rawValue * (Spots.marginFromCenter + spot.range.rawValue * Spots.vrtMargin)
            let xPos = spot.column.rawValue * Spots.hrzMargin
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
    
    static private func column(of index: Int) -> ColumnType {
        let column = index % 3 - 1
        return ColumnType(rawValue: column) ?? .center
    }
    
    static private func owner(of index: Int) -> PlayerType {
        return index > 5 ? .human : .ai
    }
    
    static private func range(of index: Int) -> RangeType {
        if (index > 2) && (index < 9) {
            return .melee
        } else {
            return .range
        }
    }
    
    func shuffledSpots(in filter: SpotsFilter) -> [Spot] {
        let filtered = spots.filter(filter)
        let shuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: filtered)
        return shuffled.map { $0 as! Spot }
    }
    
    func randomSpot(in filter: SpotsFilter = SpotsFilters.all ) -> Spot? {
        let spotsShuffled = shuffledSpots(in: filter)
        if spotsShuffled.count > 0 {
            return spotsShuffled[0]
        }
        return nil
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
            if (newIndex < start) || (newIndex >= end) { continue }
            if !sameOwner || (Spots.owner(of: index) == Spots.owner(of: newIndex)) {
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