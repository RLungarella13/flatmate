//
//  ProfileView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 17/02/23.
//

import SwiftUI
import Firebase

struct ProfileView: View {

    @EnvironmentObject var obsUser: ObservableBool
    @StateObject var dataManagerCoUser = DataManagerCoUser()
    @EnvironmentObject var userLog: ObservableUser
    @Binding var isFlagOn: Bool
    
    var body: some View {
        if obsUser.isLoggedIn {
            content
                .environmentObject(userLog)
        }else{
            HomeView(isFlagOn: $isFlagOn)
        }
    }
    var content: some View {
        
        NavigationView{
            ZStack{
                Color("BackGround").ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading, spacing: 30){
                        Text("Settings")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.gray)
                        accountSettings()
                            .environmentObject(userLog)
//                        Text("Preferences")
//                            .font(.system(size: 16))
//                            .bold()
//                            .foregroundColor(.gray)
//                        preferencesSettings()
//                        Text("Feedback")
//                            .font(.system(size: 16))
//                            .bold()
//                            .foregroundColor(.gray)
//                        feedbackSettings()
                        Divider()
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action:{
                                logout()
                                
                            }){
                                Text("Log out")
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                }
           
            }
            .navigationBarTitle("Account")
            
        }
        
        
    }
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Errore durante il logout: \(error.localizedDescription)")
        }
        obsUser.isLoggedIn = false
        self.isFlagOn = false
        let defaults = UserDefaults.standard
        self.isFlagOn = defaults.bool(forKey: "isFlagOn")
        defaults.set(self.isFlagOn, forKey: "isFlagOn")
    }
}

struct accountSettings: View{
    
    @State var dataManagerCoUser = DataManagerCoUser()
    @EnvironmentObject var userLog : ObservableUser
    var body: some View{
        
        Button(action:{
            
        }){
            HStack{
                ZStack(alignment: .bottomTrailing){
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 60))
                    Button(action: {}){
                        Image(systemName: "camera.fill")
                        
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 5){
                    Text(userLog.name+" "+userLog.surname)
                        .font(.system(size: 22))
                        .bold()
                        .foregroundColor(.primary)
                    
                    Text(userLog.email.lowercased())
                        .font(.system(size: 14))
                    
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
}

struct preferencesSettings: View{
    var body: some View{
        Button(action: {
            
        }){
            HStack{
                Text("Notifications")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                
            }
        }
        Button(action: {
            
        }){
            HStack{
                Text("Passcode")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                
            }
        }
    }
}

struct feedbackSettings: View{
    var body: some View{
        Button(action: {
            
        }){
            HStack{
                Text("Rate us")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                
            }
        }
        
        Button(action: {
            
        }){
            HStack{
                Text("Contact us")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                
            }
        }
    }
}
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

