//
//  LogInView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 20/02/23.
//

import SwiftUI
import Firebase


struct HomeView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var obsUser: ObservableBool
    @State var userLog = ObservableUser()
    @Binding var isFlagOn: Bool
    
    var body: some View{
        if obsUser.isLoggedIn{
            TabBarView(isFlagOn: $isFlagOn)
                .environmentObject(userLog)
        }else{
            content
        }
    }
    var content: some View {
        NavigationView{
            ZStack{
                Color("BackGround").ignoresSafeArea()
                VStack(spacing: 30){
                    Spacer()
                    // LOG IN
                    NavigationLink(destination: LogInView(isFlagOn: $isFlagOn)){
                        Text("Log In")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 120)
                            .shadow(radius: 1)
                    }
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 2)
                    // SIGN UP
                    NavigationLink(destination: SignUpView(isFlagOn: $isFlagOn)){
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 120)
                            .shadow(radius: 1)
                    }
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 2)
                    
                    Spacer()
                    
                    
                }
                .padding(70)
            }
        }
//        .onAppear{
//            Auth.auth().addStateDidChangeListener{ auth, user in
//                if user != nil{
//                    obsUser.isLoggedIn.toggle()
//                }
//                
//            }
//            
//        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(isFlagOn: $isFlagOn)
//            .environmentObject(DataManager())
//    }
//}

struct AdaptiveImage: View {
    @Environment(\.colorScheme) var colorScheme
    let light: Image
    let dark: Image

    @ViewBuilder var body: some View {
        if colorScheme == .light {
            light
        } else {
            dark
        }
    }
}


