//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Chuma Nnaji on 2/15/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var bird = SKSpriteNode(imageNamed: "img/flappy1.png")

    override func didMoveToView(view: SKView) {
        addBackground()
        addGround()
        addPipes()
        addBird()

        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "addPipes", userInfo: nil, repeats: true)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
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
            self.addChild(bg)
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
        self.addChild(ground)
    }

    /**
    Add new pipes to the scene.
    */
    func addPipes() {
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
        self.addChild(topPipe)

        var bottomPipe = SKSpriteNode(imageNamed: "img/pipe2.png")
        bottomPipe.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width, y: CGRectGetMidY(self.frame) - (topPipe.size.height / 2) - (gapHeight / 2) + pipeOffset)
        bottomPipe.runAction(moveAndRemovePipes)
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOfSize: bottomPipe.size)
        bottomPipe.physicsBody?.dynamic = false
        self.addChild(bottomPipe)
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

        self.addChild(bird)
    }
}
