//
//  Firstpage.swift
//  Mieruka
//
//  Created by れい on 2023/08/23.
//

import SwiftUI

struct Firstpage: View {
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 40 / 255.0 , green: 40 / 255.0 , blue: 40 / 255.0)
                    .ignoresSafeArea()
                VStack {
                    Text("Proaxia")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .bold, design: .monospaced))
                    HStack {
                        Image("Proaxia")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(Color.gray, lineWidth: 4 )
                            }
                            .shadow(radius: 7)
                    }
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        Text("TodoList")
                            .foregroundColor(.gray)
                            .padding()
                            .background(Color.white)
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
