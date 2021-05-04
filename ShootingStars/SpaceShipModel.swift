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

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: <#T##SKTexture?#>, color: <#T##UIColor#>, size: <#T##CGSize#>)
        self.upgradeLevel = 0
        self.lifes = 3
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
