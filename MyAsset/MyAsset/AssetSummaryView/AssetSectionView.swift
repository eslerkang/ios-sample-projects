//
//  AssetSectionView.swift
//  MyAsset
//
//  Created by 강태준 on 2022/08/22.
//

import SwiftUI

struct AssetSectionView: View {
    @ObservedObject var assetSection: Asset
    
    var body: some View {
        VStack(spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(
            id: 0,
            type: .bankAccount,
            data: [
                AssetData(id: 0, title: "신한은행", amount: "4,000,000원"),
                AssetData(id: 1, title: "카카오뱅크", amount: "54,000,000원"),
                AssetData(id: 2, title: "토스뱅크", amount: "521,000,000원"),
            ]
        )
        AssetSectionView(assetSection: asset)
    }
}
