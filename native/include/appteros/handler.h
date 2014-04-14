#pragma once

#include "include/cef_client.h"
#include <list>


class AppterosHandler : public CefClient,
                        public CefDisplayHandler,
                        public CefLifeSpanHandler,
                        public CefLoadHandler  {
  public:
    AppterosHandler();
    ~AppterosHandler();

    static AppterosHandler* GetInstance();

    // CefClient methods:
    virtual CefRefPtr<CefDisplayHandler> GetDisplayHandler() OVERRIDE {
      return this;
    }
    virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() OVERRIDE {
      return this;
    }
    virtual CefRefPtr<CefLoadHandler> GetLoadHandler() OVERRIDE {
      return this;
    }

    // CefDisplayHandler methods:
    virtual void OnTitleChange(CefRefPtr<CefBrowser> browser,
                               const CefString& title) OVERRIDE;

    // CefLifeSpanHandler methods:
    virtual void OnAfterCreated(CefRefPtr<CefBrowser> browser) OVERRIDE;
    virtual void OnBeforeClose(CefRefPtr<CefBrowser> browser) OVERRIDE;

    // CefLoadHandler methods:
    virtual void OnLoadError(CefRefPtr<CefBrowser> browser,
                             CefRefPtr<CefFrame> frame,
                             ErrorCode errorCode,
                             const CefString& errorText,
                             const CefString& failedUrl) OVERRIDE;

    // Request that all existing browser windows close.
    void CloseAllBrowsers(bool force_close);

  private:
    // List of existing browser windows. Only accessed on the CEF UI thread.
    typedef std::list<CefRefPtr<CefBrowser> > BrowserList;
    BrowserList browser_list_;

    // Include the default reference counting implementation.
    IMPLEMENT_REFCOUNTING(AppterosHandler);
};
