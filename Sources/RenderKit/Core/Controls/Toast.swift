import Foundation
import SwiftUI

enum Priority:  CaseIterable {
    static var allCases: [Color] {
        return [.green, .yellow, .red]
        }
    var id: Self {
                return self
            }
    case all
}

struct Toast: View {
    @State var showToast: Bool = true
    var message: String?
    var priority : Int = 2 //low -> 2 high
    var timeDate: Date = Date.now
    @State var count: Int = 0
    
    
    
    
    
    
    var body: some View {
        VStack {
            TimelineView(.periodic(from: Date.now, by: 2)) { context in
                let timelineDate = context.date.timeIntervalSinceReferenceDate
                Canvas { context, size in
                    Task {
                        count += 1
                        await update(timelineDate)
                    }
                }
            }
            GeometryReader { r in
                VStack(alignment: .leading) {
                    // build a drop down, or popup style Navigation Toast
                    HStack {
                        Image(systemName:"cart")
                            .resizable()
                            .scaledToFit()
                            .frame(height: showToast ? 20 : -20)
                            .background(Circle().stroke(style:(StrokeStyle(lineWidth: 2)))
                                .background(Circle().fill(Priority.allCases[priority].opacity(0.5)))
                                .padding(-20)
                            )
                            .padding(.trailing, 2.0)
                        Text(message ?? "If you want to toast this toast..")
                            .padding(20)
                    }.frame(alignment: .leading)
                    
                }
                .frame(width: r.size.width - 60,alignment: .leading)
                .padding(10)
                .padding(.leading, 20)
             
                .background( Capsule().fill(showToast ? Color.black.opacity(0.2) : Color.red))
                .background( Capsule().fill(showToast ? Material.bar : Material.ultraThin))
                .background( Capsule().fill(Color.white))
              
                .onTapGesture() {
                    showToast = showToast ? false : true
                }
                //reverse direction
                .offset(x:10, y:showToast ? -0 : -(-120))
                .opacity(showToast ? 1.0 : 0.0)
                .animation(.easeInOut.speed(0.2), value: showToast)
            }
        }
    }
    
    func update(_ time: Double) async {
        if count == 3 {
            showToast = false
        }
      //  if (time == Date.now.timeIntervalSinceReferenceDate ){
    //    if (timeDate.timeIntervalSinceReferenceDate + 1 <= time) {
      }
}

struct ToastPreview : PreviewProvider {
    static var previews : some View {
        VStack {
            Toast(priority: 0)
            Toast(priority: 1)
            Toast(priority: 2)
        }
    }
}
