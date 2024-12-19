import Foundation
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var galleryFrames: [CGRect] = []
    @Published var artworkCircles: [CGPoint] = []
    @Published var greenArea: [CGPoint] = []
    @Published var artworkLabels: [String] = []
    
    @Published var galleryNames: [String] = [
        "GALERIA 1", "GALERIA 2", "GALERIA 3", "GALERIA 4", "SALA", "GALERIA 5", "GALERIA 6", "SSHH"
    ]

    func calculateGalleryFrames(in size: CGSize) {
        galleryFrames = [
            CGRect(x: 20, y: size.height - 150, width: 200, height: 100), // Galeria 1
            CGRect(x: 20, y: size.height - 350, width: 100, height: 200), // Galeria 2
            CGRect(x: 120, y: size.height - 350, width: 100, height: 70), // Galeria 3
            CGRect(x: 20, y: size.height - 580, width: 100, height: 180), // Galeria 4
            CGRect(x: 120, y: size.height - 580, width: 100, height: 70), // Sala
            CGRect(x: size.width - 90, y: size.height - 200, width: 80, height: 100), // Galeria 5
            CGRect(x: size.width - 90, y: size.height - 350, width: 80, height: 150), // Galeria 6
            CGRect(x: size.width - 80, y: size.height - 580, width: 60, height: 80)  // Baño
        ]
    }
    
    func generateArtworkCircles(in size: CGSize) {
        artworkCircles = [
            //Galeria 1
            CGPoint(x: 35, y: 415),
            CGPoint(x: 35, y: 485),
            CGPoint(x: 105, y: 485),
            CGPoint(x: 205, y: 485),
            CGPoint(x: 205, y: 415),
            //Galeria 2
            CGPoint(x: 35, y: 250),
            CGPoint(x: 35, y: 380),
            CGPoint(x: 105, y: 380),
            
            //Galeria 3
            CGPoint(x: 205, y: 260),
            
            //Galeria 4
            CGPoint(x: 35, y: 20),
            CGPoint(x: 35, y: 100),
            CGPoint(x: 70, y: 130),
            CGPoint(x: 105, y: 20),
            CGPoint(x: 105, y: 100),
            
            //Galeria 5
            CGPoint(x: 290, y: 425),
            
            //Galeria 6
            CGPoint(x: 290, y: 310),
            
            //Sala
            CGPoint(x: 205, y: 25)
            
        ]
            
    }
    
    func generateArtworkLabels() {
        artworkLabels = [
            // Galeria 1
            "P1", "P2", "P3", "P4", "P5",
            // Galeria 2
            "P1", "P2", "P3",
            // Galeria 3
            "P1",
            // Galeria 4
            "P1", "P2", "P3", "P4", "P5",
            // Galeria 5
            "P1",
            // Galeria 6
            "P1",
            // Sala
            "P1"
        ]
    }
    
    func generateGreenArea(in size: CGSize) {
        greenArea = [
            //CGPoint(x: 170, y: 330),
            CGPoint(x: 170, y: 90),
        ]
            
    }
    func getGalleryId(for circle: CGPoint) -> Int? {
        for (index, frame) in galleryFrames.enumerated() {
            if frame.contains(circle) {
                return index + 1 // IDs de galería comienzan en 1
            }
        }
        return nil
    }
    
    func getArtworkIndex(for circleIndex: Int, in galleryId: Int) -> Int {
        let circlesInGallery = artworkCircles.enumerated().filter { index, point in
            getGalleryId(for: point) == galleryId
        }
        
        if circleIndex < circlesInGallery.count {
            return circleIndex
        }
        return 0 
    }


}
