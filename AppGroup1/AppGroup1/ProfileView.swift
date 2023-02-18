//
//  ProfileView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 17/02/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color("BackGround").ignoresSafeArea()
                VStack(alignment: .leading, spacing: 20){
                    Text("Settings")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.gray)
                    HStack{
                        ZStack(alignment: .bottomTrailing){
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 60))
                            Button(action: {}){
                                Image(systemName: "camera.fill")
                                
                                
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Raffaele Lungarella")
                                .font(.system(size: 22))
                                .bold()
                            
                            Text("goxgwadu@telegmail.com")
                                .font(.system(size: 14))
                            
                        }
                        Spacer()
                        
                    }
                    Text("Home Overview")
                        .font(.title3)
                        .bold()
                    Divider()
                    balanceOverview()
                    Spacer()
                }
                .padding()
                .navigationBarTitle("Account")
                .navigationBarTitleDisplayMode(.automatic)
            }
        }
       
        
    }
}
struct balanceOverview: View{
    var body: some View{
        List{
            ForEach(0..<3){ index in
                HStack{
                    Image(systemName: "person")
                        .font(.system(size: 30))
                    
                    VStack{
                        Text("Giammarco Fontana owes 4,33$ in total")
                        
                    }
                }
            }
        }
        
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
