//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-27.
//

import Foundation
import SwiftUI

struct ImageSlider: View {
@ObservedObject var data = SampleData()
    
    var body: some View {
        
        let x = 20
        let y = 20
        let posters:[MoviePoster] = data.moviePosters
        
        
        return
           
           
               GeometryReader { r in
                 
                   ScrollView(.horizontal){
                           HStack {
                               ForEach(posters) { movie in
                                   AsyncImage(url: URL(string: movie.poster)) {  phase in
                                       if let image = phase.image {
                                           image.resizable()
                                               .frame(width:r.size.width, height: r.size.height)
                                               .padding(.bottom,20)
                                           
                                           
                                               .onTapGesture {
                                               } // Displays the loaded image.
                                           
                                       } else if phase.error != nil {
                                           EmptyView()
                                       } else {
                                           Color.gray.opacity(0.3) // Acts as a placeholder.
                                       }
                                       
                                   } .frame(width:r.size.width, height: r.size.height)
                               }
                           }
                       
                   }
                   
                       .frame(width: r.size.width, height: r.size.height )
                       
                       
                   }
               }
}


struct PreviewImageSlider: PreviewProvider {
    static var previews: some View {
        ImageSlider()
    }
}
