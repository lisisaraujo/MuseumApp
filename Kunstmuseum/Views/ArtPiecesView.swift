//
//  ArtPiecesView.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//


import SwiftUI

struct ArtPiecesView: View {
    
    
    @State private var searchTerm: String = ""
    
    @EnvironmentObject private var artViewModel: ArtViewModel
    
    @EnvironmentObject
    private var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // seearch
                TextField("Search for art pieces", text: $searchTerm)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    Task {
                        do {
                            _ = try await artViewModel.getListOfArtPieces(searchTerm: searchTerm)
                        } catch {
                            print("Error fetching art pieces: \(error.localizedDescription)")
                        }
                    }
                }) {
                    Text("Search")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List(artViewModel.artPieces) { artPiece in
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
                }            }
            .navigationTitle("Art Pieces")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {

    ArtPiecesView()
        .environmentObject(FavoritesViewModel())
        .environmentObject(ArtViewModel(repository: ArtMockRepository()))
    
}
