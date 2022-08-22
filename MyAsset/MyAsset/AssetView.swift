//
//  AssetView.swift
//  MyAsset
//
//  Created by 강태준 on 2022/08/17.
//

import SwiftUI

struct AssetView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    AssetMenuGridView()
                    AssetBannerView()
                        .aspectRatio(2, contentMode: .fit)
                    AssetSummaryView()
                        .environmentObject(AssetSummaryData())
                }
            }
            .background(.gray.opacity(0.2))
            .navigationBarWithButton(title: "내 자산")
        }
    }
}

struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView()
    }
}
