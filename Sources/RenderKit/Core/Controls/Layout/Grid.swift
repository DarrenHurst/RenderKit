//
//  File.swift
//
//
//  Created by Darren Hurst on 2023-11-04.
//  Currently this is just a grid generator, based on data size and defined per row

import Foundation
import SwiftUI

fileprivate extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Array: Identifiable where Element: Hashable {
   public var id: Int { self.hashValue }
}

@available(iOS 16.0, *)
struct RenderGrid : View {
    @ObservedObject var data: SampleData
    var itemPerRow: Int

    let gradient = Gradient(colors: [.yellow, .yellow, .white, .white])
    
    var body: some View {
        let movieset = data.moviePosters.chunked(into: itemPerRow)
 
        GridLayout(alignment: .topLeading, horizontalSpacing: 2.0, verticalSpacing:2.0){
            ForEach(movieset) {  rowdata in
                let movies = rowdata
                GridRow {
                    ForEach (movies) { movie in
                        ViewThatFits  {
                            AsyncImage(url: URL(string: movie.poster)) {  phase in
                                if let image = phase.image {
                                    image.resizable().scaledToFit().onTapGesture() {
                                        data.selectedMovie = movie
                                    } // Displays the loaded image.
                                } else if phase.error != nil {
                                    Text("Error in loading url for id: \(movie.id)")
                                } else {
                                    Color.blue // Acts as a placeholder.
                                }
                            }.mask(RoundedRectangle(cornerRadius: 10.0)).opacity(0.7)
                            
                        }
                        
                    }
                }
            }
        }
        .padding(10)
    }
}

@available(iOS 16.0, *)
struct previewGrid: PreviewProvider {
 
    static var previews: some View {
        RenderGrid(data: SampleData(), itemPerRow:2)
    }
}

