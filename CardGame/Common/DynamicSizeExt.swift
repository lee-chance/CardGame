//
//  DynamicSizeExt.swift
//  CardGame
//
//  Created by Changsu Lee on 2021/09/09.
//

import UIKit

let STANDARD_IPHONE_WIDTH: CGFloat = 375
let SCREEN_WIDTH_RADIO: CGFloat = UIScreen.main.bounds.width / STANDARD_IPHONE_WIDTH

extension Double {
    var ratioConstant: CGFloat { return  CGFloat(self) * SCREEN_WIDTH_RADIO }
}
extension CGFloat {
    var ratioConstant: CGFloat { return  self * SCREEN_WIDTH_RADIO }
}
extension Int {
    var ratioConstant: CGFloat { return  CGFloat(self) * SCREEN_WIDTH_RADIO }
}
