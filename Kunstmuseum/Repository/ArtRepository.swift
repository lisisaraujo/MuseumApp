//
//  ArtRepository.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 02.10.24.
//

import SwiftUI

protocol ArtRepository{
    
    func getArtpiecesIds(searchTerm: String) async throws -> ArtIds
    
    func getArtPieceDetails(by id: Int) async throws -> ArtPiece 
  
}


