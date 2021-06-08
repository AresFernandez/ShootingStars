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
        let oneNodeIsPowerUp = nameA == "powerUp" || nameB == "powerUp"

        if oneNodeIsEnemy && oneNodeIsShot {
            createExplosion(at: nodeA.position)
            nodeA.removeFromParent()
            nodeB.removeFromParent()

            killEnemy()

            return
        }

        if oneNodeIsPowerUp && oneNodeIsSpaceShip {

            removeNodeByName(nodeA: nodeA, nodeB: nodeB, name: "powerUp")

            pickPowerUp()

            return
        }

        if oneNodeIsEnemy && oneNodeIsSpaceShip {
            createExplosion(at: nodeA.position)
            removeNodeByName(nodeA: nodeA, nodeB: nodeB, name: "enemy")

            enemyCollidedPlayer()

            return
        }

        if oneNodeIsMeteorite && oneNodeIsSpaceShip {
            createExplosion(at: nodeA.position)
            removeNodeByName(nodeA: nodeA, nodeB: nodeB, name: "meteorite")

            enemyCollidedPlayer()

            return
        }

        if oneNodeIsShot && oneNodeIsMeteorite {
            removeNodeByName(nodeA: nodeA, nodeB: nodeB, name: "shot")
            return
        }

        if oneNodeIsMeteorite && oneNodeIsEnemy {
            if nodeA.name == "enemy" {
                createExplosion(at: nodeA.position)
            } else {
                createExplosion(at: nodeB.position)
            }

            removeNodeByName(nodeA: nodeA, nodeB: nodeB, name: "enemy")
            return
        }
    }

    func killEnemy() {
        self.currentScore += 1
        self.scoreLabel.text = "SCORE: \(self.currentScore)"
    }

    func pickPowerUp() {
        if self.spaceship.upgradeLevel < 2 {
            self.spaceship.upgradeLevel += 1
            self.spaceship.refreshTexture()
        } else {
            self.spaceship.shotCadency *= 0.8
            if self.spaceship.shotCadency < 0.2 {
                self.spaceship.shotCadency = 0.2
            }
        }
    }

    func enemyCollidedPlayer() {
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
    }

    func removeNodeByName(nodeA: SKNode, nodeB: SKNode, name: String) {
        if nodeA.name == name {
            nodeA.removeFromParent()
        } else {
            nodeB.removeFromParent()
        }
    }
}
