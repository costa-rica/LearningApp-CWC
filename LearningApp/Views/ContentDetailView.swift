//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Nick on 1/30/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? noVideo()))
        
        //lesson?.vidoe ?? "" is the option that in case lesson has not been set yet (i'm guessing becuase perhaps a user can click quicker than the program will load) then the video will just show as blank.
        VStack {
            if url != nil {
                VideoPlayer(player: AVPlayer(url:url!))
            }
            // Description
            CodeTextView()
            
            //Show next lesson button, only if there is a next lesson
            if model.hasNextLesson() {
                // next lesson button
                Button(action: {
                    //Advance lesson
                    model.nextLesson()
                }, label:{
                    //Make resuable rectangle
                    ZStack {
                        Rectangle()
                            .frame(height:48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius:5)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
            else {
                //Show the complete button instead
                Button(action: {
                    //Take the user back to the homeview
                    model.currentContentSelected = nil
                    
                }, label:{
                    //Make resuable rectangle
                    ZStack {
                        Rectangle()
                            .frame(height:48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius:5)
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }

            
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")

        
    }
    //MARK: function by NR
    func noVideo() -> String {
        print("no video was retrieved")
        return ""
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
