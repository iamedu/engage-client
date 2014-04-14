#import <appteros/delegate.h>

#include <appteros/app.h>
#include "include/cef_application_mac.h"

// Provide the CefAppProtocol implementation required by CEF.
@interface AppterosApplication : NSApplication<CefAppProtocol> {
@private
  BOOL handlingSendEvent_;
}
@end

@implementation AppterosApplication
- (BOOL)isHandlingSendEvent {
  return handlingSendEvent_;
}

- (void)setHandlingSendEvent:(BOOL)handlingSendEvent {
  handlingSendEvent_ = handlingSendEvent;
}

- (void)sendEvent:(NSEvent*)event {
  CefScopedSendingEvent sendingEventScoper;
  [super sendEvent:event];
}
@end

int main(int argc, char *argv[]) {
    CefMainArgs main_args(argc, argv);
    CefRefPtr<AppterosApp> app(new AppterosApp);

    NSAutoreleasePool* autopool = [[NSAutoreleasePool alloc] init];
    [AppterosApplication sharedApplication];

    CefSettings settings;
    CefInitialize(main_args, settings, app.get(), NULL);

    NSObject* delegate = [[AppterosDelegate alloc] init];
    [delegate performSelectorOnMainThread:@selector(createApp:) withObject:nil
                            waitUntilDone:NO];
    CefRunMessageLoop();

    CefShutdown();

    [delegate release];
    [autopool release];

    return 0;
}

