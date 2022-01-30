//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Nick on 1/30/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        
        ZStack (alignment:.leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius:5)
                .aspectRatio(CGSize(width: 335, height: 75), contentMode: .fit)
            HStack (spacing:30){
                Text(String(index + 1))
                    .font(Font.system(size:15))
                    .bold()
                VStack(alignment: .leading){
                    Text(lesson.title)
                        .bold()
                        .font(.headline)
                    Text("Video - \(lesson.duration)")
                        .font(.caption)
                }
            }
            .padding()
        }
        .padding(.bottom,10)
    }
}

