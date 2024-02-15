import Foundation
import SwiftUI

struct Rating: View {
    @State var loadView = false
    var value = 1.8
    var numberOf = 5
    var image = Image(systemName: "star")
    var image2 = Image(systemName: "star")
    var color: Color = .white
    var fillColor: Color = .cyan
    var width: CGFloat = 150.0
    
    var body: some View {
      let ratingView = rating()
      ratingView
    }
    fileprivate func rating() -> some View {
        return ZStack {
            
            let icon = HStack(spacing: 0) {
                ForEach(0..<numberOf, id: \.self) { _ in
                    ZStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                           // .foregroundColor(.black.opacity(0.9))
                        image2
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .foregroundColor(color.opacity(0.9))
                             .background(.clear)
                    }
                }
            }
            // apply ZStack
            icon.overlay(
                GeometryReader { g in
                    let width = value / CGFloat(numberOf) * g.size.width
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(fillColor)
                            .offset(x: loadView ? 0: -500)
                            .animation(.easeIn(duration: 1).speed(1), value: loadView)
                    }
                }
                    .mask(icon)
            ).frame(width: width)
                .onAppear() {
                    loadView.toggle()
                }
        }
    }
}

struct RatingPreview : PreviewProvider {
    //Given
    static var rating = 4.0
    //When
    static var previews: some View {
        VStack {
        //stars with border
        //1
            ZStack {
            Rating(value:rating, image:Image(systemName: "star"), image2: Image(systemName: "star.fill"))
                //.background(.black)
            Rating(value:0, image2: Image(systemName: "star"), color:.black.opacity(0.6))
                //.background(.black)
        }
        
        //star without fill
        //2
        Rating(value:3.6, image2: Image(systemName: "star"), color:.black.opacity(0.6))
        
        //star with fill no border
        //3
        Rating(value:3.6, image2: Image(systemName: "star.fill"), color:.white)
        }
        //Then -> Preview 3 controls
    }
}
