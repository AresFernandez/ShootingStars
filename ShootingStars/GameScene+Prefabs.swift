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
        enemy.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.linearDamping = 0
        enemy.physicsBody?.categoryBitMask = 0x00000100
        enemy.physicsBody?.collisionBitMask = 0x00000000
        enemy.physicsBody?.contactTestBitMask = 0x00000111

        enemy.run(enemyFlyAction, withKey: enemyFlyKey)
        addChild(enemy)

    }
}
