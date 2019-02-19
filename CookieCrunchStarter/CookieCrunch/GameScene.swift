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
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder) is not used in this app")
	}
	
	override init(size: CGSize) {
		super.init(size: size)
		
		anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		let background = SKSpriteNode(imageNamed: "Background")
		background.size = size
		addChild(background)
		
	}
	
}


