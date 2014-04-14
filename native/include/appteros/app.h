#pragma once

#include <appteros/util.h>
#include "include/cef_app.h"

class AppterosApp : public CefApp,
                    public CefBrowserProcessHandler {
  public:
    AppterosApp();

    virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler()
        OVERRIDE { return this ; }

    virtual void OnContextInitialized() OVERRIDE;
  
  private:
    IMPLEMENT_REFCOUNTING(AppterosApp);
};

