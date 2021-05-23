//
//  GameScene.swift
//  ShootingStars
//
//  Created by Alumne on 29/4/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var spaceship: SpaceShip = SpaceShip(texture: SKTexture(imageNamed: "ship1"), color: UIColor.white,
                                         size: CGSize(width: 91, height: 42),
                                         upgradeLevel: 0, lifes: 3, shotCadency: 0.5)

    var botTerrain: SKSpriteNode = SKSpriteNode(imageNamed: "BotTerrain")
    var topTerrain: SKSpriteNode = SKSpriteNode(imageNamed: "TopTerrain")

    private var desiredPosition: CGPoint = CGPoint(x: 0, y: 0)

    private var lastTime: Double = 0
    private var lastShot: Double = 0

    private var isShooting: Bool = false

    var currentScore: Int = 0
    var scoreLabel: SKLabelNode!

    var enemyTimer: Timer?

    override func didMove(to view: SKView) {
        self.backgroundColor = .black

        if let stars = SKEmitterNode(fileNamed: "Stars") {
            stars.position.x = self.size.width/2 + 10
            stars.position.y = 0
            stars.zPosition = -1
            stars.advanceSimulationTime(10)
            addChild(stars)
        }

        self.botTerrain.position = CGPoint(x: 0, y: -self.size.height * 0.18)
        self.addChild(self.botTerrain)

        self.topTerrain.position = CGPoint(x: 0, y: self.size.height * 0.18)
        self.addChild(self.topTerrain)

        self.spaceship.position = CGPoint(x: -self.size.width * 0.45, y: 0)
        self.spaceship.name = "spaceship"
        desiredPosition = self.spaceship.position
        self.addChild(self.spaceship)
        self.spaceship.physicsBody = SKPhysicsBody(texture: self.spaceship.texture!, size: self.spaceship.size)
        self.spaceship.physicsBody?.categoryBitMask = 0x00000001
        self.spaceship.physicsBody?.collisionBitMask = 0x00000000
        self.spaceship.physicsBody?.contactTestBitMask = 0x00000100
        self.spaceship.physicsBody?.affectedByGravity = false
        self.spaceship.physicsBody?.isDynamic = false

        self.physicsWorld.contactDelegate = self

        self.scoreLabel = SKLabelNode(text: "SCORE: 0")
        self.scoreLabel.position = CGPoint(x: 0, y: -self.size.width * 0.15)
        self.scoreLabel.zPosition = 2
        self.addChild(self.scoreLabel)

        self.enemyTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self,
                                               selector: #selector(addEnemy), userInfo: nil, repeats: true)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.desiredPosition.y = touch.location(in: self).y
            self.desiredPosition.x = touch.location(in: self).x
            isShooting = true
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.desiredPosition.y = touch.location(in: self).y
            self.desiredPosition.x = touch.location(in: self).x
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.desiredPosition.y = touch.location(in: self).y
            self.desiredPosition.x = touch.location(in: self).x
            isShooting = false
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.desiredPosition.y = touch.location(in: self).y
            self.desiredPosition.x = touch.location(in: self).x
            isShooting = false
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.cleanPastShoots()

        // SpaceshipMovement
        self.spaceship.position.y += (self.desiredPosition.y - self.spaceship.position.y) *
            (CGFloat(currentTime) - CGFloat(lastTime)) * 10
        self.spaceship.position.x += (self.desiredPosition.x - self.spaceship.position.x) *
            (CGFloat(currentTime) - CGFloat(lastTime)) * 10

        if self.spaceship.position.y > self.size.width/2 - 200 {
            self.spaceship.position.y = self.size.width/2 - 200
        }
        if self.spaceship.position.y < -self.size.width/2 + 200 {
            self.spaceship.position.y = -self.size.width/2 + 200
        }

        if self.spaceship.position.x > self.size.height/2 - 350 {
            self.spaceship.position.x = self.size.height/2 - 350
        }
        if self.spaceship.position.x < -self.size.height/2 + 310 {
            self.spaceship.position.x = -self.size.height/2 + 310
        }

        // Spaceship Shooting
        lastShot += (currentTime - lastTime)
        if isShooting && lastShot > self.spaceship.shotCadency {
            self.createShoot()
            lastShot = 0
        }

        lastTime = currentTime
    }

    private func cleanPastShoots() {
        for node in self.children {
            guard node.name == "shot" || node.name == "enemy" else { continue }
            if node.position.x > self.size.height/2 + 200 || node.position.x < -self.size.height/2 - 200 {
                node.removeFromParent()
            }
        }
    }

    @objc
    private func addEnemy() {
        self.createEnemy(at: CGPoint(x: Int(self.size.height/2 - 260), y:
                                        Int.random(in: Int(-self.size.width/2) + 200..<Int(self.size.width/2 - 200))))
    }
}
