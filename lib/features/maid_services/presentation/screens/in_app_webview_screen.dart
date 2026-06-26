import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../../resources/app_colors.dart';

/// In-app WebView screen utilizing the flutter_inappwebview package.
class InAppWebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const InAppWebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  double _progress = 0.0;
  // ignore: unused_field
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: AppColors.line),
        ),
        bottom: _progress < 1.0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3.0),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.transparent,
                  color: AppColors.primary,
                  minHeight: 3.0,
                ),
              )
            : null,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) async {
          await controller.injectCSSCode(source: "header, footer { display: none !important; }");
        },
        onLoadStop: (controller, url) async {
          await controller.injectCSSCode(source: "header, footer { display: none !important; }");
          await controller.evaluateJavascript(source: """
            var header = document.querySelector('header');
            if (header) header.style.display = 'none';
            var footer = document.querySelector('footer');
            if (footer) footer.style.display = 'none';

            function hideFloatingSalaryButton() {
              var all = document.getElementsByTagName('*');
              for (var i = 0; i < all.length; i++) {
                var el = all[i];
                var style = window.getComputedStyle(el);
                if (style.position === 'fixed' || style.position === 'sticky') {
                  var txt = (el.innerText || el.textContent || '').toLowerCase();
                  var hasTargetText = txt.includes('salary') || 
                                      txt.includes('calculator') || 
                                      txt.includes('helper') || 
                                      txt.includes('estimate') ||
                                      txt.includes('call now') ||
                                      txt.includes('whatsapp') ||
                                      txt.includes('call us') ||
                                      txt.includes('chat now');
                  
                  var hasTargetLink = false;
                  var links = el.getElementsByTagName('a');
                  for (var j = 0; j < links.length; j++) {
                    var href = links[j].getAttribute('href') || '';
                    if (href.startsWith('tel:') || href.includes('wa.me') || href.includes('whatsapp')) {
                      hasTargetLink = true;
                      break;
                    }
                  }

                  if (hasTargetText || hasTargetLink) {
                    el.style.setProperty('display', 'none', 'important');
                  }
                }
              }
            }
            hideFloatingSalaryButton();
            // Periodically check in case React re-renders or updates the DOM
            setInterval(hideFloatingSalaryButton, 300);
          """);
        },
        onProgressChanged: (controller, progress) {
          setState(() {
            _progress = progress / 100;
          });
        },
      ),
    );
  }
}
