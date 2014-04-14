#import <appteros/delegate.h>

#include <appteros/handler.h>
#include <appteros/util.h>


@implementation AppterosDelegate

// Create the application on the UI thread.
- (void)createApp:(id)object {
  [NSApplication sharedApplication];
  // [NSBundle loadNibNamed:@"MainMenu" owner:NSApp];
  // if ([[NSBundle mainBundle] respondsToSelector:@selector(loadNibNamed:owner:topLevelObjects:)]) {
    // We're running on Mountain Lion or higher
  [[NSBundle mainBundle] loadNibNamed:@"MainMenu"
                                      owner:self
                            topLevelObjects:nil];
  // } else {
  //   // We're running on Lion
  //   [NSBundle loadNibNamed:@"MainMenu"
  //             owner:self];
  // }

  // Set the delegate for application events.
  [NSApp setDelegate:self];
}

// Called when the application's Quit menu item is selected.
- (NSApplicationTerminateReply)applicationShouldTerminate:
      (NSApplication *)sender {
  NSLog(@"Some code here");
  // Request that all browser windows close.
  if (AppterosHandler* handler = AppterosHandler::GetInstance()) 
    handler->CloseAllBrowsers(false);
  else 
    NSLog(@"Some code there");

  // Cancel the termination. The application will exit after all windows have
  // closed.
  return NSTerminateCancel;
}

// Sent immediately before the application terminates. This signal should not
// be called because we cancel the termination.
- (void)applicationWillTerminate:(NSNotification *)aNotification {
  ASSERT(false);  // Not reached.
}

@end
