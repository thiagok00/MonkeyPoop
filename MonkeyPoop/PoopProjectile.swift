//
//  PoopProjectile.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import UIKit
import SpriteKit

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return CGPoint(x: self.x / length(), y: self.y / length())
    }
}

class PoopProjectile: SKSpriteNode {
    
    var bSpeed = 1.0
    var damage:Double = 40.0
    
    
    init(speed:Double, damage:Double, texture:SKTexture) {
        
        //custom proprietes
        self.bSpeed = speed
        self.damage = damage
        
        
        
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.size = CGSize.poopSize()
        //setting up physics body
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.categoryBitMask = UInt32(0b10)
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = UInt32(0b1)
        self.physicsBody?.affectedByGravity = false
        
        self.anchorPoint = CGPointMake(0, 0.5)
        
        
    }
    
    required init?(coder aDEcoder: NSCoder) {
        fatalError("init not implemented")
    }
    
    
    func explode() {
        
        self.removeFromParent()
        
    }
    
    
    
    
    
    
    
    
    func add(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    func minus (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    func plus (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    func division (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
    
    #if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
    #endif
    
    
    
    
    func moveTowardsPosition(position:CGPoint) {
        
        
        // 3 - Determine offset of location to projectile
        let offset = minus(position, right: self.position)
        
        // 4 - Bail out if you are shooting down or backwards
        //if (offset.x < 0) {
        //    return
        //}
        
        
        // 6 - Get the direction of where to shoot
        let direction = offset.normalized()
        
        // 7 - Make it shoot far enough to be guaranteed off screen
        let shootAmount = plus(direction, scalar: 1000)
        
        // 8 - Add the shoot amount to the current position
        let realDest = add(shootAmount, right: self.position)
        
        // 9 - Create the actions
        let actionMove = SKAction.moveTo(realDest, duration: bSpeed)
        let actionMoveDone = SKAction.removeFromParent()
        
        let range = SKRange(constantValue: 0.0)
        
        
        
        let orientConstraint = SKConstraint.orientToPoint(realDest, offset: range) //.orientToPoint(realDest+self.position, inNode: self, offset: range)
        self.constraints = [orientConstraint];
        
        self.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
        
        
        //SKConstraint.orientToNode(, offset: range)
        
        
        
        
        
    }
    
}//End of Class