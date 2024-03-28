//
//  SampleData+Courses.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/2/24.
//

import Foundation
import MapKit

//needed to create internal version of MKC for previews???????
//struct CodableMKCoordinateRegion: Codable {
//    var region: MKCoordinateRegion
//}


extension CLLocationCoordinate2D {
    static let alleyCLL = CLLocationCoordinate2D(latitude: 40.7493, longitude: -73.7388)
    static let flushCLL = CLLocationCoordinate2D(latitude: 40.7469, longitude: -73.8449)
    static let eisenCLL = CLLocationCoordinate2D(latitude: 40.7412, longitude: -73.5888)
    static let shipdCLL = CLLocationCoordinate2D(latitude: 40.7584, longitude: -73.1442)
    static let monstCLL = CLLocationCoordinate2D(latitude: 40.7244, longitude: -73.2455)
}

extension MKCoordinateRegion {
    static let alleyMap = MKCoordinateRegion(center: .alleyCLL, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    static let flushMap = MKCoordinateRegion(center: .flushCLL, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    static let eisenMap = MKCoordinateRegion(center: .eisenCLL, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    static let shipdMap = MKCoordinateRegion(center: .shipdCLL, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    static let monstMap = MKCoordinateRegion(center: .monstCLL, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
}

extension Course {
    static let alleypond = Course(name: "Alley Pond Golf Center", 
                                  //location: MKCoordinateRegion.alleyMap,
                                  pars: [])
    static let flushing = Course(name: "Flushing Meadows Mini Golf", 
                                 //location: MKCoordinateRegion.flushMap,
                                 pars: [])
    static let eisenhower = Course(name: "Eisenhower Park Mini Golf", 
                                   //location: MKCoordinateRegion.eisenMap,
                                   pars: [])
    static let shipwrecked = Course(name: "Shipwrecked Mini Golf", 
                                    //location: MKCoordinateRegion.shipdMap,
                                    pars: [])
    static let monster = Course(name: "Monster Mini Golf", 
                                //location: MKCoordinateRegion.monstMap,
                                pars: [2, 3, 4, 3, 2, 5, 3, 4, 2, 3, 4, 5, 2, 3, 4, 3, 5, 2])
}
