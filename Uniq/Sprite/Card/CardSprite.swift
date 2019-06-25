//
//  CardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 22/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CardSprite: SKNode, Interactive {
    static let WIDTH = 60
    static let HEIGHT = 90
    private static let FILL_COLOR = UIColor(rgb: 0x111111)
    private struct BORDER_COLOR {
        static let base: UIColor = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0x775534)
        static let interacted = UIColor(rgb: 0xAC7D4E)
    }
    
    weak var card: Card? = nil { didSet { updateCardData() } }
    var status: Set<InteractiveStatus> = []  { didSet { redraw() } }
    var targetsFilter: (Interactive) -> Bool = { _ in return false }
    var isDiscarded: Bool = false
    
    private let label = SKLabelNode(text: "")
    private let border = SKShapeNode(
        rectOf: CGSize( width: CardSprite.WIDTH, height: CardSprite.HEIGHT ),
        cornerRadius: 3
    )
    
    override init() {
        super.init()
        
        border.lineWidth = 1
        border.fillColor = CardSprite.FILL_COLOR
        addChild(border)
        
        label.fontColor = SKColor.white
        label.fontName = "AvenirNext-DemiBold"
        label.fontSize = 8
        label.preferredMaxLayoutWidth = 48
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.position = CGPoint(x: 0, y: -40)
        addChild(label)
        
        redraw()
        
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCardData() {
        if card != nil {
            label.text = card!.description
            targetsFilter = { (interactive: Interactive) -> Bool in
                if let spot = interactive as? Spot {
                    return self.card!.spotsFilter(spot)
                }
                return false
            }
        }
    }
    
    func redraw() {
        if status.contains(.interacted) {
            border.strokeColor = BORDER_COLOR.interacted
        } else if status.contains(.interactive) {
            border.strokeColor = BORDER_COLOR.interactive
        } else {
            border.strokeColor = BORDER_COLOR.base
        }
    }
    
}
