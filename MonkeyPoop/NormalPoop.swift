//
//  NormalPoop.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import Foundation
import SpriteKit


class NormalPoop: PoopProjectile {
    
    init() {
        
        //custom proprietes
        let texture = SKTexture(imageNamed: "Poo")
        
        super.init(speed: 1, damage: 80,texture:texture)
        
        
        
    }
    
    required init?(coder aDEcoder: NSCoder) {
        fatalError("init not implemented")
    }
    
    
}