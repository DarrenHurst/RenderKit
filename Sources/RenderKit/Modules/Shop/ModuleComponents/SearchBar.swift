import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct SearchBar: View {
    @StateObject var data : SampleData
    var selectedRow: Item
    
    let theme = Config().currentTheme
    
    var body: some View {
        VStack {
            GeometryReader { r in
                ZStack {
                    ImageScroll()
                }
                ZStack (alignment: .top) {
                   
                        HStack {
                            Image(systemName: "magnifyingglass.circle")
                                .padding(20)
                                .foregroundColor(Color.white)
                            
                            TextField("", text: $data.searchText, onCommit: {
                                
                            })
                            .onAppear() {
                                data.searchText = ""
                            }
                            .onTapGesture(perform: {
                                data.searchText = ""
                            })
                            .foregroundColor(Color.white)
                        }
                        .background(theme.buttonShape
                            .stroke(Color.black.opacity(0.4), lineWidth: theme.borderWidth)
                            .padding(10).anyView
                        )
                        .background(theme.buttonShape
                            .fill(Color.white.opacity(0.1))
                            .padding(10).anyView
                        ).frame(alignment:.top)
                        
                    
                }.padding(10).offset(y:5)
            }
        }
    }
}
