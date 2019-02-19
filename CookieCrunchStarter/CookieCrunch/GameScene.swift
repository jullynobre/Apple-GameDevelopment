/**
* GameScene.swift
* CookieCrunch
* Copyright (c) 2017 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
* distribute, sublicense, create a derivative work, and/or sell copies of the
* Software in any work that is designed, intended, or marketed for pedagogical or
* instructional purposes related to programming, coding, application development,
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works,
* or sale is expressly withheld.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	// Sound FX
	let swapSound = SKAction.playSoundFileNamed("Chomp.wav", waitForCompletion: false)
	let invalidSwapSound = SKAction.playSoundFileNamed("Error.wav", waitForCompletion: false)
	let matchSound = SKAction.playSoundFileNamed("Ka-Ching.wav", waitForCompletion: false)
	let fallingCookieSound = SKAction.playSoundFileNamed("Scrape.wav", waitForCompletion: false)
	let addCookieSound = SKAction.playSoundFileNamed("Drip.wav", waitForCompletion: false)
	
	var level: Level!
	
	let tileWidth: CGFloat = 32.0
	let tileHeight: CGFloat = 36.0
	
	let gameLayer = SKNode()
	let cookiesLayer = SKNode()
	
	let tilesLayer = SKNode()
	let cropLayer = SKCropNode()
	let maskLayer = SKNode()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder) is not used in this app")
	}
	
	override init(size: CGSize) {
		super.init(size: size)
		
		anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		let background = SKSpriteNode(imageNamed: "Background")
		background.size = size
		addChild(background)
		
		addChild(gameLayer)
		
		let layerPosition = CGPoint(
			x: -tileWidth * CGFloat(numColumns) / 2,
			y: -tileHeight * CGFloat(numRows) / 2)
		
		tilesLayer.position = layerPosition
		maskLayer.position = layerPosition
		cropLayer.maskNode = maskLayer
		gameLayer.addChild(tilesLayer)
		gameLayer.addChild(cropLayer)
		
		cookiesLayer.position = layerPosition
		cropLayer.addChild(cookiesLayer)
	}
	
	func addTiles() {
		// 1
		for row in 0..<numRows {
			for column in 0..<numColumns {
				if level.tileAt(column: column, row: row) != nil {
					let tileNode = SKSpriteNode(imageNamed: "MaskTile")
					tileNode.size = CGSize(width: tileWidth, height: tileHeight)
					tileNode.position = pointFor(column: column, row: row)
					maskLayer.addChild(tileNode)
				}
			}
		}
		
		
		for row in 0...numRows {
			for column in 0...numColumns {
				let topLeft     = (column > 0) && (row < numRows)
					&& level.tileAt(column: column - 1, row: row) != nil
				let bottomLeft  = (column > 0) && (row > 0)
					&& level.tileAt(column: column - 1, row: row - 1) != nil
				let topRight    = (column < numColumns) && (row < numRows)
					&& level.tileAt(column: column, row: row) != nil
				let bottomRight = (column < numColumns) && (row > 0)
					&& level.tileAt(column: column, row: row - 1) != nil
				
				var value = (topLeft ? 1 : 0)
				value = value | (topRight ? 1 : 0) << 1
				value = value | (bottomLeft ? 1 : 0) << 2
				value = value | (bottomRight ? 1 : 0) << 3
				
				// Values 0 (no tiles), 6 and 9 (two opposite tiles) are not drawn.
				if value != 0 && value != 6 && value != 9 {
					let name = String(format: "Tile_%ld", value)
					
					let tileNode = SKSpriteNode(imageNamed: name)
					tileNode.size = CGSize(width: tileWidth, height: tileHeight)
					var point = pointFor(column: column, row: row)
					point.x -= tileWidth / 2
					point.y -= tileHeight / 2
					tileNode.position = point
					tilesLayer.addChild(tileNode)
				}
			}
		}
	}
	
	func addSprites(for cookies: Set<Cookie>) {
		for cookie in cookies {
			let sprite = SKSpriteNode(imageNamed: cookie.cookieType.spriteName)
			sprite.size = CGSize(width: tileWidth, height: tileHeight)
			sprite.position = pointFor(column: cookie.column, row: cookie.row)
			cookiesLayer.addChild(sprite)
			cookie.sprite = sprite
		}
	}
	
	private func pointFor(column: Int, row: Int) -> CGPoint {
		return CGPoint(
			x: CGFloat(column) * tileWidth + tileWidth / 2,
			y: CGFloat(row) * tileHeight + tileHeight / 2)
	}
	
}


