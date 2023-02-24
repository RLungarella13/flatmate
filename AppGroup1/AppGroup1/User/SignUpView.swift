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
    @State var confirmPwd = ""
    
    @StateObject var dataManagerCoUser = DataManagerCoUser()
    @EnvironmentObject var obsUser: ObservableBool
    @EnvironmentObject var userLog: ObservableUser
    @Binding var isFlagOn: Bool
    
    @State private var newUser = ""
    @State private var userIsLoggedIn = false
    @State private var name = ""
    @State private var surname = ""
    @State private var balance : Float = 0.0
    @State var isPresented = false
   
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
                            SecureField("Confirm Password", text: $confirmPwd)
                        }
                    }
                    
                }
                .frame(height: 450)
                Button(action: {
                    //Variable for not showing full screen page
                    if(password == confirmPwd){
                        register()
                        let id = generateUniqueString()
                        dataManagerCoUser.addCoUser(id: id, name: name, surname: surname,balance: balance, email: email)
                        userLog.id = id
                        userLog.name = name
                        userLog.surname = surname
                        userLog.email = email
                        
                    }else{
                        isPresented = true
                    }
                    
                        
                    
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
        .alert(isPresented: $isPresented) {
            Alert(title: Text("Wrong Password"), message: Text(""), dismissButton: .default(Text("OK")))
                }
        
    }
    
    
    
    func register(){
        
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                obsUser.isLoggedIn = true
                self.isFlagOn = true
                let defaults = UserDefaults.standard
                self.isFlagOn = defaults.bool(forKey: "isFlagOn")
                defaults.set(self.isFlagOn, forKey: "isFlagOn")
            }
        }
        
    }
    func generateUniqueString() -> String {
        let uuid = UUID()
        return uuid.uuidString
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
