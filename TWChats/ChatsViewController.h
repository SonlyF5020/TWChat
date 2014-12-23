#import <UIKit/UIKit.h>

@interface ChatsViewController : UIViewController
            <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) NSDictionary *chatWith;


@end
