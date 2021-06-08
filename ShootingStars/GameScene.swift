//
//  GameScene.swift
//  ShootingStars
//
//  Created by Alumne on 29/4/21.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var spaceship: SpaceShip = SpaceShip(texture: SKTexture(imageNamed: "ship1"), color: UIColor.white,
                                         size: CGSize(width: 91, height: 42),
                                         upgradeLevel: 0, lifes: 3, shotCadency: 0.5)

    private var desiredPosition: CGPoint = CGPoint(x: 0, y: 0)

    private var lastTime: Double = 0
    private var lastShot: Double = 0

    private var isShooting: Bool = false

    var currentScore: Int = 0
    var scoreLabel: SKLabelNode!
    var lifesLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!

    var enemyTimer: Timer?
    var powerUpTimer: Timer?

    var enemyCounter: Int = 0

    var gameOver: Bool = false
    var enemyTimer1: Bool = false
    var enemyTimer2: Bool = false
    var enemyTimer3: Bool = false

    override func didMove(to view: SKView) {
        self.initializeGame()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if gameOver {
                clearEverything()
                initializeGame()
                gameOver = false
            }
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

        if gameOver {
            return
        }

        if self.currentScore >= 150 && !enemyTimer3 {
            self.enemyTimer?.invalidate()
            self.enemyTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self,
                                                   selector: #selector(addEnemy), userInfo: nil, repeats: true)
            enemyTimer3 = true
        } else if self.currentScore >= 100 && !enemyTimer2 {
            self.enemyTimer?.invalidate()
            self.enemyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                                   selector: #selector(addEnemy), userInfo: nil, repeats: true)
            enemyTimer2 = true
        } else if self.currentScore >= 50 && !enemyTimer1 {
            self.enemyTimer?.invalidate()
            self.enemyTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                                   selector: #selector(addEnemy), userInfo: nil, repeats: true)
            enemyTimer1 = true
        }

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

    func initializeGame() {
        self.backgroundColor = .black

        initializeParticles()

        enemyCounter = 0
        enemyTimer1 = false
        enemyTimer2 = false
        enemyTimer3 = false

        initializeSpaceShip()

        self.physicsWorld.contactDelegate = self

        self.currentScore = 0
        self.scoreLabel = SKLabelNode(text: "SCORE: \(self.currentScore)")
        self.scoreLabel.position = CGPoint(x: -200, y: -self.size.width * 0.25)
        self.scoreLabel.zPosition = 2
        self.scoreLabel.fontName = "CopperplateGothic Bold"
        self.addChild(self.scoreLabel)

        self.spaceship.lifes = 3
        self.lifesLabel = SKLabelNode(text: "LIFES: \(self.spaceship.lifes)")
        self.lifesLabel.position = CGPoint(x: 200, y: -self.size.width * 0.25)
        self.lifesLabel.zPosition = 2
        self.lifesLabel.fontName = "CopperplateGothic Bold"
        self.addChild(self.lifesLabel)

        self.spaceship.upgradeLevel = 0
        self.spaceship.refreshTexture()

        self.enemyTimer = Timer.scheduledTimer(timeInterval: 2, target: self,
                                               selector: #selector(addEnemy), userInfo: nil, repeats: true)

        self.powerUpTimer?.invalidate()
        self.powerUpTimer = Timer.scheduledTimer(timeInterval: 30, target: self,
                                               selector: #selector(addPowerUp), userInfo: nil, repeats: true)

    }

    func initializeParticles() {
        if let stars = SKEmitterNode(fileNamed: "Stars") {
            stars.position.x = self.size.width/2 + 10
            stars.position.y = 0
            stars.zPosition = -1
            stars.advanceSimulationTime(10)
            addChild(stars)
        }

        if let botTerrain = SKEmitterNode(fileNamed: "BotTerrain") {
            botTerrain.position.x = self.size.width/2 + 550
            botTerrain.position.y = -self.size.height * 0.18
            botTerrain.zPosition = 1
            botTerrain.advanceSimulationTime(10)
            addChild(botTerrain)
        }

        if let topTerrain = SKEmitterNode(fileNamed: "TopTerrain") {
            topTerrain.position.x = self.size.width/2 + 550
            topTerrain.position.y = self.size.height * 0.18
            topTerrain.zPosition = 1
            topTerrain.advanceSimulationTime(10)
            addChild(topTerrain)
        }
    }

    func initializeSpaceShip() {
        self.spaceship.position = CGPoint(x: -self.size.width * 0.45, y: 0)
        self.spaceship.name = "spaceship"
        desiredPosition = self.spaceship.position
        self.addChild(self.spaceship)
        self.spaceship.shotCadency = 0.5
        self.spaceship.physicsBody = SKPhysicsBody(texture: self.spaceship.texture!, size: self.spaceship.size)
        self.spaceship.physicsBody?.categoryBitMask = 0x00000001
        self.spaceship.physicsBody?.collisionBitMask = 0x00000000
        self.spaceship.physicsBody?.contactTestBitMask = 0x00011100
        self.spaceship.physicsBody?.affectedByGravity = false
        self.spaceship.physicsBody?.isDynamic = false
    }

    private func cleanPastShoots() {
        for node in self.children {
            guard node.name == "shot" || node.name == "enemy" ||
                    node.name == "meteorite" || node.name == "powerUp" else { continue }
            if node.position.x > self.size.height/2 + 200 || node.position.x < -self.size.height/2 - 200 {
                node.removeFromParent()
            }
        }
    }

    func clearEverything() {
        for node in self.children {
            node.removeFromParent()
        }
        self.enemyTimer?.invalidate()
        self.enemyTimer = nil
        self.powerUpTimer?.invalidate()
        self.powerUpTimer = nil
    }

    func createGameOverStats() {
        self.gameOverLabel = SKLabelNode(text: "GAMEOVER")
        self.gameOverLabel.position = CGPoint(x: 0, y: self.size.width * 0.1)
        self.gameOverLabel.zPosition = 2
        self.gameOverLabel.fontSize *= 2
        self.gameOverLabel.fontName = "CopperplateGothic Bold"
        self.gameOverLabel.fontColor = UIColor.red
        self.addChild(self.gameOverLabel)

        let yourScoreLabel = SKLabelNode(text: "YOUR SCORE IS: \(currentScore)")
        yourScoreLabel.position = CGPoint(x: 0, y: 0)
        yourScoreLabel.zPosition = 2
        yourScoreLabel.fontName = "CopperplateGothic Bold"
        self.addChild(yourScoreLabel)

        let tapAgainLabel = SKLabelNode(text: "TAP TO PLAY AGAIN...")
        tapAgainLabel.position = CGPoint(x: 0, y: -self.size.width * 0.1)
        tapAgainLabel.zPosition = 2
        tapAgainLabel.fontName = "CopperplateGothic Bold"
        self.addChild(tapAgainLabel)
    }

    @objc
    private func addEnemy() {

        if enemyCounter >= 6 {
            self.createMeteorite(at: CGPoint(x: Int(self.size.height/2 - 160), y:
                                 Int.random(in: Int(-self.size.width/2) + 200..<Int(self.size.width/2 - 200))))
            enemyCounter = 0
        } else {
            self.createEnemy(at: CGPoint(x: Int(self.size.height/2 - 260), y:
                                        Int.random(in: Int(-self.size.width/2) + 200..<Int(self.size.width/2 - 200))))
            enemyCounter += 1
        }
    }

    @objc
    private func addPowerUp() {
        self.createPowerUp(at: CGPoint(x: Int(self.size.height/2 - 260), y:
                                    Int.random(in: Int(-self.size.width/2) + 200..<Int(self.size.width/2 - 200))))
    }
}
