//
//  ActiveAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ActiveAbility {
    
    struct Cooldown {
        var left: Int
        var total: Int
        let isImmediatelyReady: Bool
        
        init(_ cooldown: Int, immediatelyReady: Bool = true) {
            isImmediatelyReady = immediatelyReady
            left = immediatelyReady ? 0 : cooldown
            total = cooldown
        }
        
        mutating func reset() {
            left = total
        }
        
        mutating func decrease() {
            if left > 0 { left -= 1 }
        }
        
        func copy() -> Cooldown {
            return Cooldown(total, immediatelyReady: isImmediatelyReady)
        }
    }
    
    let name: String
    let description: String
    var cooldown: Cooldown
    let effect: (Battle, Character?) -> ()
    let targetFilter: CharacterFilter
    let requiresTarget: Bool
    var isDisabled: Bool = false
    weak var button: AbilityButton? = nil
    var isReady: Bool {
        return (cooldown.left == 0) && !isDisabled
    }
    
    init(
        name: String = "",
        description: String = "",
        cooldown: Cooldown,
        effect: @escaping (Battle, Character?) -> (),
        requiresTarget: Bool = true,
        targetFilter: @escaping CharacterFilter = CharacterFilters.none
    ) {
        self.name = name
        self.description = description
        self.cooldown = cooldown
        self.effect = effect
        self.requiresTarget = requiresTarget
        self.targetFilter = targetFilter
    }
    
    func copy() -> ActiveAbility {
        let ability = ActiveAbility(
           description: description,
           cooldown: cooldown.copy(),
           effect: effect,
           requiresTarget: requiresTarget,
           targetFilter: targetFilter
        )
        return ability
    }
}
