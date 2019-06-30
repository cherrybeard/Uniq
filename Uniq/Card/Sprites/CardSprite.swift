//
//  CardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 22/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CardSprite: SKNode, Interactive {
    static let width = 60
    static let height = 90
    private static let fillColor = UIColor(rgb: 0x111111)
    private static let strokeColor: [InteractiveStatus: UIColor] = [
        .base: UIColor(rgb: 0x484644),
        .interactive: UIColor(rgb: 0x775534),
        .interacted: UIColor(rgb: 0xAC7D4E)
    ]
    private static var textStyle: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineBreakMode = .byWordWrapping
        return style
    }
    private static let textAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "AvenirNext-DemiBold", size: 8)!,
        .foregroundColor: UIColor(rgb: 0xffffff),
        .paragraphStyle: CardSprite.textStyle
    ]
    
    weak var card: Card? = nil { didSet { updateCardData() } }
    var status: Set<InteractiveStatus> = []  { didSet { redraw() } }
    var targetsFilter: (Interactive) -> Bool = { _ in return false }
    var isDiscarded: Bool = false
    
    private let label = SKLabelNode(text: "")
    private let border = SKShapeNode(
        rectOf: CGSize( width: CardSprite.width, height: CardSprite.height ),
        cornerRadius: 3
    )
    
    override init() {
        super.init()
        
        border.lineWidth = 1
        border.fillColor = CardSprite.fillColor
        addChild(border)
        
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.preferredMaxLayoutWidth = 44
        label.numberOfLines = 0
        label.position = CGPoint(x: 0, y: 0)
        addChild(label)
        
        redraw()
        
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCardData() {
        if card != nil {
            label.attributedText = NSAttributedString(
                string: card!.name,
                attributes: CardSprite.textAttributes
            )
            label.text = card!.name
            if card!.requiresTarget {
                targetsFilter = {
                    if let spot = $0 as? Spot {
                        return self.card!.spotsFilter(spot)
                    }
                    return false
                }
            } else {
                targetsFilter = { $0 is Spots }
            }
        }
    }
    
    func redraw() {
        for s: InteractiveStatus in [.interacted, .interactive, .base] {
            if status.contains(s) || (s == .base) {
                border.strokeColor = CardSprite.strokeColor[s]!
                break
            }
        }
    }
    
}
