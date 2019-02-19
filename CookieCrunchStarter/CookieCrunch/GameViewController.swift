/**
* GameViewController.swift
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

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
	
	// MARK: Properties
	
	// The scene draws the tiles and cookie sprites, and handles swipes.
	var scene: GameScene!
	
	var movesLeft = 0
	var score = 0
	
	lazy var backgroundMusic: AVAudioPlayer? = {
		guard let url = Bundle.main.url(forResource: "Mining by Moonlight", withExtension: "mp3") else {
			return nil
		}
		do {
			let player = try AVAudioPlayer(contentsOf: url)
			player.numberOfLoops = -1
			return player
		} catch {
			return nil
		}
	}()
	
	// MARK: IBOutlets
	@IBOutlet weak var gameOverPanel: UIImageView!
	@IBOutlet weak var targetLabel: UILabel!
	@IBOutlet weak var movesLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var shuffleButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Configure the view
		let skView = view as! SKView
		skView.isMultipleTouchEnabled = false
		
		// Create and configure the scene.
		scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .aspectFill
		
		// Present the scene.
		skView.presentScene(scene)
	}
	
	// MARK: IBActions
	@IBAction func shuffleButtonPressed(_: AnyObject) {
		
	}
	
	// MARK: View Controller Functions
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override var shouldAutorotate: Bool {
		return true
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return [.portrait, .portraitUpsideDown]
	}
	
}
