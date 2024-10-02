//
//  ArtPieceDetailsView.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//

import SwiftUI

struct ArtPieceDetailView: View {
    @EnvironmentObject
    private var favoritesViewModel: FavoritesViewModel
    let artPiece: ArtPiece?
    
    // State variable to track if the art piece is a favorite
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // image
                    AsyncImage(url: URL(string: artPiece?.primaryImage ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                                .padding(.horizontal)
                            
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                                .padding(.horizontal)
                            
                        case .empty:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    // title and Author
                    VStack(alignment: .leading, spacing: 8) {
                        Text(artPiece?.title ?? "Unknown Title")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text(artPiece?.author ?? "Unknown Artist")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Divider()
                            .background(Color.gray.opacity(0.5))
                        
                        Text("Accession Year: \(artPiece?.accessionYear ?? "N/A")")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Text("Department: \(artPiece?.department ?? "N/A")")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                }
                .padding(.vertical, 16)
            }
            .navigationTitle(artPiece?.title ?? "Details")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: toggleFavorite) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? Color.red : Color.primary)
                    }
                }
            }
            // check if the art piece is a favorite when the view appears
            .onAppear {
                if let artID = artPiece?.id {
                    isFavorite = favoritesViewModel.favArtPieces.contains(where: { $0.id == artID })
                }
            }
        }
    }

    private func toggleFavorite() {
        guard let artID = artPiece?.id else { return }

        Task {
            do {
                if isFavorite {
                    try await favoritesViewModel.removeFromFav(artID: artID)
                } else {
                    try await favoritesViewModel.addToFav(artID: artID)
                }
                isFavorite.toggle()
            } catch {
                print("Error toggling favorite status: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ArtPieceDetailView(artPiece: ArtPiece(
        id: 12345,
        isHighlight: true,
        accessionYear: "1889",
        primaryImage: "https://example.com/images/primary.jpg",
        primaryImageSmall: "https://example.com/images/primary_small.jpg",
        additionalImages: [
            "https://example.com/images/additional1.jpg",
            "https://example.com/images/additional2.jpg"
        ],
        department: "European Paintings",
        objectName: "Painting",
        title: "Starry Night",
        period: "Post-Impressionism",
        author: "Lexi",
        country: "Germany"
    )).environmentObject(FavoritesViewModel())
}
