import Foundation
import SwiftUI




extension View {
    func runAnimation() -> Animation {
        Animation.linear(duration: 1.9).repeatForever()
    }
    func runBounce() -> Animation {
        Animation.default.repeatCount(5).speed(2)
    }
    func runSpring() -> Animation {
        Animation.interactiveSpring(response: 2, dampingFraction: 1, blendDuration: 2)
    }
    func stopAnimation() -> Animation {
        Animation.linear(duration: 0.3)
    }
    func runOnce() -> Animation {
        //Animation.easeIn(duration:0.75).speed(1)
        Animation.linear(duration: 0.8).speed(1.5)
    }
}

struct Animations {
  
    var drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -100 {
                        withAnimation {
        
                        }
                    }
                }
    
         // View Modifier for returning this  TODO
        //animation(.interpolatingSpring(stiffness: 50, damping: 1))
}

struct Standard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.clear).padding(.top,57).padding(.bottom, 20)
    }
}
struct ListFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.clear)
    }
}
struct Top: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(alignment: .top)
    }
}

struct Bottom: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(alignment: .bottom)
    }
}
struct Icon: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 70, height: 70).background(Color.clear)
           
    }
}
struct IconSmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30).background(Color.clear)
           
    }
}

extension Image {
    func imageThumbnailXLarge() -> some View {
        modifier(ImageThumbnail())
    }
}
struct ImageThumbnail: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.clear)
            .foregroundColor(.blue)
            .border(.bar, width: 2)
            .font(.XLarge)
    }
}


extension View {
    func standard() -> some View {
       modifier(Standard())
    }
    func listframe() -> some View {
       modifier(ListFrame())
    }
    func icon() -> some View {
        modifier(Icon())
    }
    func iconSmall() -> some View {
        modifier(IconSmall())
    }
    
    
    func top() -> some View {
        modifier(Top())
    }
    
    func bottom() -> some View {
        modifier(Bottom())
    }
    
}


struct StandardButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .frame(height: 44, alignment: .center)
            .background(Color.white)
    }
}
extension Button {
    func standardButton() -> some View {
        modifier(StandardButton())
    }
}

struct OffStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.caption)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                //.border(Color.black, width: 4)
                .font(.Large)
                .scaledToFill()
        }
}

struct OnStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.caption)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .font(.Large)
                .scaledToFit()
        }
}

extension Button {
    func offStyle() -> some View {
        modifier(OffStyle())
    }
    func onStyle() -> some View {
        modifier(OnStyle())
    }
}
 

extension Color {
    public static var BackgroundColor: Color {
        return Color(UIColor(red: 219/255, green: 175/255, blue: 15/255, alpha: 1.0))
    }
    public static var LightGray: Color {
        return Color(UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0))
    }
    public static var DarkGray: Color {
        return Color(UIColor(red:133/255, green: 133/255, blue: 133/255, alpha: 1.0))
    }
    
    public static var label: Color {
        return Color(UIColor.label)
    }
    
}

extension LinearGradient {
    public static var offGradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.5), .white, .white.opacity(0.5), .gray, .black]), startPoint: .top, endPoint: .bottom)
    }
    public static var pinkToBlack: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.pink, .red.opacity(0.5),.pink]), startPoint: .top, endPoint: .bottom)
    }
    public static var blackblue: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.black, .cyan.opacity(0.45), .black.opacity(0.8), .blue, .black]), startPoint: .top, endPoint: .bottom)
    }
    public static var whiteToGreen: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.white, .white, .white, .gray.opacity(0.3), .green.opacity(0.5), .green]), startPoint: .top, endPoint: .bottom)
    }
}
extension RadialGradient {
    public static var  fun: RadialGradient {
        return RadialGradient(gradient: Gradient(colors: [.yellow,.orange, .white]), center: .center, startRadius: 57, endRadius: 5500)
    }}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}


extension Font {
    
    static func loadFonts() {
            // Register fonts to app, without using the Info.plist.... :smiling_imp:

        if let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: "inter-Bold") {
                if #available(iOS 13.0, *) {
                    CTFontManagerRegisterFontURLs(fontURLs as CFArray, .process, true, nil)
                } else {
                    CTFontManagerRegisterFontsForURLs(fontURLs as CFArray, .process, nil)
                }
            }
        
        if let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: "inter-Regular") {
                if #available(iOS 13.0, *) {
                    CTFontManagerRegisterFontURLs(fontURLs as CFArray, .process, true, nil)
                } else {
                    CTFontManagerRegisterFontsForURLs(fontURLs as CFArray, .process, nil)
                }
            }
        
        }
    
    
    
    public static var LargeBoldFont: Font {
        loadFonts()
        return Font.custom("Cookie-Regular", size: 38).bold()
    }
    
    public static var Small: Font {
    
        return Font.custom("Helvetica-Neue", size: 12)
    }
    public static var Medium: Font {
     
        return Font.custom("Helvetica-Neue", size: 14)
    }
    public static var Large: Font {
        loadFonts()
        return Font.custom("Helvetica-Neue", size: 24)
    }
    public static var XLarge: Font {
        loadFonts()
        return Font.custom("Cookie-Regular", size:42)
    }
    
    public static var Heading: Font {
        loadFonts()
        return Font.custom("Inter-Bold", size: 42)
    }
    public static var SubHeading: Font {
        loadFonts()
        return Font.custom("Inter-Bold", size: 21)
    }
    
    public static var Copy: Font {
        loadFonts()
        return Font.custom("Inter-Thin", size: 19)
    }
    public static var XXLarge: Font {
     
        return Font.custom("Helvetica-Neue", size: 55).bold()
    }
    public static var StandardFont: Font {
        return Font.custom("Helvetica-Neue", size: 18).bold()
    }
    
    public static var TickerFont: Font {
        return Font.custom("HelveticaNeue-italic", size: 12)
    }
    
}
