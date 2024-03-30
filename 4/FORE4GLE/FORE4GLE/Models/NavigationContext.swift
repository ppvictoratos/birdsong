//
//  NavigationContext.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/29/24.
//

import SwiftUI

@Observable
class NavigationContext {
    var selectedCourseName: String?
    var selectedGolferName: String?
    var selectedGameStamp: String?
    var selectedGolfer: Golfer?
    var selectedGame: Game?
    
    var columnVisibility: NavigationSplitViewVisibility
    
    var sidebarTitle = "Games"
    
    var contentListTitle: String {
        if let selectedGameStamp {
            selectedGameStamp
        } else {
            ""
        }
    }
    
    init(selectedCourseName: String? = nil,
         selectedGolferName: String? = nil,
         selectedGameStamp: String? = nil,
         selectedGolfer: Golfer? = nil,
         selectedGame: Game? = nil,
         selectedGolfers: [Golfer?] = [nil],
         selectedScores: [Score?] = [nil],
         columnVisibility: NavigationSplitViewVisibility = .automatic,
         sidebarTitle: String = "Games") {
        self.selectedCourseName = selectedCourseName
        self.selectedGolferName = selectedGolferName
        self.selectedGameStamp = selectedGameStamp
        self.selectedGolfer = selectedGolfer
        self.columnVisibility = columnVisibility
        self.sidebarTitle = sidebarTitle
    }
}
