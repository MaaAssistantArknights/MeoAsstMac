//
//  MallConfiguration.swift
//  MAA
//
//  Created by hguandl on 16/4/2023.
//

import Foundation

struct MallConfiguration: MAATaskConfiguration {
    var type: MAATaskType { .Mall }

    var shopping = true
    var buy_first = ["招聘许可", "龙门币"]
    var blacklist = ["加急许可", "家具零件"]
    var force_shopping_if_credit_full = true

    var title: String {
        type.description
    }

    var subtitle: String {
        if shopping {
            return NSLocalizedString("购物", comment: "")
        } else {
            return NSLocalizedString("不购物", comment: "")
        }
    }

    var summary: String {
        buy_first.joined(separator: ";")
    }

    var projectedTask: MAATask {
        .mall(self)
    }

    typealias Params = Self

    var params: Self {
        self
    }
}
