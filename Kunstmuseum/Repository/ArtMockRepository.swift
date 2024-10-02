//
//  ArtMockRepository.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 02.10.24.
//

import Foundation

class ArtMockRepository: ArtRepository {
    
    enum HTTPError: Error {
        case invalidURL, fetchFailed
        
        var message: String {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .fetchFailed: return "Error fetching data"
            }
        }
    }
    

    private let dummyArtIds = ArtIds(objectIDs: [1, 2, 3, 4, 5])
    

    private let dummyArtPieces: [Int: ArtPiece] = [
        1: ArtPiece(id: 1, isHighlight: true, accessionYear: "1900", primaryImage: "https://example.com/image1.jpg", primaryImageSmall: "https://example.com/image1_small.jpg", additionalImages: ["https://example.com/image1_1.jpg"], department: "Paintings", objectName: "Painting", title: "Starry Night", period: "Post-Impressionism", author: "Vincent van Gogh", country: "Netherlands"),
        2: ArtPiece(id: 2, isHighlight: false, accessionYear: "1800", primaryImage: "https://example.com/image2.jpg", primaryImageSmall: "https://example.com/image2_small.jpg", additionalImages: [], department: "Sculpture", objectName: "Sculpture", title: "David", period: "Renaissance", author: "Michelangelo", country: "Italy"),
        3: ArtPiece(id: 3, isHighlight: false, accessionYear: "1700", primaryImage: "https://example.com/image3.jpg", primaryImageSmall: "https://example.com/image3_small.jpg", additionalImages: [], department: "Drawings", objectName: "Drawing", title: "The Last Supper", period: "Renaissance", author: "Leonardo da Vinci", country: "Italy"),
        4: ArtPiece(id: 4, isHighlight: true, accessionYear: "2000", primaryImage: "https://example.com/image4.jpg", primaryImageSmall: "https://example.com/image4_small.jpg", additionalImages: [], department: "Photography", objectName: "Photograph", title: "Moonrise over Hernandez", period: "Modern", author: "Ansel Adams", country: "USA"),
        5: ArtPiece(id: 5, isHighlight: false, accessionYear: "1950", primaryImage: "https://example.com/image5.jpg", primaryImageSmall: "https://example.com/image5_small.jpg", additionalImages: [], department: "Modern Art", objectName: "Painting", title: "Composition VIII", period: "Abstract Art", author: "Wassily Kandinsky", country: "Russia")
    ]
    
    func getArtpiecesIds(searchTerm _: String) async throws -> ArtIds {
        return dummyArtIds
    }
    
    func getArtPieceDetails(by id: Int) async throws -> ArtPiece {
        guard let artPiece = dummyArtPieces[id] else {
            throw HTTPError.fetchFailed
        }
        return artPiece
    }
}
