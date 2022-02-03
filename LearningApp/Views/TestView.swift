//
//  TestView.swift
//  LearningApp
//
//  Created by Nick on 2/1/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack (alignment: .leading) {
                
                //Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                //Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                //Answers
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) {index in
                            Button {
                                //Track which answer is selected
                                selectedAnswerIndex=index
                            } label: {
                                ZStack {
                                    
                                    if submitted == false {
                                        //in line if statement
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height:48)
                                       
                                    }
                                    else {
                                        //Answer has been submitted
                                        
                                        //User selected right answer
                                        if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex {
                                            
                                            //Show a green background
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        //User selected wrong anser
                                        else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            
                                        //Show a red background
                                        RectangleCard(color: Color.red)
                                            .frame(height: 48)
                                        }
                                        //shows correct answer
                                        else if index == model.currentQuestion!.correctIndex {
                                            //show greenbackground
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else {
                                            RectangleCard(color: Color.white)
                                                .frame(height:48)
                                        }
                                        
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                //Submit button
                Button{
                    //Check if answer has been submitted
                    if submitted == true {
                        //Answer has already been submitted, move to next question
                        model.nextQuestion()
                        
                        //Reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    }
                    else {
                        //Change submitted state to true
                        submitted = true
                        
                        // Check the answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }

                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        //Change text from submit to next question using computed property
                        Text(buttonText)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            ProgressView()//This is a spinning view that eventually calls the .onAppear from "destination: TestView().onAppear(perform:" in HomeView
        }
    }
    
    var buttonText:String {
        //check if answer has been submitted
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish"
            }
            else {
                return "Next"
            }
            
        }
        else {
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
