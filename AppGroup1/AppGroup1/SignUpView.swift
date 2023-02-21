//
//  LogInView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 20/02/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var dataManager : DataManager
    
    @State private var newUser = ""
    @State private var userIsLoggedIn = false
    
    
    var body: some View {
        
        
        ZStack{
            Color("BackGround").ignoresSafeArea()
            VStack{
                Form{
                    Section{
                        HStack{
                            Image(systemName: "envelope")
                            TextField("Email", text: $email){
                            }
                        }
                        HStack{
                            Image(systemName: "key.horizontal")
                            SecureField("Password", text: $password){
                            }
                        }
                    }
                }
                .frame(height: 155)
                Button(action: {
                    //Variable for not showing full screen page
                    register()

                }){
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
        }
        
    }
    
    
    
    func register(){
        print(email)
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                
            }
        }
//        dataManager.addUser(email: email, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
