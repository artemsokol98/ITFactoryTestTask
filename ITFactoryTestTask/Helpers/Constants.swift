//
//  Constants.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 23.01.2023.
//

import UIKit

class Constants {
    static var numberOfSelectedItems = 0
    static let appBackgroundColor = UIColor(red: 244.0/255.0, green: 246.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    static let borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
    static let spaceFromEdge: CGFloat = 15.0
    static let cornerRadius: CGFloat = 20
    static let timeWaitingForLoading: TimeInterval = 10
    
    // MARK: - select item
    
    static let maxNumberSelectedItems = 6
    static let borderWidthWhenItemSelected: CGFloat = 2
    static let borderWidthWhenItemDeselected: CGFloat = 0
    static let numberOfItemsInOneWidthScreen: CGFloat = 2
    
    // MARK: - font size
    static let fontSizeForSection: CGFloat = 20
    static let fontSizeForTitleInCell: CGFloat = 14
}
