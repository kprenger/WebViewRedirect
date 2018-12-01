# WebViewRedirect
Redirects weren't working properly inside a WebView on a project that a colleague was working on. Made this quick test to show the navigational flow opening the link and to figure out the issue. Long story short, it was simply an ATS issue.

**Note**: if you simply load the `index.html` as a local file, it won't work, as the original bit.ly link has a few redirects that end up breaking the WebView. You will need to use `ngrok` paired with python's `SimpleHttpServer` to quickly host `index.html` locally and give it an external URL to replicate accessing the page via the internet. 

Basic steps to do this are:

1. Run `python -m SimpleHTTPServer` from the directory that has `index.html`. This will locally host your web page on port 8000.
2. Run `ngrok http 8000` will create an external URL that connects to your locally hosted web page.
3. Load the ngrok URL from within the WKWebView to simulate an external web load.
