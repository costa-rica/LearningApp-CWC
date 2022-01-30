//
//  LessonScreen.swift
//  LearningApp
//
//  Created by Nick on 1/30/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
//    var module: Module
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    LazyVStack{
                        //Confirm that currentModule is set
                        if model.currentModule != nil {
                            ForEach(0..<model.currentModule!.content.lessons.count) { index in
                                
                                ContentViewRow(index: index)
                            }
                        }

                    }
                    .padding()
                    .navigationTitle("Learn \(model.currentModule?.category ?? "")")
                }
            }
            
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ContentView()
//            .environmentObject(ContentModel())
//    }
//}
