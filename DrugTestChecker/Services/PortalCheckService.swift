//
//  PortalCheckService.swift
//  DrugTestChecker/Services
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import Foundation
import DrugTestCheckerCore

struct PortalCheckResult {
    let status: DrugTestStatus
    let rawPortalText: String
    let url: String?
    let pageTitle: String?
    let isSuccess: Bool
}

struct PortalCheckService {
    func parseResult(
        portalText: String,
        url: String? = "https://www.drugtestcheck.com",
        pageTitle: String? = nil
    ) -> PortalCheckResult {
        let status = PortalResultParser.parseStatus(from: portalText)

        return PortalCheckResult(
            status: status,
            rawPortalText: portalText,
            url: url,
            pageTitle: pageTitle,
            isSuccess: status != .unknown && status != .error
        )
    }
}
