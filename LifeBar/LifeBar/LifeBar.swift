//
//  LifeBar.swift
//  LifeBar
//
//  Created by Jully Nobre on 28/02/19.
//  Copyright © 2019 Jully Nobre. All rights reserved.
//

import Foundation
import SpriteKit

class LifeBar: SKNode{
	private var redLifeBar: SKShapeNode!
	private var greenLifeBar: SKShapeNode!
	
	var maxPoints: CGFloat!
	
	init(width: CGFloat, position: CGPoint, maxPoints: CGFloat) {
		super.init()
		
		self.maxPoints = maxPoints
		
		redLifeBar = SKShapeNode(rectOf: CGSize(width: width, height: 20.0))
		redLifeBar.position = position
		redLifeBar.fillColor = .red
		redLifeBar.lineWidth = 0
		addChild(redLifeBar)
		
		greenLifeBar = SKShapeNode(rectOf: CGSize(width: width, height: 20.0))
		greenLifeBar.position = position
		greenLifeBar.fillColor = .green
		greenLifeBar.lineWidth = 0
		addChild(greenLifeBar)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateLifeBar(lifePoints: CGFloat) {
		let lastPosition = greenLifeBar.position.x
		let lastWidth = greenLifeBar.frame.width
		let lostLife = CGFloat(self.redLifeBar.frame.width - (self.redLifeBar.frame.width / maxPoints!) * lifePoints)
		
		greenLifeBar.removeFromParent()
		greenLifeBar = SKShapeNode(rectOf: CGSize(width: lastWidth - lostLife, height: 20.0))
		greenLifeBar.position.x = lastPosition - lostLife/2
		greenLifeBar.position.y = redLifeBar.position.y
		greenLifeBar.fillColor = .green
		greenLifeBar.lineWidth = 0
		
		addChild(greenLifeBar)
	}
}
