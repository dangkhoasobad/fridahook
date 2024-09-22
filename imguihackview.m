#import <UIKit/UIKit.h>
#import "imgui.h"
#import <Foundation/Foundation.h>

@interface ImGuiViewController : UIViewController {
    BOOL camXaEnabled;
    BOOL hackMapEnabled;
    BOOL showRankEnabled;
    BOOL showUltiEnabled;
}

@end

@implementation ImGuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Thiết lập ImGui ở đây
}

- (void)render {
    // Vẽ giao diện ImGui
    ImGui::Begin("Hack Menu");

    if (ImGui::Checkbox("Hack Map", &hackMapEnabled)) {
        if (hackMapEnabled) {
            [self sendFridaPatchRequest:@"hack_map"]; // Gửi yêu cầu tới Frida để patch Hack Map
        }
    }

    if (ImGui::Checkbox("Cam Xa", &camXaEnabled)) {
        if (camXaEnabled) {
            [self sendFridaPatchRequest:@"cam_xa"]; // Gửi yêu cầu tới Frida để patch Cam Xa
        }
    }

    if (ImGui::Checkbox("Hiện Rank", &showRankEnabled)) {
        if (showRankEnabled) {
            [self sendFridaPatchRequest:@"show_rank"]; // Gửi yêu cầu tới Frida để patch Hiện Rank
        }
    }

    if (ImGui::Checkbox("Hiện Ulti", &showUltiEnabled)) {
        if (showUltiEnabled) {
            [self sendFridaPatchRequest:@"show_ulti"]; // Gửi yêu cầu tới Frida để patch Hiện Ulti
        }
    }

    ImGui::End();
}

// Hàm gửi yêu cầu tới Frida thông qua NSURLSession hoặc WebSocket
- (void)sendFridaPatchRequest:(NSString *)functionName {
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:27042/%@", functionName]; // Kết nối tới Frida server
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error sending patch request: %@", error.localizedDescription);
        } else {
            NSLog(@"Patch request for %@ sent successfully", functionName);
        }
    }];
    [dataTask resume];
}

@end
