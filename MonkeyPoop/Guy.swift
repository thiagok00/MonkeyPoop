//
//  Guy.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import UIKit
import SpriteKit


enum ArmorTypes {
    case Heavy
    case Light
    case None
}

protocol GuyProtocol {

    func guyRunnedOut(guy:Guy)
    func wonScore(reward:Int)
}




class Guy: SKSpriteNode {
    
    var actualHealth:Double = 100.0
    var totalHealth:Double = 10.0
    
    var delegate:GuyProtocol?
    
    var reward = 10
    var walkSpeed = 2.5
    var mType = ArmorTypes.None
    
    var healthBar = SKSpriteNode()
    var healthBarWidth:CGFloat = 0.0
    
    
    init (speed:Double, reward:Int, health:Double, type:ArmorTypes,textures:[SKTexture], timePerFrame:Double ) {
        
        
        self.actualHealth = health
        self.totalHealth = health
        self.reward = reward
        self.walkSpeed = speed
        self.mType = type
        
        let firstTexture = textures[0]
        
        super.init(texture: firstTexture, color: UIColor.clearColor(), size: firstTexture.size())
        
        self.size = CGSize.enemySize()

        if(textures.count > 1) {
            let animation = SKAction.animateWithTextures(textures, timePerFrame: timePerFrame)
            self.runAction(SKAction.repeatActionForever(animation))
        }
        
        self.actualHealth = health
        self.totalHealth = health
        self.reward = reward
        self.walkSpeed = speed
        self.mType = type
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = UInt32(0b1)
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = UInt32(0b10)
        
        
        let backgroundHealthBar = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(self.size.width, 10))
        backgroundHealthBar.position.y = (self.size.height/2 + backgroundHealthBar.size.height/2) + backgroundHealthBar.size.height/2
        self.addChild(backgroundHealthBar)
        
        
        self.healthBar = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(self.size.width, 8))
        self.healthBarWidth = self.size.width
        self.healthBar.anchorPoint = CGPointZero
        self.healthBar.position = CGPointMake( -backgroundHealthBar.size.width/2, -self.healthBar.size.height/2)
        
        
        backgroundHealthBar.addChild(self.healthBar)
        
        backgroundHealthBar.runAction(SKAction.fadeOutWithDuration(0))
        
        
    }
    
    required init?(coder aDEcoder: NSCoder) {
        fatalError("init not implemented")
    }
    
    func moveFoward() {
        
        let move = SKAction.moveToX(-self.size.width/2, duration: walkSpeed)
        self.runAction(move, completion: {
            self.delegate?.guyRunnedOut(self)
        })
    }
    
    func inflictDamage (damage:Double) {
        
        var damageToInflict:Double
        
        if self.mType == ArmorTypes.Heavy {
            damageToInflict = damage*0.5
        }
        else if self.mType == ArmorTypes.Light {
            damageToInflict = damage*0.8
        }
        else {
            damageToInflict =  damage
        }
        
        self.actualHealth = self.actualHealth - damageToInflict
        
        if self.actualHealth <= 0 {
            self.die()
        }
        else {
            self.updateHealthBar()
        }
        
    }
    
    private func die() {
        
        self.delegate?.wonScore(self.reward)
        
        self.removeFromParent()
    }
    
    private func updateHealthBar() {
        
        let newWidth = Double(self.healthBarWidth) * self.actualHealth / self.totalHealth
        
        let parentNode = self.healthBar.parent
        
        self.healthBar.removeFromParent()
        
        let oldPos = self.healthBar.position
        
        self.healthBar = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(CGFloat(newWidth), healthBar.size.height))
        self.healthBar.anchorPoint = CGPointZero
        self.healthBar.position = oldPos
        
        parentNode?.addChild(self.healthBar)
        parentNode?.runAction(SKAction.fadeInWithDuration(0.1))
        
        
    }
    
    
    
    
} // END OF CLASS
