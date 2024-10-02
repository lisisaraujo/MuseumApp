import SwiftUI

import SwiftUI

enum Tab {
    case home, favorites
}

struct ContentView: View {
    @EnvironmentObject var artViewModel: ArtViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ArtPiecesView()
                    .tabItem {
                        Label("Home", systemImage: "paintpalette.fill")
                    }
                    .tag(Tab.home)
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                    .tag(Tab.favorites)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(FavoritesViewModel())
        .environmentObject(ArtViewModel(repository: ArtRemoteRepository()))
}


