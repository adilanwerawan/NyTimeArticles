//
//  NyArticleDetails.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 26/06/2024.
//

import SwiftUI

struct NyArticleDetails: View {
    
    @StateObject public var vm:NyArticleDetailViewModel
    
    public init(viewModel: NyArticleDetailViewModel) {
        self._vm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    AsyncImage(url: URL(string: self.vm.photoUrl())) { phase in
                        if let image = phase.image {
                            // Display the loaded image
                            image
                                .resizable()
                                .padding(5)
                                .aspectRatio(contentMode: .fit)
                        } else if phase.error != nil {
                            // Display a placeholder when loading failed
                            Image(systemName: "questionmark.diamond")
                                .imageScale(.large)
                                .padding(5)
                        } else {
                            // Display a placeholder while loading
                            ProgressView()
                        }
                    }
                    .padding(5)
                    Spacer()
                    HStack{
                        Spacer()
                        Text(self.vm.publishedDate)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                    .padding(5)
                    Text(self.vm.articleTitle)
                        .font(.body)
                        .foregroundStyle(Color.primary)
                        .frame(alignment: .leading)
                    Text(self.vm.abstractField)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.primary)
                    Text(self.vm.byLine)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                    Link("More..", destination: URL(string: self.vm.url)!)
                }
                .padding(10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text(self.vm.title)
                    .font(.title)
                    .foregroundColor(.primary)
            }
        }
    }
}
