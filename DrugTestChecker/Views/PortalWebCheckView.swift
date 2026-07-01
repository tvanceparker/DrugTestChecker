//
//  PortalWebCheckView.swift
//  DrugTestChecker
//
//  Created by Taylor Vance Parker on 7/1/26.
//

import SwiftUI
import WebKit

struct PortalWebCheckView: UIViewRepresentable {
    let pin: String
    let lastNameCode: String
    let onResult: (String) -> Void

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        if let url = URL(string: "https://www.drugtestcheck.com") {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(
            pin: pin,
            lastNameCode: lastNameCode,
            onResult: onResult
        )
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        let pin: String
        let lastNameCode: String
        let onResult: (String) -> Void

        private var didSubmitForm = false

        init(
            pin: String,
            lastNameCode: String,
            onResult: @escaping (String) -> Void
        ) {
            self.pin = pin
            self.lastNameCode = lastNameCode
            self.onResult = onResult
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if didSubmitForm {
                extractResult(from: webView)
            } else {
                submitForm(in: webView)
                didSubmitForm = true
            }
        }
        private func submitForm(in webView: WKWebView) {
            let script = """
            document.getElementById('callInputCode').value = '\(pin)';
            document.getElementById('lettersInputLastName').value = '\(lastNameCode)';
            document.querySelector('button[type="submit"]').click();
            """

            webView.evaluateJavaScript(script)
        }

        private func extractResult(from webView: WKWebView) {
            let script = """
            document.querySelector('label[for="reply"]')?.innerText ?? ''
            """

            webView.evaluateJavaScript(script) { result, error in
                if let error {
                    print("Failed to extract portal result: \\(error)")
                    return
                }

                if let text = result as? String, !text.isEmpty {
                    DispatchQueue.main.async {
                        self.onResult(text)
                    }
                }
            }
        }
    }
}
