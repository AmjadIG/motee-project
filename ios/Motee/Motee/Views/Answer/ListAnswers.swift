//
//  ListeAnswers.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//

import Combine
import SwiftUI

struct ListAnswersView: View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    var proposition : Proposition
    @State var filter : String = "all"
    
    init(proposition : Proposition){
        self.proposition = proposition
    }

    var body: some View {
        NavigationView{
            ScrollView{
                VStack(){
                    if(filter.elementsEqual("all")){
                        Title(myTitle: "Toutes les réponses")
                    }else if filter.elementsEqual("like"){
                        Title(myTitle: "Les meilleurs réponses")
                    }else if filter.elementsEqual("dateDesc"){
                        Title(myTitle: "Les plus récents réponses")
                    }else if filter.elementsEqual("dateAsc"){
                        Title(myTitle: "Les plus anciennes réponses")
                    }
                    HStack{
                        NavigationLink(destination : { AddAnswerView(propos: proposition) }() ){
                            SymbolGenerator(mySymbol :"plus.square.fill", myColor: "blue")
                            Text("Ajouter").foregroundColor(.blue).bold()
                        }
                    }
                    List{
                        ForEach(PropositionModel.getAllAnswer(proposition: PropositionModel.getPropositionById(idProp: proposition.id))){ answer in
                            AnswerView(answer: answer)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
/*
struct ListAnswersView_Previews: PreviewProvider {
    static var previews: some View {
        ListAnswersView()
    }
}
*/
