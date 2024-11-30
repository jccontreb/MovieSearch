//
//  TabBarView.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - TabBarView

struct TabBarView: View {
    
    // MARK: - Properties
    
    var body: some View {
        TabView {
            ForEach(TabBarItem.allCases, id: \.self) { tabBarItem in
                tabBarItem.contentView
                    .tabItem { tabBarItem.label }
            }
        }
    }
    
}

// MARK: - TabBarItem

enum TabBarItem: Hashable, CaseIterable {
    
    // MARK: - Cases
    
    case home
    case favorites
    
    // MARK: - Properties
    
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .home:
            MovieList()
        case .favorites:
            FavoritesList()
        }
    }
    
    var label: some View {
        switch self {
        case .home:
            Label("Movie Search", systemImage: "magnifyingglass")
        case .favorites:
            Label("Favorites", systemImage: "heart")
        }
    }
    
}

// MARK: - Preview

#Preview {
    TabBarView()
}
