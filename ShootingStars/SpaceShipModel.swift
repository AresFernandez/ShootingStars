//
//  SpaceShipModel.swift
//  ShootingStars
//
//  Created by Alumne on 4/5/21.
//

import Foundation
import SpriteKit

class SpaceShip: SKSpriteNode {
    var upgradeLevel: Int
    var lifes: Int
    var shotCadency: Double

    init(texture: SKTexture?, color: UIColor, size: CGSize, upgradeLevel: Int, lifes: Int, shotCadency: Double) {
        self.upgradeLevel = upgradeLevel
        self.lifes = lifes
        self.shotCadency = shotCadency
        super.init(texture: texture, color: color, size: size)
    }

    func refreshTexture() {
        switch self.upgradeLevel {
        case 0:
            self.texture = SKTexture(imageNamed: "ship1")
        case 1:
            self.texture = SKTexture(imageNamed: "ship2")
        case 2:
            self.texture = SKTexture(imageNamed: "ship3")
        default:
            self.texture = SKTexture(imageNamed: "ship1")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
