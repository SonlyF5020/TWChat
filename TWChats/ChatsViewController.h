#import <UIKit/UIKit.h>

@interface ChatsViewController : UIViewController
            <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSDictionary *chatWith;


@end
