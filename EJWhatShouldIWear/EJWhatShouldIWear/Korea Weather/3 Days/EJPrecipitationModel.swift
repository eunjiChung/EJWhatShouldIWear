//
//  EJPrecipitationModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJPrecipitationModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type4hour = "type4hour"
        case prob4hour = "prob4hour"
        case type7hour = "type7hour"
        case prob7hour = "prob7hour"
        case type10hour = "type10hour"
        case prob10hour = "prob10hour"
        case type61hour = "type61hour"
        case type49hour = "type49hour"
        case prob52hour = "prob52hour"
        case type64hour = "type64hour"
        case prob49hour = "prob49hour"
        case type40hour = "type40hour"
        case type46hour = "type46hour"
        case prob61hour = "prob61hour"
        case type22hour = "type22hour"
        case type25hour = "type25hour"
        case prob46hour = "prob46hour"
        case prob22hour = "prob22hour"
        case prob67hour = "prob67hour"
        case type16hour = "type16hour"
        case prob64hour = "prob64hour"
        case type34hour = "type34hour"
        case prob25hour = "prob25hour"
        case type31hour = "type31hour"
        case prob19hour = "prob19hour"
        case prob40hour = "prob40hour"
        case type19hour = "type19hour"
        case type43hour = "type43hour"
        case prob16hour = "prob16hour"
        case type13hour = "type13hour"
        case type28hour = "type28hour"
        case type52hour = "type52hour"
        case type55hour = "type55hour"
        case prob13hour = "prob13hour"
        case prob28hour = "prob28hour"
        case type58hour = "type58hour"
        case prob37hour = "prob37hour"
        case prob34hour = "prob34hour"
        case type67hour = "type67hour"
        case prob55hour = "prob55hour"
        case prob58hour = "prob58hour"
        case prob31hour = "prob31hour"
        case type37hour = "type37hour"
        case prob43hour = "prob43hour"
    }
    
    // MARK: Properties
    public var type61hour: String?
    public var type49hour: String?
    public var prob7hour: String?
    public var prob52hour: String?
    public var type64hour: String?
    public var prob49hour: String?
    public var type40hour: String?
    public var type46hour: String?
    public var type4hour: String?
    public var prob61hour: String?
    public var type22hour: String?
    public var type25hour: String?
    public var prob46hour: String?
    public var prob22hour: String?
    public var type7hour: String?
    public var prob67hour: String?
    public var type16hour: String?
    public var prob64hour: String?
    public var type34hour: String?
    public var type10hour: String?
    public var prob25hour: String?
    public var type31hour: String?
    public var prob19hour: String?
    public var prob40hour: String?
    public var type19hour: String?
    public var type43hour: String?
    public var prob16hour: String?
    public var type13hour: String?
    public var prob4hour: String?
    public var type28hour: String?
    public var type52hour: String?
    public var prob10hour: String?
    public var type55hour: String?
    public var prob13hour: String?
    public var prob28hour: String?
    public var type58hour: String?
    public var prob37hour: String?
    public var prob34hour: String?
    public var type67hour: String?
    public var prob55hour: String?
    public var prob58hour: String?
    public var prob31hour: String?
    public var type37hour: String?
    public var prob43hour: String?
}
