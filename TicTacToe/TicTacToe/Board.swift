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

class Board: NSObject {
    var currentPlayer = Player.allPlayers[arc4random() % 2 == 0 ? 0 : 1]

    fileprivate var values: [[Player.Value]] = [
        [.empty, .empty, .empty],
        [.empty, .empty, .empty],
        [.empty, .empty, .empty],
    ]

    subscript(x: Int, y: Int) -> Player.Value {
        get {
            return values[y][x]
        }
        set {
            if values[y][x] == .empty {
                values[y][x] = newValue
            }
        }
    }

    var isFull: Bool {
        for row in values {
            for tile in row {
                if tile == .empty {
                    return false
                }
            }
        }
        return true
    }

    var winningPlayer: Player? {
        for column in 0 ..< values.count {
            if values[column][0] == values[column][1], values[column][0] == values[column][2], values[column][0] != .empty {
                if let index = Player.allPlayers.index(where: { player -> Bool in
                    player.value == values[column][0]
                }) {
                    return Player.allPlayers[index]
                } else {
                    return nil
                }
            } else if values[0][column] == values[1][column], values[0][column] == values[2][column], values[0][column] != .empty {
                if let index = Player.allPlayers.index(where: { player -> Bool in
                    player.value == values[0][column]
                }) {
                    return Player.allPlayers[index]
                } else {
                    return nil
                }
            }
        }

        if values[0][0] == values[1][1], values[0][0] == values[2][2], values[0][0] != .empty {
            if let index = Player.allPlayers.index(where: { player -> Bool in
                player.value == values[0][0]
            }) {
                return Player.allPlayers[index]
            } else {
                return nil
            }
        } else if values[2][0] == values[1][1], values[2][0] == values[0][2], values[0][2] != .empty {
            if let index = Player.allPlayers.index(where: { player -> Bool in
                player.value == values[2][0]
            }) {
                return Player.allPlayers[index]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    func clear() {
        for x in 0 ..< values.count {
            for y in 0 ..< values[x].count {
                self[x, y] = .empty
            }
        }
    }

    func canMove(at position: CGPoint) -> Bool {
        if self[Int(position.x), Int(position.y)] == .empty {
            return true
        } else {
            return false
        }
    }
}
