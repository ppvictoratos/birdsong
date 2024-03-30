//
//  GolfersView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/27/24.
//

import SwiftUI
import SwiftData

struct GolfersView: View {
    @Query var golfers: [Golfer]
    
    var body: some View {
        List(golfers) { golfer in
            NavigationLink(value: golfer) {
                Text(golfer.name)
            }
            .navigationDestination(for: Golfer.self) { user in
                EditGolferView(golfer: golfer)}
        }
    }
    
    init(minimumHandicap: Int, sortOrder: [SortDescriptor<Golfer>]) {
        _golfers = Query(filter: #Predicate<Golfer> { golfer in
            golfer.handicap <= minimumHandicap
        }, sort: \Golfer.name)
    }
}

//#Preview {
//    GolfersView(minimumHandicap: 0, sortOrder: [SortDescriptor(\Golfer.name)])
//        .modelContainer(for: Golfer.self)
//}
