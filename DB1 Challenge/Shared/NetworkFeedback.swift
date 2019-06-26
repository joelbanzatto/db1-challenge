import UIKit

class NetworkFeedback {
    static let shared = NetworkFeedback()

    internal func setNetworkActivityIndicator(visible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }

    public func startLoading() {
        setNetworkActivityIndicator(visible: true)
    }

    public func stopLoading() {
        setNetworkActivityIndicator(visible: false)
    }
}
