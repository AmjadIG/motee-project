//
//  AddProposition.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI

struct AddProposition: View {
    @EnvironmentObject var fk : FilterKit
    @State var newProposition : String = ""
    @State var newAnswer : String = ""
    @State var newTag : String = ""
    @State var tagList : [Tag] = []
    @State var anonymousProposition : Bool = false
    @State var answerAdding : Bool = false
    @State var anonymousAnswer : Bool = false
    @State var titleProposition : String = ""
    @State var selection : String = ""
    @State var emptyTitle = false
    @State var emptyPropContent = false
    @State var emptyAnsContent = false
    @State private var offsetValue: CGFloat = 0.0
    var body: some View {
        VStack{
            Title(myTitle: "Ajouter un propos") // Titre
            Divider()
            ScrollView{ //Formulaire d'ajout de Propos (+ Reponse)
                FieldGenerator.plain(label: "Titre du propos :",field: "Ecrivez votre titre", text: $titleProposition)
                FieldGenerator.plain(label: "Propos :",field: "Ecrivez votre propos", text: $newProposition)
                HStack{
                    FieldGenerator.plain(label: "Ajouter un nouveau tag :",field: "Votre tag", text: $newTag)
                    
                    Button(action:{
                        if self.newTag.count>0 && !(containsLabel(tags: self.tagList, label: self.newTag)){
                            self.tagList.append(Tag(label: self.newTag))
                            self.newTag = ""
                        }else if containsLabel(tags: self.tagList, label: self.newTag) {
                            self.newTag = ""
                        }
                    }){
                        SymbolGenerator(mySymbol: "arrowtriangle.right.circle.fill", myColor: "pink")
                    }
                }
                if(tagList.count>0){ //On affiche les tags si on en a ajouté !
                    TagListView(tagList: $tagList)
                }
                Toggle(isOn : $anonymousProposition){
                    Text("Propos anonyme") //Toggle button => Pour que le propos soit anonyme d'office !
                }
                Divider()
                Toggle(isOn : $answerAdding){ //Toggle button => Pour rajouter une première réponse au propos
                    Text("Proposer une réponse ?")
                }
                if answerAdding {
                    Text("Votre Reponse").font(.system(size: 18)).bold().foregroundColor(.blue).padding()
                    TextField("Ecrivez votre reponse", text: $newAnswer).padding()
                    Toggle(isOn : $anonymousAnswer){
                        Text("Propos anonyme")
                    }
                    Text("Choisir un tag (optionnel) :").padding()
                    ChooseTag(selection: $selection)
                }
                Divider().padding()
                Button(action:{ //Bouton d'envoi du Propos (+Réponse)
                    if self.answerAdding { //On ajoute un propos ET une réponse
                        let idProp = PropositionModel.addProposition(titleProp : self.titleProposition, contentPub: self.newProposition, isAnonymous: self.anonymousProposition, tagsProp: self.tagList, token: self.fk.token)
                        if idProp != "noId" {
                            print("Proposition added")
                            if AnswerModel.addAnswer(contentPub: self.newAnswer, isAnonymous: self.anonymousAnswer, tagsAns:  [Tag(label :self.selection)], idProposition: idProp, token: self.fk.token) {
                                 self.fk.currentPage = "Accueil"
                                print("Answer added")
                            }else{
                                print("Answer not added")
                            }
                        }else{
                            print("Proposition not added")
                        }
                    }else{ //On ajoute seulement un propos
                        let idProp = PropositionModel.addProposition(titleProp : self.titleProposition, contentPub: self.newProposition, isAnonymous: self.anonymousProposition, tagsProp: self.tagList, token: self.fk.token)
                        if idProp != "noId" {
                            print("Proposition added")
                        }
                        else{
                            print("Proposition not added")
                        }
                    }
                    
                    self.fk.currentPage = "Accueil"
                }){
                    Text("Envoyer").bold().padding(15)
                    
                }.foregroundColor(Color.white).background(LinearGradient(gradient: Gradient(colors: [.yellow, .pink]), startPoint: .leading, endPoint: .trailing)).cornerRadius(40)
            }.padding(20)
        }.padding(.top,80)
    }
}

func containsLabel(tags : [Tag], label : String) -> Bool{
    for tag in tags{
        if tag.label.elementsEqual(label){
            return true
        }
    }
    return false
}

struct AddProposition_Previews: PreviewProvider {
    static var previews: some View {
        AddProposition().environmentObject(FilterKit())
    }
}
