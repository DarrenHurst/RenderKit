//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-02.
//

import Foundation
import SwiftUI

struct PageControlView : View {
    @StateObject var data: SampleData
    var index: Int = 0
    
    let shapeSize: CGFloat = 10.0
    var body: some View {
        HStack {
            ForEach(data.moviePosters, id: \.self) { movie in
                if movie.id == data.selectedMovieId {
                    ZStack {
                        Capsule().fill(.blue).frame(width:shapeSize + (shapeSize/2), height: shapeSize)
                        Capsule().stroke(.white.opacity(0.7), lineWidth: 2.0).frame(width:shapeSize + (shapeSize/2), height: shapeSize)
                    }
                } else {
                    ZStack {
                        Circle().fill(.gray).frame(width:shapeSize + (shapeSize/2), height: shapeSize)
                        Circle().stroke(.white.opacity(0.4), lineWidth: 2.0).frame(height:shapeSize)
                    }
                }
            }
        }
    }
}
