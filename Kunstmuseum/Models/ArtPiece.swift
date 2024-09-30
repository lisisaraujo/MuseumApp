//
//  ArtPiece.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//

import Foundation


struct ArtIds: Codable {
    var objectIDs: [Int]
}


struct ArtPiece: Codable, Identifiable, Equatable {
    var id: Int
    var isHighlight: Bool
    var accessionYear: String
    var primaryImage: String
    var primaryImageSmall: String
    var additionalImages: [String]
    var department: String
    var objectName: String
    var title: String
    var period: String
    var author: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case isHighlight
        case accessionYear
        case primaryImage
        case primaryImageSmall
        case additionalImages
        case department
        case objectName
        case title
        case period
        case author = "creditLine"
        case country
    }
}
