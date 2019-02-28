//
//  GameScene.swift
//  LifeBar
//
//  Created by Jully Nobre on 28/02/19.
//  Copyright © 2019 Jully Nobre. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {
		let lifeBar = LifeBar(width: 500, position: CGPoint(x: 0.0, y: 0.0), maxPoints: 10)
		
		addChild(lifeBar)
		
		lifeBar.updateLifeBar(lifePoints: 3)
    }
    
}
