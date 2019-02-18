/**
* Copyright (c) 2016 Razeware LLC
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
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import GameplayKit
import SpriteKit

class GameScene: SKScene {
	// MARK: - Properties
	
	var boardNode: SKSpriteNode!
	var informationLabel: SKLabelNode!
	var gamePieceNodes = [SKNode]()
	
	var board = Board()
	var strategist: Strategist!
	
	// MARK: - Scene Loading
	
	override func didMove(to view: SKView) {
		super.didMove(to: view)
		
		anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		let backgroundNode = SKSpriteNode(imageNamed: "wood-bg")
		addChild(backgroundNode)
		
		let boardWidth = view.frame.width - 24
		let borderHeight = ((view.frame.height - boardWidth) / 2) - 24
		
		boardNode = SKSpriteNode(
			texture: SKTexture(imageNamed: "board"),
			size: CGSize(width: boardWidth, height: boardWidth)
		)
		boardNode.position.y = -(view.frame.height / 2) + ((view.frame.height - borderHeight) / 2)
		addChild(boardNode)
		
		let headerNode = SKSpriteNode(
			color: UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1),
			size: CGSize(width: view.frame.width, height: borderHeight)
		)
		headerNode.alpha = 0.65
		headerNode.position.y = (view.frame.height / 2) - (borderHeight / 2)
		addChild(headerNode)
		
		informationLabel = SKLabelNode(fontNamed: "HandDrawnShapes")
		informationLabel.fontSize = UIDevice.current.userInterfaceIdiom == .pad ? 63 : 40
		informationLabel.fontColor = .white
		informationLabel.position = headerNode.position
		informationLabel.verticalAlignmentMode = .center
		addChild(informationLabel)
		
		strategist = Strategist(board: board)
		
		resetGame()
		updateGame()
	}
	
	// MARK: - Game Logic
	
	fileprivate func resetGame() {
		let actions = [
			SKAction.scale(to: 0, duration: 0.25),
			SKAction.customAction(withDuration: 0.5, actionBlock: { node, _ in
				node.removeFromParent()
			}),
			]
		gamePieceNodes.forEach { node in
			node.run(SKAction.sequence(actions))
		}
		gamePieceNodes.removeAll()
		
		board = Board()
		strategist.board = board
	}
	
	fileprivate func updateGame() {
		var gameOverTitle: String?
		
		if let winner = board.winningPlayer, winner == board.currentPlayer {
			gameOverTitle = "\(winner.name) Wins!"
		} else if board.isFull {
			gameOverTitle = "Draw"
		}
		
		if gameOverTitle != nil {
			let alert = UIAlertController(title: gameOverTitle, message: nil, preferredStyle: .alert)
			let alertAction = UIAlertAction(title: "Play Again", style: .default) { _ in
				self.resetGame()
				self.updateGame()
			}
			
			alert.addAction(alertAction)
			view?.window?.rootViewController?.present(alert, animated: true)
			
			return
		}
		
		if board.currentPlayer.value == .brain {
			processAIMove()
		}
		
		board.currentPlayer = board.currentPlayer.opponent
		informationLabel.text = "\(board.currentPlayer.name)'s Turn"
	}
	
	fileprivate func updateBoard(with x: Int, y: Int) {
		guard board[x, y] == .empty else { return }
		
		board[x, y] = board.currentPlayer.value
		let sizeValue = boardNode.size.width / 3 - 20
		let spriteSize = CGSize(
			width: sizeValue,
			height: sizeValue
		)
		
		var nodeImageName: String
		
		if board.currentPlayer.value == .zombie {
			nodeImageName = "zombie-head"
		} else {
			nodeImageName = "brain"
		}
		
		let pieceNode = SKSpriteNode(imageNamed: nodeImageName)
		pieceNode.size = CGSize(
			width: spriteSize.width / 2,
			height: spriteSize.height / 2
		)
		pieceNode.position = position(for: CGPoint(x: x, y: y))
		addChild(pieceNode)
		
		gamePieceNodes.append(pieceNode)
		
		pieceNode.run(SKAction.scale(by: 2, duration: 0.25))
		
		updateGame()
	}
	
	fileprivate func position(for boardCoordinate: CGPoint) -> CGPoint {
		let boardWidth = boardNode.size.width
		let halfThirdOfBoard = (boardWidth / 3) / 2
		
		var xPosition: CGFloat = 0
		var yPosition: CGFloat = 0
		
		if boardCoordinate.x == 0 {
			xPosition = -((boardWidth / 2) - halfThirdOfBoard)
		} else if boardCoordinate.x == 1 {
			xPosition = 0
		} else if boardCoordinate.x == 2 {
			xPosition = (boardWidth / 2) - halfThirdOfBoard
		}
		
		if boardCoordinate.y == 0 {
			yPosition = (boardWidth / 2) - halfThirdOfBoard
		} else if boardCoordinate.y == 1 {
			yPosition = 0
		} else if boardCoordinate.y == 2 {
			yPosition = -((boardWidth / 2) - halfThirdOfBoard)
		}
		
		return CGPoint(x: xPosition, y: yPosition + boardNode.position.y)
	}
	
	fileprivate func processAIMove() {
		// 1
		DispatchQueue.global().async { [unowned self] in
			// 2
			let strategistTime = CFAbsoluteTimeGetCurrent()
			guard let bestCoordinate = self.strategist.bestCoordinate else {
				return
			}
			// 3
			let delta = CFAbsoluteTimeGetCurrent() - strategistTime
			
			let aiTimeCeiling = 0.75
			// 4
			let delay = max(delta, aiTimeCeiling)
			
			// 5
			DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
				self.updateBoard(with: Int(bestCoordinate.x), y: Int(bestCoordinate.y))
			}
		}
	}
	
	// MARK: - Touches
	
	fileprivate func processTouchOnBoard(touch: UITouch) {
		let locationInBoard = touch.location(in: boardNode)
		let halfThirdOfBoard = (boardNode.size.width / 3) / 2
		
		var boardCoordinate: CGPoint = .zero
		
		if locationInBoard.x > halfThirdOfBoard {
			boardCoordinate.x = 2
		} else if locationInBoard.x < -halfThirdOfBoard {
			boardCoordinate.x = 0
		} else {
			boardCoordinate.x = 1
		}
		
		if locationInBoard.y > halfThirdOfBoard {
			boardCoordinate.y = 0
		} else if locationInBoard.y < -halfThirdOfBoard {
			boardCoordinate.y = 2
		} else {
			boardCoordinate.y = 1
		}
		
		updateBoard(with: Int(boardCoordinate.x), y: Int(boardCoordinate.y))
	}
	
	fileprivate func handleTouchEnd(_ touches: Set<UITouch>, with _: UIEvent?) {
		guard board.currentPlayer.value != .zombie else {
			return
		}
		
		for touch in touches {
			for node in nodes(at: touch.location(in: self)) {
				if node == boardNode {
					processTouchOnBoard(touch: touch)
				}
			}
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		
		handleTouchEnd(touches, with: event)
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		
		handleTouchEnd(touches, with: event)
	}
}
