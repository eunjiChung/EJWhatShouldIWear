//
//  EJKisangWeekelyModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public enum EJDataType: String, Decodable {
    case JSON
    case XML
}

public struct EJKisangBodyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case dataType
        case items
        case pageNo
        case numOfRows
        case totalCount
    }
    
    var dataType: EJDataType
    var items: EJKisangItemsModel
    var pageNo: Int
    var numOfRows: Int
    var totalCount: Int
}

public struct EJKisangItemsModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case item
    }
    
    // TODO: - API에 따라 item model 바꾸기
    var item: [EJKisangItemModel] 
}

public struct EJKisangItemModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case regId
        case taMin3, taMin3Low, taMin3High
        case taMax3, taMax3Low, taMax3High
        case taMin4, taMin4Low, taMin4High
        case taMax4, taMax4Low, taMax4High
        case taMin5, taMin5Low, taMin5High
        case taMax5, taMax5Low, taMax5High
        case taMin6, taMin6Low, taMin6High
        case taMax6, taMax6Low, taMax6High
        case taMin7, taMin7Low, taMin7High
        case taMax7, taMax7Low, taMax7High
        case taMin8, taMin8Low, taMin8High
        case taMax8, taMax8Low, taMax8High
        case taMin9, taMin9Low, taMin9High
        case taMax9, taMax9Low, taMax9High
        case taMin10, taMin10Low, taMin10High
        case taMax10, taMax10Low, taMax10High
    }
    
    var regId: String
    var taMin3: Int
    var taMin3Low: Int
    var taMin3High: Int
    var taMax3: Int
    var taMax3Low: Int
    var taMax3High: Int
    var taMin4: Int
    var taMin4Low: Int
    var taMin4High: Int
    var taMax4: Int
    var taMax4Low: Int
    var taMax4High: Int
    var taMin5: Int
    var taMin5Low: Int
    var taMin5High: Int
    var taMax5: Int
    var taMax5Low: Int
    var taMax5High: Int
    var taMin6: Int
    var taMin6Low: Int
    var taMin6High: Int
    var taMax6: Int
    var taMax6Low: Int
    var taMax6High: Int
    var taMin7: Int
    var taMin7Low: Int
    var taMin7High: Int
    var taMax7: Int
    var taMax7Low: Int
    var taMax7High: Int
    var taMin8: Int
    var taMin8Low: Int
    var taMin8High: Int
    var taMax8: Int
    var taMax8Low: Int
    var taMax8High: Int
    var taMin9: Int
    var taMin9Low: Int
    var taMin9High: Int
    var taMax9: Int
    var taMax9Low: Int
    var taMax9High: Int
    var taMin10: Int
    var taMin10Low: Int
    var taMin10High: Int
    var taMax10: Int
    var taMax10Low: Int
    var taMax10High: Int
}

