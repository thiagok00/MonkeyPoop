//
//  GameScene.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright (c) 2015 ThiagoMay. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate,GuyProtocol {
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var player:Monkey!
    private var lifes = 3
    private let maxLifes = 3
    private var lifesArray = [SKSpriteNode]()
    private var score = 0
    var scoreLabel = SKLabelNode(text: "0")
    var gamePaused = false
    var popUp:SKSpriteNode?
    
    var spawnWait = 2.0
    
    
    enum PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Enemy   : UInt32 = 0b1       // 1
        static let Projectile: UInt32 = 0b10      // 2
    }
    
    
    
    override func didMoveToView(view: SKView) {
        
        //Setting up variables
        screenWidth = self.frame.size.width
        screenHeight = self.frame.size.height
        
        //  BACKGROUND IMAGE
        let bgImg = SKSpriteNode(imageNamed: "bggame")
        bgImg.size = CGSizeMake(screenWidth, screenHeight )
        bgImg.position = CGPointMake(screenWidth/2, screenHeight/2)
        bgImg.zPosition = -20
        self.addChild(bgImg)
        
        
        // SETTING UP PHYSICS WORLD
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        
        // SETTING UP PLAYER
        player = Monkey()
        player.position = CGPointMake(player.size.width/2, screenHeight/2)
        self.addChild(player)
        
        //SCORE LABEL
        scoreLabel.position = CGPointMake(screenWidth/2, screenHeight - scoreLabel.frame.size.height)
        scoreLabel.fontName = "Avenir-Black"
        scoreLabel.zPosition = 10
        self.addChild(scoreLabel)
        
        // SETTING UP LIFES
        var x:CGFloat = CGSize.bananaSize().width/2
        let paddingX = CGSize.bananaSize().width
        let y:CGFloat = screenHeight - CGSize.bananaSize().height/2
        for var i = 0 ; i < maxLifes; i++ {
            let banana = SKSpriteNode(imageNamed: "Banana")
            banana.position = CGPointMake(x, y)
            banana.size = CGSize.bananaSize()
            self.addChild(banana)
            lifesArray.append(banana)
            x = x + paddingX
        }
        
        
        let pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.size = CGSizeMake(60, 60)
        pauseButton.position = CGPointMake(self.frame.width - pauseButton.size.width/2, self.frame.height - pauseButton.size.height/2)
        pauseButton.name = "Pause"
        self.addChild(pauseButton)
        
        
        
        
        self.spawnEnemies()

        
    }
    
    
    func spawnEnemies () {
        self.removeActionForKey("Spawn")
        let wait = SKAction.waitForDuration(spawnWait)
        let spawn = SKAction.runBlock({ self.generateEnemy()})
        let seq = SKAction.sequence([wait,spawn])
        
        self.runAction(SKAction.repeatActionForever(seq), withKey: "Spawn")
    
    }
    
    func generateEnemy() {
        
                
        let fEnemy = GuestGuy()
        
        fEnemy.delegate = self
        
        fEnemy.position.x = screenWidth + fEnemy.size.width/2
        var max:Int = Int(self.screenHeight-50)
        
        max = Int.random(50...max)
        let randomNumb:CGFloat = CGFloat(max)
        
        fEnemy.position.y = randomNumb
        self.addChild(fEnemy)
        fEnemy.moveFoward()
        fEnemy.xScale = -1
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            
            if gamePaused {
                if node.name == "Resume" {
                    self.paused = false
                    gamePaused = false
                    self.popUp?.removeFromParent()
                
                }
                else if node.name == "Home" {
                    let scene = MainMenu(size:self.size)
                    let transition = SKTransition.fadeWithDuration(1)
                    self.view?.presentScene(scene, transition: transition)
                }
                else if node.name == "Restart" {
                    let scene = GameScene(size:self.size)
                    let transition = SKTransition.fadeWithDuration(1)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
            else if node.name == "Pause" {
                
                self.paused = true
                gamePaused = true
                self.popUp = PausePopup.createPausePopup(self.size)
                popUp?.zPosition = 100
                self.addChild(popUp!)
                
            }
            else {
                self.player.fireNormalPoop(location)
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var projPB:SKPhysicsBody
        var enemyPB:SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            enemyPB  = contact.bodyA
            projPB = contact.bodyB
            
        }
        else {
            projPB = contact.bodyA
            enemyPB = contact.bodyB
        }
        
        let projectile = projPB.node as! PoopProjectile
        let enemy = enemyPB.node as! Guy
        
        enemy.inflictDamage(projectile.damage)
        projectile.explode()
        
        
    }
    
    func wonScore(reward: Int) {
        self.score = self.score + reward
        scoreLabel.text = "\(self.score)"
        self.updateSpawnDuration()
    }
    func updateSpawnDuration() {
    
        switch score {
        
        case 2000:
            self.spawnEnemies()
            spawnWait = 0.1
            break
        case 1500:
            self.spawnEnemies()
            spawnWait = 0.3
            break
        case 1000:
            self.spawnEnemies()
            spawnWait = 0.5
            break
        case 500:
            self.spawnEnemies()
            spawnWait = 0.7
            break
        case 200:
            self.spawnEnemies()
            spawnWait = 1.0
            break
        default:
            return
        }
    
    
    }
    
    func guyRunnedOut(guy: Guy) {
        guy.removeFromParent()
        self.removeOneLife()
    }
    
    private func removeOneLife() {
        if lifes > 0 {
            self.lifesArray[self.lifes-1].removeFromParent()
            lifes--
        }
        if lifes == 0 {
            
            self.gamePaused = true
            self.paused = true
            self.popUp = GameOverPopup.createGameOverPopup(self.size)
            popUp?.zPosition = 200
            self.addChild(self.popUp!)
            
        }
    
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
