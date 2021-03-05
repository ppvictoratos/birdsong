//
//  ContentView.swift
//  XUMO Programming Helper
//
//  Created by Peter Victoratos on 3/2/21.
//

import SwiftUI
import Foundation


let json = """
{
"title":"Best of the Month",
"description":"The best, from fail videos to ice bucket challenges, and soccer tricks to a baby reactions.",
"providers":"JukinVideo",
"operation":"and",
"order":"asc",
"property":"popularity_7d",
"seconds":1800,
"selector":"latest_first",
"randomize":"false",
"interleave":"false",
"update_existing":false,
"internal_name":"jukinvid_botm_onnow",
"allow_adult":false
}
"""
    .data(using: .utf8)!

struct Model: Codable {
    let title: String?
    let description: String?
    let providers: String?
    let operation: String?
    let order: String?
    let property: String?
    let seconds: Int?
    let selector: String?
    let randomize: String?
}

struct JSONView: View {
    @ObservedObject private var model = EXModel()
    
    var body: some View {
        List(self.model.properties) { property in
            PropertyRow(property: property)
        }
    }
    
    struct Property: Codable {
        var id = UUID()
        let name: String
        let value: String
    }
    
    class EXModel: ObservableObject {
        @Published var properties: [Property] = loadJson()
                
        static func loadJson() -> [Property] {
            let myModel = try? JSONDecoder().decode(Model.self, from: json)
            
            return [
                Property(name: "Title:", value: myModel?.title ?? "☠️"),
                Property(name: "Description:", value: myModel?.description ?? "☠️"),
                Property(name: "Providers:", value: myModel?.providers ?? "☠️"),
                Property(name: "Seconds:", value: String(myModel?.seconds ?? 0))
            ]
        }
    }
    
    struct PropertyRow: View {
        var property: Property
        
        var body: some View {
            VStack {
                HStack {
                    Text(property.name)
                    Text(property.value)
                }
                Button("Copy Text") {
                    if let i = property.value? {
                        let pb = NSPasteboard.general
                        
                        pb.clearContents()
                        pb.writeObjects([i])
                        
                    }
                }
            }

        }
    }
}

struct ContentView: View {
    var body: some View {
        JSONView()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
