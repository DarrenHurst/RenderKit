//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-05.
//

import Foundation
import SwiftUI

struct Sections:  Identifiable {
    var id: Int
    var title: String
    var view: any View
    
    static func == (lhs: Sections, rhs: Sections) -> Bool {
        lhs.id == rhs.id
    }
    
}
@available(iOS 16.0, *)
struct SegmentedControl: View {
    @ObservedObject var data: SampleData
    let theme = Config().currentTheme
    var shape: (any Shape)? = Config(Basic()).buttonShape
    @State var sections: [Sections]
    
    var body: some View {
        VStack {
            GeometryReader { r in
                HStack {
                    ForEach(sections) { control in
                        // let width modifiers
                        
                        let button = RenderButton(id: UUID(), text: control.title, width: r.size.width / CGFloat(sections.count)+10) {
                            
                            self.data.segmentedControlView = self.sections[control.id].view
                        }
                            .frame(width: r.size.width / CGFloat(sections.count))
                            
                        button
                    }
                }
                .frame(width: r.size.width-10, height:50)
                .background(shape?
                    .stroke(style: StrokeStyle(lineWidth: 4.0)).anyView)
                .mask(shape?.anyView)
                .onAppear() {
                    data.segmentedControlView = self.sections[0].view
                }
                .offset(y:20)
            }.frame(height: 60, alignment: .top).offset(x:4)
            
            SegmentedControlView(data: data).frame(alignment: .top).offset(y:20)
            //   }
        } 
    
    }
}

struct SegmentedControlView: View {
    @ObservedObject var data: SampleData
    var body: some View {
        VStack {
            data.segmentedControlView.anyView
        }.frame(idealHeight: 400)
    }
}
@available(iOS 16.0, *)
struct SegmentedControlTestPreview : PreviewProvider {
    static var sections = [
        Sections(id:0, title: "Left", view: HeaderView()),
        Sections(id:1, title: "Middle", view: WelcomeText(data: SampleData())),
        Sections(id:2, title: "Right", view: MapView(location: Location()))
    ]
    
    static var previews: some View {
        VStack {
            SegmentedControl(data: SampleData(),shape: Rectangle(), sections: sections)
                .frame(idealHeight:400)
            SegmentedControl(data: SampleData(),shape: RoundedRectangle(cornerSize: CGSize(width: 15.0, height: 15.0)), sections: sections)
                .frame(idealHeight:400)
            // Circle should be invalid
             SegmentedControl(data: SampleData(),shape: Capsule(), sections: sections)
                .frame(idealHeight:400)
        }
    }
}
