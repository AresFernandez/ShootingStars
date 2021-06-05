//
//  GameScene+Prefabs.swift
//  ShootingStars
//
//  Created by Alumne on 20/5/21.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {

    func createShoot() {
        if self.spaceship.upgradeLevel == 0 {
            let sprite = SKSpriteNode(imageNamed: "shot")
            sprite.position = self.spaceship.position
            sprite.name = "shot"
            sprite.zPosition = 1
            sprite.position = CGPoint(x: sprite.position.x + 50.0, y: sprite.position.y)
            addChild(sprite)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
            sprite.physicsBody?.affectedByGravity = false
            sprite.physicsBody?.linearDamping = 0
            sprite.physicsBody?.categoryBitMask = 0x00000010
            sprite.physicsBody?.collisionBitMask = 0x00000000
            sprite.physicsBody?.contactTestBitMask = 0x00000100
        } else {
            let sprite = SKSpriteNode(imageNamed: "shot")
            sprite.position = self.spaceship.position
            sprite.name = "shot"
            sprite.zPosition = 1
            sprite.position = CGPoint(x: sprite.position.x + 50.0, y: sprite.position.y - 10)
            addChild(sprite)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
            sprite.physicsBody?.affectedByGravity = false
            sprite.physicsBody?.linearDamping = 0
            sprite.physicsBody?.categoryBitMask = 0x00000010
            sprite.physicsBody?.collisionBitMask = 0x00000000
            sprite.physicsBody?.contactTestBitMask = 0x00000100

            let sprite2 = SKSpriteNode(imageNamed: "shot")
            sprite2.position = self.spaceship.position
            sprite2.name = "shot"
            sprite2.zPosition = 1
            sprite2.position = CGPoint(x: sprite2.position.x + 50.0, y: sprite2.position.y + 10)
            addChild(sprite2)
            sprite2.physicsBody = SKPhysicsBody(texture: sprite2.texture!, size: sprite2.size)
            sprite2.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
            sprite2.physicsBody?.affectedByGravity = false
            sprite2.physicsBody?.linearDamping = 0
            sprite2.physicsBody?.categoryBitMask = 0x00000010
            sprite2.physicsBody?.collisionBitMask = 0x00000000
            sprite2.physicsBody?.contactTestBitMask = 0x00000100
        }

    }

    func createEnemy(at position: CGPoint) {

        let enemyAnimation = [SKTexture(imageNamed: "enemy1"), SKTexture(imageNamed: "enemy2"),
                              SKTexture(imageNamed: "enemy3"), SKTexture(imageNamed: "enemy4")]
        var enemyFlyAction: SKAction
        let enemyFlyKey = "EnemyFly"

        enemyFlyAction = SKAction.repeatForever(SKAction.animate(with: enemyAnimation, timePerFrame: 0.15))

        let enemy = SKSpriteNode(imageNamed: "enemy1")
        enemy.position = position
        enemy.name = "enemy"
        enemy.zPosition = 1
        enemy.size = CGSize(width: enemy.size.width/2, height: enemy.size.height/2)
        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
        enemy.physicsBody?.velocity = CGVector(dx: -150 - (self.currentScore * 5), dy: 0)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.linearDamping = 0
        enemy.physicsBody?.categoryBitMask = 0x00000100
        enemy.physicsBody?.collisionBitMask = 0x00000000
        enemy.physicsBody?.contactTestBitMask = 0x00000111

        enemy.run(enemyFlyAction, withKey: enemyFlyKey)
        addChild(enemy)

    }

    func createMeteorite(at position: CGPoint) {

        let meteoriteFlyAction = SKAction.repeatForever(SKAction.rotate(byAngle: 0.15, duration: 1))

        let meteorite = SKSpriteNode(imageNamed: "meteorite")
        meteorite.position = position
        meteorite.name = "meteorite"
        meteorite.zPosition = 1
        meteorite.size = CGSize(width: meteorite.size.width, height: meteorite.size.height)
        meteorite.physicsBody = SKPhysicsBody(texture: meteorite.texture!, size: meteorite.size)
        meteorite.physicsBody?.velocity = CGVector(dx: -100 - (self.currentScore), dy: 0)
        meteorite.physicsBody?.affectedByGravity = false
        meteorite.physicsBody?.linearDamping = 0
        meteorite.physicsBody?.categoryBitMask = 0x00001000
        meteorite.physicsBody?.collisionBitMask = 0x00000000
        meteorite.physicsBody?.contactTestBitMask = 0x00000111

        meteorite.run(meteoriteFlyAction)
        addChild(meteorite)

    }

    func createPowerUp(at position: CGPoint) {

        let powerUpAnimation = [SKTexture(imageNamed: "powerup1"), SKTexture(imageNamed: "powerup2"),
                              SKTexture(imageNamed: "powerup3"), SKTexture(imageNamed: "powerup4"),
                              SKTexture(imageNamed: "powerup5"), SKTexture(imageNamed: "powerup6"),
                              SKTexture(imageNamed: "powerup7"), SKTexture(imageNamed: "powerup8")]
        var powerUpAction: SKAction
        let powerUpKey = "powerUp"

        powerUpAction = SKAction.repeatForever(SKAction.animate(with: powerUpAnimation, timePerFrame: 0.15))

        let powerUp = SKSpriteNode(imageNamed: "powerup1")
        powerUp.position = position
        powerUp.name = "powerUp"
        powerUp.zPosition = 2
        powerUp.size = CGSize(width: powerUp.size.width/2, height: powerUp.size.height/2)
        powerUp.physicsBody = SKPhysicsBody(texture: powerUp.texture!, size: powerUp.size)
        powerUp.physicsBody?.velocity = CGVector(dx: -125, dy: 0)
        powerUp.physicsBody?.affectedByGravity = false
        powerUp.physicsBody?.linearDamping = 0
        powerUp.physicsBody?.categoryBitMask = 0x00010000
        powerUp.physicsBody?.collisionBitMask = 0x00000000
        powerUp.physicsBody?.contactTestBitMask = 0x00000001

        powerUp.run(powerUpAction, withKey: powerUpKey)
        addChild(powerUp)

    }

}
