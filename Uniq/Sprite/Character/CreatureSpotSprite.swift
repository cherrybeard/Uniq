//
//  CreatureSpot.swift
//  Uniq
//
//  Created by Steven Gusev on 03/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

enum RangeType: Int {
    case melee = 0, range = 1
}

enum ColumnType: Int {
    case left = -1, center = 0, right = 1
}

class CreatureSpotSprite: SKNode, Targetable {
    private let WIDTH: Int = 86
    private let HEIGHT: Int = 56
    private struct BORDER_COLOR {
        static let base: UIColor = UIColor(rgb: 0x1D1D1C, alpha: 1)
        static let possibleTarget: UIColor = UIColor(rgb: 0x2E2924, alpha: 1)
        static let currentTarget: UIColor = UIColor(rgb: 0x614F3F, alpha: 1)
    }
    
    weak var owner: Player?
    let range: RangeType
    let column: ColumnType
    var isTaken: Bool = false
    
    private var _isPossibleTarget: Bool = false
    var isPossibleTarget: Bool {
        get { return _isPossibleTarget }
        set(newValue) {
            _isPossibleTarget = newValue
            _redraw()
        }
    }
    
    private var _isCurrentTarget: Bool = false
    var isCurrentTarget: Bool {
        get { return _isCurrentTarget }
        set(newValue) {
            _isCurrentTarget = newValue
            _redraw()
        }
    }
    
    private let border: SKShapeNode

    var index: Int {
        get {
            var shift: Int = column.rawValue + 2
            if owner?.type == .human {
                shift += 6 + range.rawValue * 3
            } else {
                shift += (range.rawValue-1) * -3
            }
            return shift
        }
    }
    
    init(for player: Player, range: RangeType, column: ColumnType) {
        self.owner = player
        self.range = range
        self.column = column
        border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT))
        super.init()
        _afterInit()
    }
    
    init(at index: Int, battle: Battle) {
        let ownerType = CreatureSpotSprite._getOwner(of: index)
        if ownerType == .human  {
            owner = battle.human
        } else {
            owner = battle.ai
        }
        range = CreatureSpotSprite._getRange(of: index)
        column = CreatureSpotSprite._getColumn(of: index)
        border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        super.init()
        _afterInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _afterInit() {
        border.lineWidth = 1
        _redraw()
        addChild(border)
        name = "spot"
    }
    
    private func _redraw() {
        if _isCurrentTarget {
            border.strokeColor = BORDER_COLOR.currentTarget
        } else if _isPossibleTarget {
            border.strokeColor = BORDER_COLOR.possibleTarget
        } else {
            border.strokeColor = BORDER_COLOR.base
        }
    }
    
    static func checkIndex(_ index: Int) -> Int {
        if (index < 1) || (index > 12) {
            assertionFailure("Trying to set CreatureSpot.index out of range")
            return abs(index % 12)
        } else {
            return index
        }
    }
    
    static private func _getColumn(of index: Int) -> ColumnType {
        let column = (checkIndex(index)-1) % 3 - 1
        return ColumnType(rawValue: column) ?? .center
    }
    
    static private func _getOwner(of index: Int) -> PlayerType {
        return checkIndex(index) > 6 ? .human : .ai
    }
    
    static private func _getRange(of index: Int) -> RangeType {
        let checkedIndex = checkIndex(index)
        if (checkedIndex > 3) && (checkedIndex < 10) {
            return .melee
        } else {
            return .range
        }
    }
    
}
