/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

let numColumns = 9
let numRows = 9

class Level {
	private var cookies = Array2D<Cookie>(columns: numColumns, rows: numRows)
	
	init(filename: String) {
		guard let levelData = LevelData.loadFrom(file: filename) else { return }
		
		let tilesArray = levelData.tiles
		
		for (row, rowArray) in tilesArray.enumerated() {
			let tileRow = numRows - row - 1
			for (column, value) in rowArray.enumerated() {
				if value == 1 {
					tiles[column, tileRow] = Tile()
				}
			}
		}
	}
	
	func cookie(atColumn column: Int, row: Int) -> Cookie? {
		precondition(column >= 0 && column < numColumns)
		precondition(row >= 0 && row < numRows)
		return cookies[column, row]
	}
	
	func shuffle() -> Set<Cookie> {
		return createInitialCookies()
	}
	
	private func createInitialCookies() -> Set<Cookie> {
		var set: Set<Cookie> = []
		
		for row in 0..<numRows {
			for column in 0..<numColumns {
				if tiles[column, row] != nil {
					
					let cookieType = CookieType.random()
					let cookie = Cookie(column: column, row: row, cookieType: cookieType)
					cookies[column, row] = cookie
					
					set.insert(cookie)
				}
			}
		}
		return set
	}
	
	private var tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
	
	func tileAt(column: Int, row: Int) -> Tile? {
		precondition(column >= 0 && column < numColumns)
		precondition(row >= 0 && row < numRows)
		return tiles[column, row]
	}
	

}
