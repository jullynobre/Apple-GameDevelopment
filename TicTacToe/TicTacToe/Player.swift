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

class Player: NSObject, GKGameModelPlayer {
    
    enum Value: Int {
    case empty
    case brain
    case zombie

    var name: String {
        switch self {
            case .empty:
            return ""

            case .brain:
            return "Brain"

            case .zombie:
            return "Zombie"
        }
    }
    }
    
    var playerId: Int
    var value: Value
    var name: String

    static var allPlayers = [
        Player(.brain),
        Player(.zombie)
    ]

    var opponent: Player {
        if value == .zombie {
          return Player.allPlayers[0]
        } else {
          return Player.allPlayers[1]
        }
    }

    init(_ value: Value) {
        self.value = value
        name = value.name
        
        playerId = value.rawValue
    }

}
