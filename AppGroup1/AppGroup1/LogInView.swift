//
//  LogInView.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 20/02/23.
//

import SwiftUI

struct LogInView: View {
    
    @State var email = ""
    @State var password = ""
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
                }){
                    Text("Log In")
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
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
