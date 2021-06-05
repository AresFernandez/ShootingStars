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
    // swiftlint:disable cyclomatic_complexity
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }

        let oneNodeIsEnemy = nameA.hasPrefix("enemy") || nameB.hasPrefix("enemy")
        let oneNodeIsShot = nameA == "shot" || nameB == "shot"
        let oneNodeIsSpaceShip = nameA == "spaceship" || nameB == "spaceship"
        let oneNodeIsMeteorite = nameA == "meteorite" || nameB == "meteorite"
        let oneNodeIsPowerUp = nameA == "powerUp" || nameB == "powerUp"

        if oneNodeIsEnemy && oneNodeIsShot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()

            self.currentScore += 1
            self.scoreLabel.text = "SCORE: \(self.currentScore)"

            return
        }

        if oneNodeIsPowerUp && oneNodeIsSpaceShip {

            if nameA == "powerUp" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }

            if self.spaceship.upgradeLevel < 2 {
                self.spaceship.upgradeLevel += 1
                self.spaceship.refreshTexture()
            }

            return
        }

        if oneNodeIsEnemy && oneNodeIsSpaceShip {

            if nameA == "enemy" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }

            if self.spaceship.upgradeLevel < 2 {
                self.spaceship.lifes -= 1
                self.lifesLabel.text = "LIFES: \(self.spaceship.lifes)"
            }

            if self.spaceship.lifes <= 0 {
                self.gameOver = true
                self.clearEverything()
                self.createGameOverStats()
            }

            if self.spaceship.upgradeLevel > 0 {
                self.spaceship.upgradeLevel -= 1
                self.spaceship.refreshTexture()
            }

            return
        }

        if oneNodeIsMeteorite && oneNodeIsSpaceShip {
            if nameA == "meteorite" {
                nodeA.removeFromParent()
            } else {
                nodeB.removeFromParent()
            }

            if self.spaceship.upgradeLevel < 2 {
                self.spaceship.lifes -= 1
                self.lifesLabel.text = "LIFES: \(self.spaceship.lifes)"
            }

            if self.spaceship.lifes <= 0 {
                self.gameOver = true
                self.clearEverything()
                self.createGameOverStats()
            }

            if self.spaceship.upgradeLevel > 0 {
                self.spaceship.upgradeLevel -= 1
                self.spaceship.refreshTexture()
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
    // swiftlint:enable cyclomatic_complexity
}
