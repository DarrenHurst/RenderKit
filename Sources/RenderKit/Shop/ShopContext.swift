import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct ShopContext: View {
    @StateObject var data: SampleData
    var body: some View {
        let workflow: [ShopWorkFlow] = [
            ShopWorkFlow(.search),
            ShopWorkFlow(.results)
        ]
        RenderTableWithView<ShopWorkFlow>(workflows: workflow, data: data, myStyle: .plain, sectionSeperator: Visibility.hidden)
            .padding(-24)
            .offset(y:-40)
            .ignoresSafeArea()
            .frame(height:800)
            }
}

@available(iOS 16.0, *)
struct ShopContextPreview : PreviewProvider {
    static var previews: some View {
        ShopContext(data: SampleData())
    }
}

