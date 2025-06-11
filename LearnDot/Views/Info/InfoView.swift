//
//  InfoView.swift
//  LearnDot
//
//  Created by 원주연 on 6/11/25.
//

import SwiftUI

struct InfoView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        Button {
            coordinator.push(AppDestination.manual0)
        } label: {
            Text("manual")
        }
    }
}

