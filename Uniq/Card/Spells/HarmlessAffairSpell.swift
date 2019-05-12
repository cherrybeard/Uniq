//
//  HarmlessAffairSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class HarmlessAffairSpell: SpellCard {
    override init() {
        super.init()
        description = "Summon three 1/1 Fairies"
    }
    
    override func play(battle: Battle, for owner: PlayerType, target: CharacterSprite? = nil) {
        /*
        if let fairyCard = CardBook["Fairy"] as? CreatureCard {
            for _ in 1...3 {
                let fairy = CreatureSprite(creature: fairyCard, owner: owner)
                battle.summon(fairy)
            }
        }
        */
    }
}
