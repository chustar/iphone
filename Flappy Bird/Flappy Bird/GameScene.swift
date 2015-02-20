//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Chuma Nnaji on 2/15/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameOver = 0
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()

    var bird = SKSpriteNode(imageNamed: "img/flappy1.png")
    let birdGroup: UInt32 = 1
    let objectGroup: UInt32 = 2
    let gapGroup: UInt32 = 0 << 3


    var movingObjects = SKNode()

    override func didMoveToView(view: SKView) {
        self.addChild(movingObjects)

        addPhysics()
        addBackground()
        addGround()
        addPipes()
        addBird()
        addUI()

        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "addPipes", userInfo: nil, repeats: true)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if gameOver == 0 {
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        } else {
            score = 0
            gameOver = 0
            scoreLabel.text = "0"
            gameOverLabel.alpha = 0
            movingObjects.removeAllChildren()
            movingObjects.speed = 1
            addBackground()
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

    func didBeginContact(contact: SKPhysicsContact) {
        println(contact.bodyA)
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup {
            score++
            scoreLabel.text = "\(score)"
        } else if gameOver == 0 {
            gameOver = 1
            movingObjects.speed = 0
            gameOverLabel.alpha = 1
        }
    }

    /**
    Add the game physics.
    */
    func addPhysics() {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -5)
    }

    /**
    Add the background.
    */
    func addBackground() {
        var bgTexture = SKTexture(imageNamed: "img/bg.png")
        var moveBg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replaceBg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var moveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveBg, replaceBg]))

        for var i: CGFloat = 0; i < 3; i++ {
            var bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width / 2 + (bgTexture.size().width * i), y: CGRectGetMidY(self.frame))
            bg.size.height = self.frame.height
            bg.runAction(moveBgForever)
            movingObjects.addChild(bg)
        }
    }

    /**
    Add the ground to the scene.
    */
    func addGround() {
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup
        self.addChild(ground)
    }

    /**
    Add new pipes to the scene.
    */
    func addPipes() {
        if gameOver == 0 {
            let gapHeight = bird.size.height * 4
            var movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
            var pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4

            var movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))

            var removePipes = SKAction.removeFromParent()
            var moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])

            var topPipe = SKSpriteNode(imageNamed: "img/pipe1.png")
            topPipe.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width, y: CGRectGetMidY(self.frame) + (topPipe.size.height / 2) + (gapHeight / 2) + pipeOffset)
            topPipe.runAction(moveAndRemovePipes)
            topPipe.physicsBody = SKPhysicsBody(rectangleOfSize: topPipe.size)
            topPipe.physicsBody?.dynamic = false
            topPipe.physicsBody?.categoryBitMask = objectGroup
            movingObjects.addChild(topPipe)

            var bottomPipe = SKSpriteNode(imageNamed: "img/pipe2.png")
            bottomPipe.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width, y: CGRectGetMidY(self.frame) - (topPipe.size.height / 2) - (gapHeight / 2) + pipeOffset)
            bottomPipe.runAction(moveAndRemovePipes)
            bottomPipe.physicsBody = SKPhysicsBody(rectangleOfSize: bottomPipe.size)
            bottomPipe.physicsBody?.dynamic = false
            bottomPipe.physicsBody?.categoryBitMask = objectGroup
            movingObjects.addChild(bottomPipe)

            var gap = SKNode()
            gap.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width, y: CGRectGetMidY(self.frame) + pipeOffset)
            gap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: topPipe.size.width, height: gapHeight))
            gap.runAction(moveAndRemovePipes)
            gap.physicsBody?.dynamic = false
            gap.physicsBody?.categoryBitMask = gapGroup
            gap.physicsBody?.collisionBitMask = gapGroup
            gap.physicsBody?.contactTestBitMask = birdGroup
            movingObjects.addChild(gap)
        }
    }

    /**
    Add the bird.
    */
    func addBird() {
        var birdTexture = SKTexture(imageNamed: "img/flappy1.png")
        var birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        var animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        var makeBidFlap = SKAction.repeatActionForever(animation)

        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBidFlap)
        bird.zPosition = 10

        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false
        bird.physicsBody?.categoryBitMask = birdGroup
        //        bird.physicsBody?.collisionBitMask = objectGroup
        bird.physicsBody?.contactTestBitMask = objectGroup
//        bird.physicsBody?.collisionBitMask = gapGroup
        self.addChild(bird)
    }

    func addUI() {
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        self.addChild(scoreLabel)

        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.fontSize = 30
        gameOverLabel.text = "Touch screen to start over"
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        gameOverLabel.alpha = 0
        self.addChild(gameOverLabel)
    }
}
