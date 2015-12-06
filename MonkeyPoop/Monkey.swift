//
//  Monkey.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import Foundation
import SpriteKit


class Monkey: SKSpriteNode {
    
    var atkSpeed = 0.0
    var lastBasicAttack = NSDate()
    
    let attackTextures:[SKTexture]
    
    
    init() {
        
        self.atkSpeed = 0.4
        lastBasicAttack = NSDate()
        
        let texture = SKTexture(imageNamed: "MonkeyIdle")
        
        self.attackTextures = [SKTexture(imageNamed: "MonkeyA1"),SKTexture(imageNamed: "MonkeyA2"),SKTexture(imageNamed: "MonkeyIdle")]
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(48, 62))
        
        
        
    }
    
    
    required init?(coder aDEcoder: NSCoder) {
        fatalError("init not implemented")
    }
    
    func fireNormalPoop(location:CGPoint) {
        
        let elapsedTime = NSDate().timeIntervalSinceDate(self.lastBasicAttack)
        

        if !(elapsedTime < self.atkSpeed) {
            
            let action = SKAction.animateWithTextures(attackTextures, timePerFrame: 0.1)
            
            self.runAction(action)
            
            
            let project = NormalPoop()
            project.position.x = self.position.x //+ self.player.size.width/4
            project.position.y = self.position.y
            
            
            self.parent!.addChild(project)
            project.moveTowardsPosition(location)
            self.lastBasicAttack = NSDate()
        }
        
        
    }
    
}//End of Class