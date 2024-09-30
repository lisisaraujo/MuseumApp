//
//  ArtPiecesView.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//


import SwiftUI

struct ArtPiecesView: View {
    
    @StateObject private var viewModel = ArtViewModel()
    @State private var searchTerm: String = ""
    
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
                            _ = try await viewModel.getListOfArtPieces(searchTerm: searchTerm)
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
                
                List(viewModel.artPieces) { artPiece in
                    NavigationLink(destination: ArtPieceDetailView(artPiece: artPiece)) {
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: artPiece.primaryImage)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(radius: 4)

                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(radius: 4)

                                case .empty:
                                    ProgressView()
                                        .frame(width: 80, height: 80)

                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(artPiece.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Text(artPiece.author)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Art Pieces")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ArtPiecesView()
}
