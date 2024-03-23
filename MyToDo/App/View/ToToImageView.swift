//
//  ToToImageView.swift
//  MyToDo
//
//  Created by Girish Parate on 23/03/24.
//

import SwiftUI

struct ToToImageView: View {
    var imageUrl: String = ""
    var body: some View {
        Section {
            AsyncImage(url: URL(string: AppConst.todoimagesPath + (imageUrl))) { image in
                image.resizable()
                    .scaledToFit()
                    .cornerRadius(6)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct ToToImageView_Previews: PreviewProvider {
    static var previews: some View {
        ToToImageView()
    }
}
