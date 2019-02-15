//
//  Settings.swift
//  ColorSwitch
//
//  Created by Jully Nobre on 15/02/19.
//  Copyright © 2019 Jully Nobre. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1           // 1
    static let switchCategory: UInt32 = 0x1 << 1    // 10
}
