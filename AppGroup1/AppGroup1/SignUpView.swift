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
    
    @EnvironmentObject var logInState: LogInState
    @EnvironmentObject var dataManager : DataManager
    
    @State private var newUser = ""
    @State private var userIsLoggedIn = false
    
    var body: some View{
        if userIsLoggedIn{
//            dataManager.addUser(email: email, password: password)
        }
        else{
            content
        }
    }
    var content: some View {
        
        
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
                    
                    logInState.isObserving = false
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
        .onAppear{
            Auth.auth().addStateDidChangeListener{ auth, user in
                if user != nil{
                    userIsLoggedIn.toggle()
                }
                
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
        }
        dataManager.addUser(email: email, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
