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
                                         size: CGSize(width: 91, height: 42), upgradeLevel: 0, lifes: 3)

    private var desiredPosition: CGPoint = CGPoint(x: 0, y: 0)

    private var lastTime: Double = 0

    override func didMove(to view: SKView) {
        self.backgroundColor = .darkGray
        print(self.size.width)
        self.spaceship.position = CGPoint(x: -self.size.width * 0.45, y: 0)
        desiredPosition = self.spaceship.position
        self.addChild(self.spaceship)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.desiredPosition.y = touch.location(in: self).y
            self.desiredPosition.x = touch.location(in: self).x
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
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.desiredPosition.y = touch.location(in: self).y
            self.desiredPosition.x = touch.location(in: self).x
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
        if self.spaceship.position.x < -self.size.height/2 + 350 {
            self.spaceship.position.x = -self.size.height/2 + 350
        }
        lastTime = currentTime
    }
}
