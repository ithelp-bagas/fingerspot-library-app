function backToMainApp() {
    if (window.flutter_inappwebview) {
        window.flutter_inappwebview.callHandler('finishActivity');
    }
}