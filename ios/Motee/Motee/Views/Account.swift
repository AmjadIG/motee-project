//
//  Account.swift
//  Motee
//
//  Created by Rayan Bahroun on 08/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct Account: View {
    
    @State var passToChange : Bool = false
    @State var oldPwd : String = ""
    @State var newPwd : String = ""
    
    @State var pwdChanged : Bool = false

    @EnvironmentObject var fk : FilterKit
    let dateFormatter = DateFormatter()
    
    init(){
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        
        guard let currentUser = fk.currentUser else {
            return AnyView(VStack(alignment: .center) {
                    Button(action : {
                        self.fk.currentPage = "Sign in"
                    }){
                        Text("Connectez-vous")
                    }
                    
                })
            }
            return AnyView(NavigationView{
            VStack{
                Title(myTitle: "Mes informations").padding(.vertical)
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        SymbolGenerator(mySymbol: "person", myColor: "black")
                        Text(""+currentUser.pseudo).padding(.vertical)
                    }
                    HStack{
                        SymbolGenerator(mySymbol: "envelope", myColor: "black")
                        Text(currentUser.email).padding(.vertical)
                    }
                    /*HStack{
                        SymbolGenerator(mySymbol: "location", myColor: "black")
                        Text(currentUser!.city).padding(.vertical)
                    }*/
                }
                Title(myTitle: "Mes contributions").padding(.vertical)
                
                if (currentUser.idPropositions.count>0 || currentUser.idAnswers.count>0){
                    Text("\(currentUser.pseudo), merci pour vos \(currentUser.idPropositions.count+currentUser.idAnswers.count) réponses !").padding(.vertical)
                }else{
                    Text("\(currentUser.pseudo)! Vous n'avez pas encore contribué à l'application.. et si c'était le moment de nous partager votre expérience?").padding(.all)
                }
                if !pwdChanged {
                    Button(action:{
                        if self.passToChange {
                            self.passToChange = false
                        }else {
                            self.passToChange = true
                        }
                    }){
                        Text("Modifier son mot de passe")
                    }
                }
                if self.passToChange{
                    FieldGenerator.secure(label:"",field: "Ancien Mot de Passe", text: $oldPwd)
                    FieldGenerator.secure(label:"",field: "Nouveau Mot de Passe", text: $newPwd)
                    Button(action:{
                        //Modifier le user
                        self.pwdChanged = true
                        self.passToChange = false
                        
                    }){
                        Text("Changer de mot de passe")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: 320, height: 60)
                        .background(generateColor(name: "blue"))
                        .cornerRadius(40)
                    }
                    Divider()
                    Spacer()
                }
                if pwdChanged {
                    HStack {
                        Text("Mot de passe changé avec succès !")
                        .bold()
                        .foregroundColor(Color.green)
                        .multilineTextAlignment(.center)
                        .padding(.all, 0.0)
                        .padding()
                        .transition(.scale)
                    }
                }
                NavigationLink(destination: AddProposition()){
                    Text("Je contribue tout de suite!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: 320, height: 60)
                        .background(generateColor(name: "green"))
                        .cornerRadius(40)
                }.padding()
                Button(action:{
                    if UserModel.logout(token: self.fk.token){
                        self.fk.currentUser = nil
                        self.fk.token = ""
                        self.fk.currentPage = "Accueil"
                    }
                }){
                    Text("Se déconnecter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: 320, height: 60)
                    .background(generateColor(name: "pink"))
                    .cornerRadius(40)
                }
                Spacer()
            }
        })
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account().environmentObject(FilterKit())
    }
}

