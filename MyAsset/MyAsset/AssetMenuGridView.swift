//
//  AssetMenuGridView.swift
//  MyAsset
//
//  Created by 강태준 on 2022/08/17.
//

import SwiftUI

struct AssetMenuGridView: View {
    static let menuList: [[AssetMenu]] = [
        [.creditScore, .bankAccount, .investment, .loan],
        [.insurance, .creditCard, .cash, .realEstate]
    ]
    var body: some View {
        VStack(spacing: 20) {
            ForEach(Self.menuList, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { menu in
                        Button("") {
                            print("\(menu.title) button tapped")
                        }
                        .buttonStyle(AssetMenuButtonStyle(menu: menu))
                    }
                }
            }
        }
    }
}

struct AssetMenuGridView_Previews: PreviewProvider {
    static var previews: some View {
        AssetMenuGridView()
    }
}
