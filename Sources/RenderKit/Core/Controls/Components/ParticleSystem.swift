
import Foundation
import SwiftUI
import CoreMotion

@available(iOS 15.0, *)
struct ParticleView : View {
    @State private var particleSystem = ParticleSystem()
  
    
    func randomPoint() -> CGPoint {
        let x = 0...600
        let y = 0...1000
        return CGPoint(x: .random(in: x), y: .random(in:y))
     }
 
      
    var body: some View {

        TimelineView(.periodic(from: Date.now, by: 1.0)) { context in
            let timelineDate = context.date.timeIntervalSinceReferenceDate
   
            Canvas { context, size in
                Task {
                  await particleSystem.update(date: timelineDate)
                }
                context.blendMode = .color
                let numberOfParticles = 7
                let particleRange: ClosedRange  = 0...numberOfParticles
                    for _ in particleRange {
                        
                        for particle in particleSystem.particles {
                            var contextCopy = context
                            contextCopy.addFilter(.colorMultiply(Color.white))
                            contextCopy.opacity = 0.5
                
                            var options: [CGPoint] = []
                            for _ in particleRange {
                                options.append(self.randomPoint())
                            }
                            for option in options {
                                          contextCopy.draw(particleSystem.image, at: option)
                            }
                        }
                    }
            }
        }
        .ignoresSafeArea().standard().top()
        .background(.clear)
        .foregroundColor(.white)
       
    }
}

@available(iOS 15.0, *)
struct ParticleViewPreview : PreviewProvider {
    static var previews: some View {
        ParticleView()
    }
}



@available(iOS 15.0, *)
struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}

@available(iOS 15.0, *)
class ParticleSystem {
    let image = Image(systemName: "snow")
       
    //let image = Image("❤️")
    var particles = Set<Particle>()
    var center = UnitPoint.center
    var hue = 1.0

    
    @MainActor
    func update(date: TimeInterval) async {
        
            let deathDate = date - 3

            let numberOfParticles = 1
            let particleRange: ClosedRange  = 0...numberOfParticles
    
              for _ in particleRange {
                  for particle in particles {
                      
                      if particle.creationDate > deathDate {
                        particles.remove(particle)
                      }
                  }
                  let newParticle = Particle(x: center.x, y: center.y, hue: hue)
                particles.insert(newParticle)
                //hue += 0.01
                
                if hue < 0 { hue -= 1 }
            }
        }
}
