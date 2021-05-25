//
//  GameScene+Collisions.swift
//  ShootingStars
//
//  Created by Alumne on 23/5/21.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }

        let oneNodeIsEnemy = nameA.hasPrefix("enemy") || nameB.hasPrefix("enemy")
        let oneNodeIsShot = nameA == "shot" || nameB == "shot"
        let oneNodeIsSpaceShip = nameA == "spaceship" || nameB == "spaceship"
        let oneNodeIsMeteorite = nameA == "meteorite" || nameB == "meteorite"

        if oneNodeIsEnemy && oneNodeIsShot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()

            self.currentScore += 1
            self.scoreLabel.text = "SCORE: \(self.currentScore)"

            return
        }

        if oneNodeIsEnemy && oneNodeIsSpaceShip {

            if nameA == "enemy" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }

            self.spaceship.lifes -= 1
            self.lifesLabel.text = "LIFES: \(self.spaceship.lifes)"

            if self.spaceship.lifes <= 0 {
                self.gameOver = true
                self.clearEverything()
                self.createGameOverStats()
            }

            return
        }

        if oneNodeIsMeteorite && oneNodeIsSpaceShip {
            if nameA == "meteorite" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }

            self.spaceship.lifes -= 1
            self.lifesLabel.text = "LIFES: \(self.spaceship.lifes)"

            if self.spaceship.lifes <= 0 {
                self.gameOver = true
                self.clearEverything()
                self.createGameOverStats()
            }

            return
        }

        if oneNodeIsShot && oneNodeIsMeteorite {
            if nameA == "shot" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }
            return
        }

        if oneNodeIsMeteorite && oneNodeIsEnemy {
            if nameA == "enemy" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }
            return
        }
    }
}
