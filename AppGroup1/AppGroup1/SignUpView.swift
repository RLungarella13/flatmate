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
    
    @StateObject var dataManagerCoUser = DataManagerCoUser()
    @EnvironmentObject var obsUser: ObservableBool
    
    @State private var newUser = ""
    @State private var userIsLoggedIn = false
    @State private var name = ""
    @State private var surname = ""
    @State private var balance : Float = 0.0
    
    var body: some View {
        
        
        ZStack{
            Color("BackGround").ignoresSafeArea()
            VStack{
                Form{
                    Section(header: Text("NAME*")){
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("SURNAME*")){
                        TextField("Surname", text: $surname)
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
                    let id = generateUniqueString()
                    dataManagerCoUser.addCoUser(id: id, name: name, surname: surname,balance: balance, email: email)

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
        
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
            obsUser.isLoggedIn = true
        }
        
    }
    func generateUniqueString() -> String {
        let uuid = UUID()
        return uuid.uuidString
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
