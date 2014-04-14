#include <appteros/app.h>
#include <appteros/handler.h>
#include <string>

AppterosApp::AppterosApp() {
}

void AppterosApp::OnContextInitialized() {
  REQUIRE_UI_THREAD();

  CefWindowInfo window_info;

  CefRefPtr<AppterosHandler> handler(new AppterosHandler());

  CefBrowserSettings browser_settings;
  std::string url = "http://www.google.com";

  CefBrowserHost::CreateBrowserSync(window_info, handler.get(), url,
                                    browser_settings, NULL);

}
