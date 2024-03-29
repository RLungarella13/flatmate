//
//  LogInView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 20/02/23.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var email = ""
    @State var password = ""
    @Binding var isFlagOn: Bool
    @State var isPresented = false
    @EnvironmentObject var obsUser: ObservableBool
    @EnvironmentObject var userLog: ObservableUser
    @StateObject var dataManagerCoUser = DataManagerCoUser()
    
    
    var body: some View {
        ZStack{
            Color("BackGround").ignoresSafeArea()
            VStack(spacing:20){
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
                .frame(height: 130)
//                HStack{
//                    Button(action: {
//                        
//                    }){
//                        Text("Forgotten Password?")
//                            .foregroundColor(.gray)
//                            .font(.system(size: 16))
//                            .underline()
//                    }
//                }
                Button(action: {
                    login()
                    dataManagerCoUser.coUsers.forEach{ user in
                        if user.email.lowercased() == email.lowercased() {
                            userLog.email = email
                            userLog.id = user.id
                            userLog.name = user.name
                            userLog.surname = user.surname
                        }
                        
                        
                    }
                }){
                    Text("Log In")
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
            Alert(title: Text("Wrong Credentials"), message: Text(""), dismissButton: .default(Text("OK")))
                }
        

    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print (error!.localizedDescription)
                isPresented = true
            }else{
                obsUser.isLoggedIn = true
                self.isFlagOn = true
                let defaults = UserDefaults.standard
                self.isFlagOn = defaults.bool(forKey: "isFlagOn")
                defaults.set(self.isFlagOn, forKey: "isFlagOn")
            }
            userLog.email = email
        }
    }
}

//struct LogInView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInView()
//    }
//}

