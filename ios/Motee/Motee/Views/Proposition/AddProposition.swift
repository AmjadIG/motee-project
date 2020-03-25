//
//  AddProposition.swift
//  Motee
//
//  Created by Amjad Menouer on 02/03/2020.
//  Copyright © 2020 groupe3. All rights reserved.
//
import SwiftUI

struct AddProposition: View {
    var currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
    @EnvironmentObject var fk : FilterKit
    @State var newProposition : String = ""
        @State var newAnswer : String = ""
        @State var newTag : String = ""
        @State var tagList : [Tag] = []
        @State var anonymousProposition : Bool = false
        @State var answerAdding : Bool = false
        @State var anonymousAnswer : Bool = false
        
        var body: some View {
            VStack{
                Title(myTitle: "Ajouter un propos")
                Divider()
                ScrollView{
                    //Text("Votre Propos").font(.system(size: 18)).bold().foregroundColor(.blue).padding()
                    FieldGenerator.plain(label: "Propos :",field: "Ecrivez votre propos", text: $newProposition)
                    HStack{
                        FieldGenerator.plain(label: "Ajouter un nouveau tag :",field: "Votre tag", text: $newTag)
                        
                        Button(action:{
                            if self.newTag.count>0 && !(containsLabel(tags: self.tagList, label: self.newTag)){
                                self.tagList.append(Tag(label: self.newTag))
                                self.newTag = ""
                            }
                        }){
                            SymbolGenerator(mySymbol: "arrowtriangle.right.circle.fill", myColor: "blue")
                        }
                    }
                    if(tagList.count>0){
                        TagListView(tagList: $tagList)
                    }
                    Toggle(isOn : $anonymousProposition){
                        Text("Propos anonyme")
                    }
                    Divider()
                    Toggle(isOn : $answerAdding){
                        Text("Proposer une réponse ?")
                    }
                    if answerAdding {
                        Text("Votre Reponse").font(.system(size: 18)).bold().foregroundColor(.blue).padding()
                        TextField("Ecrivez votre reponse", text: $newAnswer).padding()
                        Toggle(isOn : $anonymousAnswer){
                            Text("Propos anonyme")
                        }
                    }
                    Divider().padding()
                    Button(action:{
                        var noError = PropositionModel.addProposition(contentPub: self.newProposition, isAnonymous: self.anonymousProposition, tagsProp: self.tagList, token: self.fk.token)
                        if noError {
                            self.fk.currentPage = "home"
                        }
                    }){
                        Text("Envoyer").bold().padding(15)
                        
                    }.foregroundColor(Color.white).background(Color.blue).cornerRadius(40)
                }.padding(20)
            }
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

