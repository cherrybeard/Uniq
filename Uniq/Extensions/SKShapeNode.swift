//
//  SKShapeNode.swift
//  Uniq
//
//  Created by Steven Gusev on 25/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    
    convenience init(hexagonOfRadius radius: CGFloat) {
        func hexagonVertex(radius: CGFloat, at angle: CGFloat) -> CGPoint {
            let x = radius * sin(angle)
            let y = radius * cos(angle)
            return CGPoint(x: x, y: y)
        }
        
        let path = CGMutablePath()
        let angleShift: CGFloat = 2.0 * .pi / 6
        path.move(to: hexagonVertex(radius: radius, at: 0))
        for i in 1...6 {
            let vertex = hexagonVertex( radius: radius, at: angleShift * CGFloat(i) )
            path.addLine(to: vertex)
        }
        self.init(path: path)
    }
}
