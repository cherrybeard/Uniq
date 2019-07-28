//
//  SKAction.swift
//  Uniq
//
//  Created by Steven Gusev on 23/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

extension SKAction {
    class func shake(amplitudeX: Int = 3, amplitudeY: Int = 3, duration: TimeInterval) -> SKAction {
        let numberOfShakes = duration / 0.015 / 2.0
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let dx = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let dy = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            let forward = SKAction.moveBy(x: dx, y:dy, duration: 0.015)
            let reverse = forward.reversed()
            actionsArray.append(forward)
            actionsArray.append(reverse)
        }
        return SKAction.sequence(actionsArray)
    }
}
