//
//  ButtonView.swift
//  AppGroup1
//
//  Created by Giammarco on 18/02/23.
//

import SwiftUI

struct ButtonView<Content:View>: View {
    let sheet: Content
    init(@ViewBuilder sheet: () -> Content) {
            self.sheet = sheet()
        }
    @State private var showSheet = false
    var body: some View{
        Button(action: {
            self.showSheet = true
            //Aggiunta della transazione
        }){
            Image(systemName: "plus")
                .buttonStyle(.bordered)
                .tint(.pink)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        
        .sheet(isPresented: $showSheet) {
           sheet
        }
    }
}

    


