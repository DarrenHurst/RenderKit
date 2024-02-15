
import Foundation
import SwiftUI

 
@available(iOS 16.0, *)
struct RenderButton: View, Identifiable {
    var id : UUID = UUID()
    var text: String?
    var image: Image?
    var shape: (any Shape)? = Rectangle()
    var width: CGFloat?
    var action: () -> Void
    @State var animate: Bool = false
    
    let theme = Config().currentTheme
    var body: some View {
            VStack {
                Button(action: action) {
                 
                    image?
                        .foregroundColor(animate ? theme.textColor : theme.textColor.opacity(0.5))
                    //.symbolVariant(.fill)
                        .symbolVariant(animate ? .none : .fill)
                        .symbolRenderingMode(.hierarchical)
                        .animation(.easeIn(duration: 1.0).speed(1.25), value: animate)
                        .padding(theme.padding)
                    if text != nil {
                        Text(text ?? "Back")
                            .foregroundColor(animate ? theme.textColor : theme.textColor.opacity(0.5))
                            //.animation(.easeIn(duration: 1.0).speed(1.25), value: animate)
                            .padding(theme.padding)
                             
                    }
                }
                .frame(width: width)
                
                .background(
                    shape?
                        .stroke(theme.backgroundBorder, style: StrokeStyle(lineWidth: theme.borderWidth))
                        .opacity(theme.backgroundOpacity)
                        .anyView)
                .background(theme.background.opacity(theme.backgroundOpacity))
                .accessibilityLabel(text ?? "Back")
                //.animation(.easeIn(duration: 1.5).speed(1.5), value: animate)
                
                .mask(shape?.opacity(theme.backgroundOpacity).anyView)
                .shadow(radius: 5.0)
                .onAppear() {
                     animate = true
                }
                .onTapGesture {
                    animate = false
                }
                .onTapGesture {
                   // animate.toggle()
                }
               
            }
       
    }
    // Text("\(String(describing: twoSums([2,4,3,6,7],9)))")
    func twoSums(_ nums: [Int],_ target: Int) -> [Int] {
        var tempNums: [Int: Int] = [Int: Int]()
        for (index, num) in nums.enumerated() {
            if let val = tempNums[target - num] {
                return [val, index]
            }
            
            tempNums[num] = index
        }
        return []
    }
}





@available(iOS 16.0, *)
struct RenderButtonPreview: PreviewProvider {
    static let back = NSLocalizedString("Back", tableName: nil, bundle: Bundle.module, value: "", comment: "")
    
    static var previews: some View {
        HStack{
            RenderButton(text: "Rectangle", shape: RoundedRectangle(cornerRadius: 0)) {}
            RenderButton(text: "Rectangle", shape: RoundedRectangle(cornerRadius: 10)) {}
            RenderButton(text: "Capsule", shape: Capsule()) {}
            RenderButton(image: Image(systemName:"house"), shape: Circle()) {}
        }
    }
}
