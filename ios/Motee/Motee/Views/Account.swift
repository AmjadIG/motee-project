//
//  Account.swift
//  Motee
//
//  Created by Rayan Bahroun on 08/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import SwiftUI


struct Account: View {
    let dateFormatter = DateFormatter()
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    
    var nbProposition : String
    var nbAnswer : String
    
    init(){
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        nbProposition = String(UserModel.getPropositionsByUser(user: currentUser!).count)
        nbAnswer = String(UserModel.getAnswersByUser(user: currentUser!).count)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Title(myTitle: "Mes informations").padding(.vertical)
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        SymbolGenerator(mySymbol: "person", myColor: "black")
                        Text(""+currentUser!.pseudo).padding(.vertical)
                    }
                    HStack{
                        SymbolGenerator(mySymbol: "envelope", myColor: "black")
                        Text(currentUser!.email).padding(.vertical)
                    }
                    /*HStack{
                        SymbolGenerator(mySymbol: "location", myColor: "black")
                        Text(currentUser!.city).padding(.vertical)
                    }*/
                }
                Title(myTitle: "Mes contributions").padding(.vertical)
                
                if (currentUser!.idPropositions.count>0 || currentUser!.idAnswers.count>0){
                    Text("\(currentUser!.pseudo) merci pour vos \(currentUser!.idPropositions.count+currentUser!.idAnswers.count) réponses").padding(.vertical)
                }else{
                    Text("\(currentUser!.pseudo) ! vous n'avez pas encore contribué à l'application.. et si c'était le moment de nous partager votre expérience ? ").padding(.all)
                }
                NavigationLink(destination: Accueil()){
                    Text("Je contribue tout de suite !")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: 320, height: 60)
                        .background(generateColor(name: "pink"))
                        .cornerRadius(40)
                }
                Spacer()
            }
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}

