//
//  AssetMenuButtonStyle.swift
//  MyAsset
//
//  Created by 강태준 on 2022/08/17.
//

import SwiftUI

struct AssetMenuButtonStyle: ButtonStyle {
    let menu: AssetMenu
    
    func makeBody(configuration: Configuration) -> some View {
        return VStack {
            Image(systemName: menu.systemImageName)
                .resizable()
                .frame(width: 30, height: 30)
                .padding([.leading, .trailing], 10)
            Text(menu.title)
                .font(.system(size: 12, weight: .bold))
                .scaledToFill()
        }
        .padding()
        .foregroundColor(.blue)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct AssetMenuButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 24) {
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: AssetMenu.creditScore))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: AssetMenu.bankAccount))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: AssetMenu.creditCard))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: AssetMenu.cash))
        }
        .background(.gray.opacity(0.2))
    }
}
