//
//  GuestGuy.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import Foundation
import SpriteKit


class GuestGuy: Guy {
    
    
    init() {
        
        let rand = Int.random(0...1)
        
        var walkTextures:[SKTexture]
        if rand == 0 {
            walkTextures = [SKTexture(imageNamed: "GuestGuyW1"),SKTexture(imageNamed: "GuestGuyW2")]
        }
        else {
            walkTextures = [SKTexture(imageNamed: "GuestGuyW3"),SKTexture(imageNamed: "GuestGuyW4")]
        }
        
        
        super.init(speed: 3.0, reward: 10, health: 100.0, type: ArmorTypes.Light, textures: walkTextures,
            timePerFrame: 0.2)

    }

    required init?(coder aDEcoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
} //End of Class