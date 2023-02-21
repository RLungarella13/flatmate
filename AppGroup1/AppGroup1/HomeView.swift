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
    @EnvironmentObject var logInState: LogInState
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("BackGround").ignoresSafeArea()
                VStack{
                    AdaptiveImage(light: Image("logoCatLight"), dark: Image("logoCatDark"))
                        .scaleEffect(0.4)
                        .position(x: 200, y:150)
                    
                }
                VStack(spacing: 30){
//                    ForEach(dataManager.users, id: \.id){ user in
//                        Text(user.name)
//                            .foregroundColor(.black)
//                            .font(.system(size: 80))
//                    }
                    Spacer()
                    // LOG IN
                    NavigationLink(destination: LogInView()){
                        Text("Log In")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 120)
                    }
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 2)
                    // SIGN UP
                    NavigationLink(destination: SignUpView()){
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 120)
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataManager())
    }
}

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
//
//Form{
//    Section{
//        TextField("Email", text: $email)
//            .foregroundColor(.primary)
//            .textFieldStyle(.plain)
//            .font(.system(size: 20))
//    }
//    Section{
//        SecureField("Password", text: $password)
//            .foregroundColor(.primary)
//            .textFieldStyle(.plain)
//            .font(.system(size: 20))
//    }
//
//}
