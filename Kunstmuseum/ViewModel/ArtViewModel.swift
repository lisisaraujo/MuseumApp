//
//  ArtViewModel.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//

import SwiftUI

@MainActor
class ArtViewModel: ObservableObject {
    
    @Published var artPieces: [ArtPiece] = []
    
    private let repository = Repository()
    
    func getListOfArtPieces(searchTerm: String) async throws -> [ArtPiece] {
        let artPiecesIds = try await repository.getArtpiecesIds(searchTerm: searchTerm).objectIDs
        
        for id in artPiecesIds {
            do {
                let artPiece = try await repository.getArtPieceDetails(by: id)
                artPieces.append(artPiece)
            } catch {
                print("Failed to fetch details for ID \(id): \(error.localizedDescription)")
            }
        }
        
        return artPieces
    }
}
