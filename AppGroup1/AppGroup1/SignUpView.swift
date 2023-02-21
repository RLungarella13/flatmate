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
    @State private var name = ""
    @State private var surname = ""
    
    
    var body: some View {
        
        
        ZStack{
            Color("BackGround").ignoresSafeArea()
            VStack{
                Form{
                    Section(header: Text("NAME*")){
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("SURNAME*")){
                        TextField("Surname", text: $name)
                    }
                    Section(header: HStack{
                        Text("EMAIL*")
                        Spacer()
                        Image(systemName: "envelope")
                            .font(.system(size: 20))
                    }){
                        HStack{
                            TextField("Email", text: $email){
                            }
                        }
                        
                    }
                    Section(header: HStack{
                        Text("PASSWORD*")
                        Spacer()
                        Image(systemName: "key.horizontal")
                            .font(.system(size: 20))
                    }){
                        HStack{
                            SecureField("Password", text: $password){
                            }
                        }
                        HStack{
                            SecureField("Confirm Password", text: $password)
                        }
                    }
                }
                .frame(height: 450)
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
