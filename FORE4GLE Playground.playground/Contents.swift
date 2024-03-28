import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            //Map(initialPosition: .region(region))
            
            Color.green.ignoresSafeArea().opacity(0.2)
            
            VStack {
                Image(systemName: "figure.golf")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.white, lineWidth: 2)
                    }
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
            }
            

            }
    }
}

#Preview {
    ContentView()
}

