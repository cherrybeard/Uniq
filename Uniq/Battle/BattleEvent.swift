//
//  BattleEvent.swift
//  Uniq
//
//  Created by Steven Gusev on 14/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BattleEvent {
    typealias BattleEventHandler = (Battle, Spot) -> ()
    private var handlers = [BattleEventHandler]()
    
    func addHandler(_ handler: @escaping BattleEventHandler) {
        handlers.append(handler)
    }
    
    func raise(battle: Battle, spot: Spot) {
        for handler in handlers {
            handler(battle, spot)
        }
    }
}
