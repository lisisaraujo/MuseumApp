//
//  FavoritesView.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 01.10.24.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject
    private var favoritesViewModel: FavoritesViewModel


    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                List(favoritesViewModel.favArtPieces) { artPiece in
                    NavigationLink(destination: ArtPieceDetailView(artPiece: artPiece)) {
                        ArtPieceListItemView(imageURL: artPiece.primaryImage, title: artPiece.title, author: artPiece.author)
                    }
                    .swipeActions(edge: .leading) {
                        
                        if favoritesViewModel.favArtPieces.contains(where: { $0.id == artPiece.id }) {
                            Button("Remove from Favorites") {
                                Task {
                                    try await favoritesViewModel.removeFromFav(artID: artPiece.id)
                                    
                                }
                            }
                            .tint(.gray)
                        } else {
                            
                            Button("Add to Favorites") {
                                Task {
                                    
                                    try await favoritesViewModel.addToFav(artID: artPiece.id)
                                    
                                }
                            }
                            .tint(.pink)
                        }
                    }
                }
            }
            .navigationTitle("Art Pieces")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
