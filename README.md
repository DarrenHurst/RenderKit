# RenderKit SPM Workflow sample

 
![Screenshot 2023-11-11 at 9 25 49 AM](https://github.com/DarrenHurst/RenderKit/assets/1024006/c3e4632a-4d0d-41ef-94e9-d999672133fd)



https://github.com/DarrenHurst/RenderKit/assets/1024006/5ea1f734-7235-4a46-979f-1f5acca24615



Examples of Internal View builder creation in Core/ModuleExample

1.  app in a Swift Package, Rendering a toolbar and seperate flows
2.  tableView creation of spm module flows by exposing in spm interface.

Load package in xcode, swift tools are xcode 14 swift-tools-version: 5.7

just add the package. 
https://github.com/DarrenHurst/RenderKit

import SwiftUI
import RenderKit

struct ContentView: View {
    let Render = RenderKit()
   
    var body: some View {
       
        let Render = RenderKit()
        VStack {
            GeometryReader { reader in
                VStack {
                    AnyView(Render.appContext(view: self))
                }.ignoresSafeArea()
            }
        }
         
    }
}

Creating Workflow and describing composeable components

    public func tableViewForWorkflow<T>(flow: [T]) -> any View {
        return AnyView(
            GeometryReader { r in
                ScrollView(.vertical) {
                    NavigationStack {
                        RenderTable( 
                            myStyle: .plain,
                            workflows: flow,
                            sampleData: SampleData(),
                             sectionSeperator: .hidden)
                    }.frame(height: r.size.height)
                }
            }
        )
    }
    
    #Loads the app Context from package
    public func appContext(view: any View) -> any View {
        let view = LoadingPage()
        return view
    }
This package currently generates the Toolbar and it's view inside the SPM Dependency

### TODO

Make a API to Generate a TableView,  The view will be added to the Generative Flow from the App side.

