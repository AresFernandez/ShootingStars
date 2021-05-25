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
}
