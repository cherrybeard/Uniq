//
//  Interactives.swift
//  Uniq
//
//  Created by Steven Gusev on 27/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Interactives {    // TODO: Inherit Collection
    private var interactives: [Interactive] = []
    
    func filter(_ filter: (Interactive) -> Bool) -> [Interactive] {
        return interactives.filter(filter)
    }
    
    func first(where filter: (Interactive) -> Bool) -> Interactive? {
        return interactives.first(where: filter)
    }
    
    func removeAll(filter: (Interactive) -> Bool) {
        interactives.removeAll(where: filter)
    }
    
    func append(_ item: Interactive) {
        interactives.append(item)
    }
    
    func addStatus(_ status: InteractiveState, filter: (Interactive) -> Bool) {
        let targets = interactives.filter(filter)
        for var target in targets {
            target.state.insert(status)
        }
    }
    
    func removeStatus(_ status: InteractiveState) {
        for var target in interactives {
            target.state.remove(status)
        }
    }
    
    func cleanAllStatus() {
        for var interactive in interactives {
            interactive.state = []
        }
    }
}
