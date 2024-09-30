//
//  Repository.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//

import Foundation

class Repository {
    
    enum HTTPError: Error {
        case invalidURL, fetchFailed
        
        var message: String {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .fetchFailed: return "Error fetching data"
            }
        }
    }
    
    func getArtpiecesIds(searchTerm: String) async throws -> ArtIds {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/search?q=\(searchTerm)&hasImages=true"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let artPiecesIds = try JSONDecoder().decode(ArtIds.self, from: data)
        return artPiecesIds
    }
    
    func getArtPieceDetails(by id: Int) async throws -> ArtPiece {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
       
        guard !data.isEmpty else {
            throw HTTPError.fetchFailed
        }

        let artPiece = try JSONDecoder().decode(ArtPiece.self, from: data)
        return artPiece
    }
}
