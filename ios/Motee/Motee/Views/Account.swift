//
//  Account.swift
//  Motee
//
//  Created by Rayan Bahroun on 08/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct Account: View {
    
    @State var pwdChanged : Bool = false
    @State var passToChange : Bool = false
    
    @State var oldPwd : String = ""
    @State var newPwd : String = ""
    @State var confirmPwd : String = ""
    
    let samePwd = "Le nouveau mot de passe doit être différent de l'ancien!"
    let alUPwd = "Mot de passe déjà utilisé... Réessayez plus tard"
    let coPb = "Problème de connexion... Réessayez plus tard"
    let okPwd = "Mot de passe changé avec succès !"
    let noSameNewPwd = "Les mots de passe ne correspondent pas..."

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
            ScrollView{
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
                            Text("Modifier son mot de passe").foregroundColor(Color.pink)
                        }
                    }
                    if self.passToChange{
                        FieldGenerator.secure(label:"",field: "Ancien Mot de Passe", text: $oldPwd)
                        FieldGenerator.secure(label:"",field: "Nouveau Mot de Passe", text: $newPwd)
                        FieldGenerator.secure(label:"",field: "Confirmer Mot de Passe", text: $confirmPwd)

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
                            .background(generateColor(name: "orange"))
                            .cornerRadius(40)
                        }
                        Divider()
                        Spacer()
                    }
                    if pwdChanged {
                        if oldPwd != newPwd {
                            if newPwd != currentUser.passwordProperties {
                                if newPwd == confirmPwd {
                                    if UserModel.updateUser(oldPwd: oldPwd, newPwd: newPwd, confirmPwd: confirmPwd, token: fk.token){
                                        HStack {
                                            Text(okPwd)
                                            .bold()
                                            .foregroundColor(Color.red)
                                            .multilineTextAlignment(.center)
                                            .padding(.all, 0.0)
                                            .padding()
                                            .transition(.scale)
                                        }
                                    }else {
                                        HStack {
                                            Text(coPb)
                                            .bold()
                                            .foregroundColor(Color.red)
                                            .multilineTextAlignment(.center)
                                            .padding(.all, 0.0)
                                            .padding()
                                            .transition(.scale)
                                        }
                                    }
                                }else {
                                    HStack {
                                        Text(noSameNewPwd)
                                        .bold()
                                        .foregroundColor(Color.red)
                                        .multilineTextAlignment(.center)
                                        .padding(.all, 0.0)
                                        .padding()
                                        .transition(.scale)
                                    }
                                }
                                
                            } else {
                                HStack {
                                    Text(alUPwd)
                                    .bold()
                                    .foregroundColor(Color.red)
                                    .multilineTextAlignment(.center)
                                    .padding(.all, 0.0)
                                    .padding()
                                    .transition(.scale)
                                }
                            }
                        } else {
                            HStack {
                                Text(samePwd)
                                .bold()
                                .foregroundColor(Color.red)
                                .multilineTextAlignment(.center)
                                .padding(.all, 0.0)
                                .padding()
                                .transition(.scale)
                            }
                        }
                        
                    }
                    NavigationLink(destination: AddProposition()){
                        Text("Je contribue tout de suite!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: 320, height: 60)
                            .background(generateColor(name: "pink"))
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
                        .background(generateColor(name: "red"))
                        .cornerRadius(40)
                    }
                    Spacer()
                }
            }
        })
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account().environmentObject(FilterKit())
    }
}

