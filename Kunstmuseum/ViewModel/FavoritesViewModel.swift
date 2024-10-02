//
//  FavoritesViewModel.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 01.10.24.
//

import SwiftUI

@MainActor
class FavoritesViewModel: ObservableObject {
    
    
    enum HTTPError: Error {
        case invalidURL, fetchFailed
        
        var message: String {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .fetchFailed: return "Error fetching data"
            }
        }
    }
    
    @Published var favArtPieces: [ArtPiece] = []
    
    private let repository = ArtRemoteRepository()
    
    
    
    func getFavArtPieces() async throws -> [ArtPiece] {
        return favArtPieces
    }
    
    
    func addToFav(artID: Int) async throws -> ArtPiece {
        let selectedArt: ArtPiece = try await repository.getArtPieceDetails(by: artID)
    
        favArtPieces.append(selectedArt)
        
        return selectedArt
    }
    
    func removeFromFav(artID: Int) async throws -> ArtPiece {
        
        let selectedArt: ArtPiece = try await repository.getArtPieceDetails(by: artID)
        if let index = favArtPieces.firstIndex(where: { $0.id == artID }) {
        favArtPieces.remove(at: index)
        } else {
            throw HTTPError.fetchFailed
        }
        
        return selectedArt
    }
}
