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
        // let oneNodeIsSpaceShip = nameA == "spaceship" || nameB == "spaceship"

        if oneNodeIsEnemy && oneNodeIsShot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()

            self.currentScore += 1
            self.scoreLabel.text = "SCORE: \(self.currentScore)"

            // run(self.boomSound)

            return
        }
    }
}
