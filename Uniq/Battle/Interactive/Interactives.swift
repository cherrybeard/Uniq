//
//  Interactives.swift
//  Uniq
//
//  Created by Steven Gusev on 27/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class Interactives {
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
    
    func addStatus(_ status: InteractiveStatus, filter: (Interactive) -> Bool) {
        let targets = interactives.filter(filter)
        for var target in targets {
            target.status.insert(status)
        }
    }
    
    func removeStatus(_ status: InteractiveStatus) {
        for var target in interactives {
            target.status.remove(status)
        }
    }
    
    func cleanAllStatus() {
        for var interactive in interactives {
            interactive.status = []
        }
    }
}
