//
//  ArtPieceListItem.swift
//  Kunstmuseum
//
//  Created by Lisis Ruschel on 02.10.24.
//

import SwiftUI

struct ArtPieceListItemView: View {
    
    @State var imageURL: String
    @State var title: String
    @State var author: String
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { phase in
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
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ArtPieceListItemView(imageURL: "", title: "", author: "")
}
