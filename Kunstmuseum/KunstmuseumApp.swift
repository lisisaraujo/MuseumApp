import SwiftUI


@main
struct KunstmuseumApp: App {
    @StateObject
    private var favoritesViewModel = FavoritesViewModel()
    
    @StateObject
    private var artViewModel = ArtViewModel(repository: ArtRemoteRepository())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesViewModel)
                .environmentObject(artViewModel)
        }
    }
}

