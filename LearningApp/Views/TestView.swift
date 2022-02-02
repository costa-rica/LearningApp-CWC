//
//  TestView.swift
//  LearningApp
//
//  Created by Nick on 2/1/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack {
                //Question Number
                
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                //Question
                CodeTextView()
                
                //Answers
                //button
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            ProgressView()//This is a spinning view that eventually calls the .onAppear from "destination: TestView().onAppear(perform:" in HomeView
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
