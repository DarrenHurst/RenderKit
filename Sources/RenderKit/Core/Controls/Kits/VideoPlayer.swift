//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-02.
//

import Foundation
import AVKit
import SwiftUI
import RealityKit
 

struct VideoView: View {
    @State var player: AVPlayer = AVPlayer()
    @State var urlString =
"https://r2---sn-tt1e7nlz.c.2mdn.net/videoplayback/id/46ecb341261f13e2/itag/22/source/web_video_ads/ctier/L/acao/yes/ip/0.0.0.0/ipbits/0/expire/3851221913/sparams/acao,ctier,expire,id,ip,ipbits,itag,mh,mip,mm,mn,ms,mv,mvi,pl,source/signature/6FE04903A4B5EDF7980C5EE08926F331B2E822B5.01C6906590E4008494FFC49DFE76AD5DC6582F34/key/cms1/cms_redirect/yes/mh/Z6/mip/184.147.41.245/mm/42/mn/sn-tt1e7nlz/ms/onc/mt/1706902593/mv/m/mvi/2/pl/23/file/file.mp4"
    var body: some View {
     
        return VStack {
            VideoPlayer(player: player)
            
           /* Model3D(named: "Dollhead") { model in
                 model
                     .resizable()
                     .aspectRatio(contentMode: .fit)
             } placeholder: {
                 ProgressView()
             }
            */
        }.ignoresSafeArea()
        .onAppear() {
           
            
            
           
        
            
            guard let url = URL(string: urlString) else  {
                return
            }
            player = AVPlayer(url: url)
           player.play()
         
        }
    }

}

struct ViewPreview: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
