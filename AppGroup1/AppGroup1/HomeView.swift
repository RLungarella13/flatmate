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
    var body: some View {
        NavigationView{
            ZStack{
                Color("BackGround").ignoresSafeArea()
                VStack{
                    Image("logoCat")
                        .scaleEffect(0.3)
                        .position(x: 200, y:150)
                    
                }
                VStack(spacing: 30){
                    
                    Spacer()
                    // LOG IN
                    NavigationLink(destination: LogInView()){
                        Text("Log In")
                            .foregroundColor(Color("ForeGround"))
                            .bold()
                            .frame(width: 120)
                    }
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 2)
                    // SIGN UP
                    NavigationLink(destination: LogInView()){
                        Text("Sign Up")
                            .foregroundColor(Color("ForeGround"))
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
