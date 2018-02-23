//
//  AnimationPipeline.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class AnimationPipeline {
    private var pipelineStack: [Animation] = []
    var state: AnimationState {
        get {
            return (pipelineStack.count > 0) ? AnimationState.inProgress : AnimationState.finished
        }
    }
    
    init() {
        
    }
    
    func add(animation: Animation) {
        pipelineStack.append(animation)
    }
    
    func update() {
        if (pipelineStack.count > 0) && (pipelineStack[0].state == AnimationState.finished) {
            pipelineStack.remove(at: 0)
        }
        if (pipelineStack.count > 0) && (pipelineStack[0].state == AnimationState.ready) {
            pipelineStack[0].play()
        }
    }
}
