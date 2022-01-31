//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Nick on 1/29/22.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius:5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
                //aspectRatio fills up as much of screen as CGsize dictates with same aspectRatio wihotut goign over screensize
                //.frame(width:335, height: 175)
            HStack{
                
                //Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                //Text
                VStack (alignment:.leading, spacing: 10){
                    //Headline
                    Text(title)
                        .bold()
                    //Description
//                    Text("IS this not aligning?")
                    VStack (alignment:.leading){
                        Text(description)
                            .padding(.bottom, 20)
                            .font(Font.system(size:8))
                    }

                    
                    //Icons
                    HStack{
                        Image(systemName:"text.book.closed")
                            .resizable()
                            .frame(width:15, height:15)
                        Text(count)
                            .font(Font.system(size:10))
                        
                        Spacer()
                        
                        //Time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width:15, height:15)
                        Text(time)
                            .font(.caption)
                    }
                    
                }
                .padding(.leading,20)
            }
            .padding(.horizontal,20)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Switft", description: "Some description", count: "20 Lessons", time: "2  hours")
    }
}
