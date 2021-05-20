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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
