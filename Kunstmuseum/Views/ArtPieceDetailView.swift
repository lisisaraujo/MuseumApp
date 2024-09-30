//
//  ArtPieceDetailsView.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 30.09.24.
//

import SwiftUI

struct ArtPieceDetailView: View {
    
    
let artPiece: ArtPiece?
    
    var body: some View {
        Text(artPiece?.title ?? "")
        

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
    ))
}
