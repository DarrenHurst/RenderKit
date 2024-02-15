import Foundation
import SwiftUI


protocol ModelProtocol {
    var model: ModelTypes { get set }
}
enum ModelTypes: String, CaseIterable{
    var id: Self {
        return self
    }
    static var allCases: [ModelTypes] {
        return [.login]
       }

    case login = "Login"
           
       @available(*, unavailable)
       case all
}
struct ModelType: ModelProtocol {
    var model: ModelTypes = .login
}

@available(iOS 16.0, *)
struct RenderForm: View {
    // AppStorage temp for demo
    //@AppStorage("loginName") private var loginName: String = ""
    //@AppStorage("password") private var password: String = ""
    @StateObject var loginModel =  LoginModel(loginName: "",
                                             password: "",
                                             rememberMe: false)

    @State var authenticated: Bool = false
    @ObservedObject var data: SampleData
    var body: some View {
            GeometryReader() { reader in
                if !$authenticated.wrappedValue {
                    Form {
                        TextField("Login", text: $loginModel.loginName)
                            .background(Color.blue.opacity(0.2))
                            .padding(.bottom, 10)
                        TextField("Password", text: $loginModel.password)
                            .background(Color.blue.opacity(0.2))
                            .padding(.bottom, 10)
                        Button(action: {
                            Task {
                                //URL with LoginRequest
                                if ($loginModel.loginName.wrappedValue == "Darren" && $loginModel.password.wrappedValue == "HireME"){
                                    self.authenticated.toggle()
                                }
                            }
              
                        }, label: {
                            Text("Login").frame(width: reader.size.width).padding(10)
                        })
                        .contentShape(Rectangle())
                        .background(Color.blue.opacity(0.2))
                        .frame(width: reader.size.width, height:20)
                        .padding(.top, 10)
                    }
                    
                } else {
                    
                }
            }
        }
    
}

@available(iOS 16.0, *)
struct RenderFormPreview: PreviewProvider {
    static var previews: some View {
        RenderForm(data:SampleData())
    }
}

class LoginModel: ObservableObject {
    @Published var loginName: String
    @Published var password: String
    @Published var rememberMe: Bool
    
    init(loginName: String, password: String, rememberMe: Bool){
        self.loginName = loginName
        self.password = password
        self.rememberMe = rememberMe
    }
}
