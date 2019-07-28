//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class Battle {
    let passButton = PassButton()
    //var interactives = Interactives()
    private let animationPipeline = AnimationPipeline()
    
    let human = Player(as: .human)  // TODO: can we make it static?
    let ai = Player(as: .ai)
    var activePlayer: Player {  // TODO: return nil if preparing ?
        willSet {
            human.isActive = false
            ai.isActive = false
            newValue.isActive = true
        }
    }
    var round: Int = 1
    
    var isUnlocked: Bool = false
    var sprite = BattleSprite()
    
    var characters: [Character] {
        return human.characters + ai.characters
    }
    var charactersAlive: [Character] {
        return characters.filter { !$0.isDead }
    }
    
    init() {
        activePlayer = ai
        for player in [human, ai] {
            sprite.addFormation(player.formation.sprite, for: player)
        }
        
        _ = place( Hero(), for: human )
        let fairy = Creature( of: FairyCreature() )
        let lightbringer = Creature( of: LightbringerCreature() )
        _ = place(fairy, for: human )
        _ = place(lightbringer, for: human )
        
        for _ in 0..<3 {
            _ = place(
                Creature( of: FairyCreature() ), for: ai
            )
        }
        /*
        for creature in generateRandomComposition() {
            if let spot = spots.randomSpot(in: SpotsFilters.aiFree) {
                _ = place(creature, to: spot)
            }
        }*/
        /*
        if let spot = spots.randomSpot(in: SpotsFilters.humanFree) {
            summon("Yletia Pirate", to: spot.index)
        }*/
        /*
        for _ in 1...3 {
            _ = draw(for: human)
        }*/
        //_ = addToHand(for: human, cardName: "Old Prophet")
        
        aiTurn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let state = animationPipeline.update()
        isUnlocked = (state == .finished) || (state == .idle)
    }
    
    func humanTurn() {
        activePlayer = human
        animationPipeline.add(
            AnnouncerAnimation(battle: sprite, message: "Your turn")
        ) {
            //self.highlightActionTargets()
        }
    }
    
    func actionDone() {
        animationPipeline.add() {
            //self.highlightActionTargets()
        }
    }
    
    func endTurn() {
        //interactives.clean()
        //fight()
    }
    /*
    func fight() {
        if let attackerSpot = spots.nextAttacker(activePlayer: activePlayer.type) {
            if let attacker = attackerSpot.creature {
                setExhaustion(of: attacker, to: true)
                if let targetSpot = spots.target(for: attackerSpot) {
                    if let creature = targetSpot.creature {
                        attack( attacker: attacker, target: creature )
                    }
                } else if attackerSpot.owner.isAi {
                    attack( attacker: attacker, target: human.hero )
                }
            }
            fight()
        } else {
            endRound()
        }
    }*/
    
    func endRound() {
        //for character in characters {
            //decreaseAbilityCooldown(of: creature)
            //setExhaustion(of: creature, to: false)
        //}
        /*
        for player in [human, ai] {
            _ = draw(for: player)
        }*/
        round += 1
        
        animationPipeline.add(
            AnnouncerAnimation(battle: sprite, message: "Round \(round)")
        )
        aiTurn()
    }
    
    func aiTurn() {
        activePlayer = ai
        /*
        for spot in spots.shuffledSpots(in: CreatureFilters.aiCreatures) {
            if let creature = spot.creature {
                _ = useActiveAbility(of: creature)
                /*
                // determine if creature should move
                if let target = spots.target(for: spot)?.creature {
                    let ownThreat = spots.threat(from: spot)
                    
                    if target.health.current < ownThreat {
                        let threat = spots.threat(from: spot, reverse: true)
                        let health = creature.health.current
                        let threats: [Spot.Column: Int] = []
                        
                        if threat > creature.health.current {
                            
                        }
                    }
                }*/
                // if threat on line < hunan creature hp
                // and if a line nearby has threat < this creature hp
                // move creature
            }
        }*/
        humanTurn()
    }
    
    /*
    func draw(for player: Player) -> Card? {
        if let card = player.deck.draw() {
            interactives.append(card.sprite)
            animationPipeline.add([
                RepositionHandAnimation(hand: player.deck.hand, addCard: true),
                DrawCardAnimation(hand: player.deck.hand, card: card.sprite)
            ])
            return card
        }
        return nil
    }*/
    /*
    func addToHand(for player: Player, cardName: String) -> Card? {
        if let card = player.deck.addToHand(cardName) {
            interactives.append(card.sprite)
            
            animationPipeline.add([
                RepositionHandAnimation(hand: player.deck.hand, addCard: true),
                DrawCardAnimation(hand: player.deck.hand, card: card.sprite)
            ])
            return card
        }
        return nil
    }*/
    
    func play(_ card: Card, for player: Player?, target: Character?) {
        if card.requiresTarget && (target == nil) { return }
        
        card.state = .discarded
        card.sprite.isDiscarded = true
        /*
        interactives.removeAll {
            if let sprite = $0 as? CardSprite {
                return sprite.isDiscarded
            }
            return false
        }
        
        animationPipeline.add([
            DiscardCardAnimaiton(card: card.sprite),
            RepositionHandAnimation(hand: player.deck.hand)
        ])*/
        card.play(battle: self, for: player ?? activePlayer, target: target)
    }
    /*
    func summon(_ creatureName: String, to index: Int) {
        if let card = CardLibrary.getCard(creatureName) as? CreatureCard {
            summon(card, to: spots[index])
        }
    }

    func summon(_ card: CreatureCard, to spot: Spot) { // TODO: Return Bool
        // Place creature
        let creature = place(card, to: spot)
        
        // Rush
        if card.hasRush { setExhaustion(of: creature, to: false) }
        
        // When summoned ability
        if let ability = creature.whenSummoned {
            _ = ability.effect(self, creature.spot)
        }
        
        // Procedure onSummon abilities of others
        let reactiveSpots = spots.filter {
            ($0 != spot) && !$0.isFree && ($0.creature?.onSummon != nil)
        }
        for reactiveSpot in reactiveSpots {
            if let ability = reactiveSpot.creature?.onSummon {
                ability.effect(self, reactiveSpot, spot)
            }
        }
    }*/
    
    func place(_ character: Character, for player: Player) {
        if player.place(character) {
            if player.isHuman {
                let panel = character.generatePanel()
                character.actionsPanel = panel
                self.sprite.humanActions.add(panel)
            }
            
            let sprite = character.generateSprite()
            character.sprite = sprite
            
            animationPipeline.add(
                SummonAnimation(sprite, to: player.formation.sprite, at: character.formationIndex)
            )
        }
        
    }
    
    /*
    func place(_ card: CreatureCard, to spot: Spot) -> Creature {
        let creature = Creature(of: card, at: spot)
        creatures.append(creature)
        spot.creature = creature
        
        animationPipeline.add(
            SummonAnimation(creature.sprite as! CreatureSprite, at: spot, battle: self)
        )
        return creature
    }*/
    
    func setExhaustion(of character: Character, to exhausted: Bool) {
        character.isExhausted = exhausted
        
        if let sprite = character.sprite {
            animationPipeline.add(
                SetExhaustionAnimation(character: sprite, to: exhausted)
            )
        }
    }
    
    /*
    func attack(from attackerSpot: Spot, to targetSpot: Spot) {
        if let attacker = attackerSpot.creature {
            if let target = targetSpot.creature {
                let attackerSprite = attacker.sprite
                let targetSprite = target.sprite
                
                animationPipeline.add(
                    AttackAnimation( creature: attackerSprite, target: targetSprite )
                )
                dealDamage(attacker.attack.current, to: targetSpot)
                animationPipeline.add(
                    RetreatAnimation( creature: attackerSprite, spot: attackerSpot )
                )
            }
            
        }
    }
    
    func attack(attacker: Creature, target: Character) {
        let attackerSprite = attacker.sprite
        
        animationPipeline.add(
            AttackAnimation( creature: attackerSprite, target: target.sprite )
        )
        dealDamage(attacker.attack.current, to: target)
        animationPipeline.add(
            RetreatAnimation( creature: attackerSprite, spot: attacker.spot )
        )
    }*/
    
    func dealDamage(_ amount: Int, to character: Character) {
        character.dealDamage(amount)
        if let sprite = character.sprite {
            animationPipeline.add(
                DamageAnimation( character: sprite, amount: amount )
            )
        }
        if character.isDead {
            kill(character)
        }
    }
    
    /*
    
    func dealDamage(_ amount: Int, to spot: Spot) {
        if let creature = spot.creature {
            creature.dealDamage(amount)
            animationPipeline.add(
                DamageAnimation( character: creature.sprite, amount: -amount )
            )
            if creature.isDead {
                kill(creature)
            }
        }
    }*/
    /*
    func dealDamage(_ amount: Int, to filter: SpotsFilter) {
        let targets = spots.filter(filter)
        var obituaries: [Spot] = []
        for spot in targets {
            if let creature = spot.creature {
                creature.dealDamage(amount)
                animationPipeline.add(
                    DamageAnimation( creature: creature.sprite, amount: -amount )
                )
                if creature.isDead {
                    obituaries.append(spot)
                }
            }
        }
        for spot in obituaries {
            kill(at: spot)
        }
    }*/
    
    func kill(_ character: Character) {
        if let formation = character.owner?.formation.sprite {
            animationPipeline.add(
                DeathAnimation(formation: formation, at: character.formationIndex)
            )
        }
    }
    
    func giveArmor(_ amount: Int, to character: Character) {
        guard let sprite = character.sprite else { return }
        character.giveArmor(amount)
        animationPipeline.add(
            GiveArmorAnimation(character: sprite, amount: amount)
        )
    }
    
    /*
    func heal(_ amount: Int, to spot: Spot) {
        if let creature = spot.creature {
            let healed = creature.heal(amount)
             animationPipeline.add(
                 DamageAnimation( character: creature.sprite, amount: healed )
             )
        }
    }
    
    func buffStat(_ stat: StatLabel.Kind, by amount: Int, at spot: Spot) {
        if let creature = spot.creature {
            _ = creature.increaseStat(stat: stat, by: amount)
            
            animationPipeline.add(
                BuffStatAnimation(
                    creature: creature.sprite as! CreatureSprite,
                    stat: stat,
                    by: amount
                )
            )
        }
    }
    
    func buffStat(_ stat: StatLabel.Kind, by amount: Int, to card: CreatureCard) {
        if let sprite = card.sprite as? CreatureCardSprite {
            card.increaseStat(stat, by: amount)
            
            animationPipeline.add(
                BuffCardStatAnimation(
                    card: sprite,
                    stat: stat,
                    by: amount
                )
            )
        }
    }
    
    func setStat(_ stat: StatLabel.Kind, to amount: Int, at spot: Spot) {
        if let creature = spot.creature {
            _ = creature.setStat(stat: stat, to: amount)
            
            animationPipeline.add(
                BuffStatAnimation(
                    creature: creature.sprite as! CreatureSprite,
                    stat: stat,
                    to: amount
                )
            )
        }
    }*/
    /*
    func replaceAbility(of creature: Creature, with ability: ActiveAbility?) {
        creature.ability = ability
        animationPipeline.add(
            ReplaceAbilityAnimation(creature: creature.sprite as! CreatureSprite, ability: ability)
        )
    }*/
    
    func useAbility(caster: Creature, ability: ActiveAbility, target: Character?) {  // TODO: Rename to use()
        //if !creature.isExhausted && (ability.left == 0) {
        //setExhaustion(of: creature, to: true)
        //ability.left = ability.cooldown
        //animationPipeline.add(
            //ResetCooldownAnimation(creature: creature.sprite as! CreatureSprite)
        //)
        resetCooldown(of: ability)
        ability.effect(self, caster, target)
    }
    
    func decreaseCooldown(of ability: ActiveAbility) {
        ability.cooldown.decrease()
        updateCooldownVisuals(of: ability)
    }
    
    func resetCooldown(of ability: ActiveAbility) {
        ability.cooldown.reset()
        updateCooldownVisuals(of: ability)
    }
    
    private func updateCooldownVisuals(of ability: ActiveAbility) {
        if let button = ability.button {
            animationPipeline.add(
                SetAbilityCooldownAnimation(ability: button, cooldown: ability.cooldown.left)
            )
        }
    }
    
    /*
    func decreaseAbilityCooldown(of creature: Creature) {
        if let ability = creature.ability {
            if ability.left > 0 {
                ability.left -= 1
            }
        }
        animationPipeline.add(
            DecreaseCooldownAnimation(creature: creature.sprite as! CreatureSprite)
        )
    }*/
    
    func wait(for delay: TimeInterval) {
        animationPipeline.add(
            WaitAnimation(battle: sprite, delay: delay)
        )
    }
    /*
    func showAbilitiesList(of creature: Creature) {
        // TODO: Move it to selectedCreature.set()
        if selectedCreature != nil {
            animationPipeline.add(
                HideAbilitiesListAnimation(of: selectedCreature!)
            )
        }
        selectedCreature = creature
        animationPipeline.add(
            ShowAbilitiesListAnimation(of: creature)
        )
    }*/
    /*
    func highlightActionTargets() {
        let activePlayerSpots = spots.filter { $0.owner == activePlayer }
        for spot in activePlayerSpots {
            if let creature = spot.creature {
                if !creature.isExhausted {
                    spot.state.insert(.interactive)
                    if creature.ability?.left == 0 {
                        spot.state.insert(.activatable)
                    }
                }
            }
        }
        if activePlayer.isHuman {
            for card in human.deck.handPile {
                let sprite = card.sprite
                if card.requiresTarget {
                    let targets = interactives.filter(sprite.targetsFilter)
                    if targets.count <= 0 { continue }
                }
                sprite.state.insert(.interactive)
            }
            passButton.state.insert(.interactive)
        }
    }
    
    private func generateRandomComposition() -> [CreatureCard] {
        var power = 0
        var composition: [CreatureCard] = []
        
        repeat {
            let count = Int.random(in: 1...6)
            for _ in 0..<count {
                let card = CardLibrary.getRandomCard { $0 is CreatureCard }
                composition.append(card as! CreatureCard)
            }
            power = composition.map( { $0.power } ).reduce(0, +)
            
            while (power > 25) && (composition.count > 0) {
                composition.remove(at: 0)
                power = composition.map( { $0.power } ).reduce(0, +)
            }
        } while (power < 15)
        return composition
    }*/
    
}
