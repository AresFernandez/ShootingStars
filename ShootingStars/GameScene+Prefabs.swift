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
        sprite.physicsBody?.contactTestBitMask = 0x00000101
    }
}
