//
//  CustomerReviewView.swift
//  DealsApp
//
//  Created by Ngoc Nguyen on 7/11/23.
//

import SwiftUI

struct CustomerReviewView: View {
    let deal: Deal
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            HStack{
                VStack{
                    AsyncImage(url: URL(string: deal.product.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .cornerRadius(30)
                .padding(15)
                .shadow(radius: 10)
                
                VStack{
                    Spacer()
                    HStack{
                        Image(systemName: "hand.thumbsup")
                            .font(.system(size: 30))
                        Text("\(deal.likes.count) Likes")
                            .font(.system(size: 20))
                            .underline()
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "hand.thumbsdown")
                            .font(.system(size: 30))
                        Text("\(deal.dislikes.count) Dislikes")
                            .font(.system(size: 20))
                            .underline()
                        Spacer()
                    }
                    Spacer()

                    HStack{
                        Image(systemName: "message")
                            .font(.system(size: 30))
                        Text("\(deal.comments.count) Comments")
                            .font(.system(size: 20))
                            .underline()
                        Spacer()
                    }
                    Spacer()

                }
                Spacer()
            }
            VStack{
                ForEach(deal.comments){ comment in
                    HStack{
                        VStack{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 100)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        VStack(alignment: .leading){
                            HStack{
                                Text("\(comment.user.name)")
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.bottom, 2)
                                
                                Text("\(formatDate(timestamp: Double(comment.createdAt) ?? 0.0))")
                            }
                            Text("\(comment.text)")
                        }
                        Spacer()
                    }
                    .padding()
                }
                
                Button {
                    path.removeLast(path.count)
                } label: {
                    Text("Go Home")
                }
            }
        }
    }
}



//struct CustomerReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerReviewView()
//    }
//}
