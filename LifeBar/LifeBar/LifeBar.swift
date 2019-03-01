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
	var points: CGFloat!
	
	var reducedPtsPerSecond: CGFloat = 0
	var timer = Timer()
	
	init(width: CGFloat, position: CGPoint, maxPoints: CGFloat, reducedPtsPerSecond: CGFloat = 0) {
		super.init()
		
		self.maxPoints = maxPoints
		self.points = self.maxPoints
		
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
		
		if reducedPtsPerSecond > 0 {
			self.reducedPtsPerSecond = reducedPtsPerSecond
			
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LifeBar.processTimer), userInfo: nil, repeats: true)
		}
		
	}
	
	@objc func processTimer() {
		if self.points != 0 {
			let newPontuation = self.points - reducedPtsPerSecond
			
			print("Update pontiation \(newPontuation)")
			
			updateLifeBar(lifePoints: newPontuation <= 0 ? 0 : newPontuation)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateLifeBar(lifePoints: CGFloat) {
		self.points = lifePoints
		
		let lostLife = CGFloat(self.redLifeBar.frame.width - (self.redLifeBar.frame.width / maxPoints!) * lifePoints)
		
		greenLifeBar.removeFromParent()
		greenLifeBar = SKShapeNode(rectOf: CGSize(width: redLifeBar.frame.width - lostLife, height: 20.0))
		greenLifeBar.position.x = redLifeBar.position.x - lostLife/2
		greenLifeBar.position.y = redLifeBar.position.y
		greenLifeBar.fillColor = .green
		greenLifeBar.lineWidth = 0
		
		addChild(greenLifeBar)
	}
}
