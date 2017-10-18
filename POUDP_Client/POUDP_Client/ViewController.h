//
//  ViewController.h
//  POUDP_Client
//
//  Created by Polo on 2017/10/17.
//  Copyright © 2017年 Polo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POTextField.h"
#import "POButton.h"
#import "AsyncUdpSocket.h"
@interface ViewController : UIViewController<AsyncUdpSocketDelegate>
@property (weak, nonatomic) IBOutlet POTextField *tf_Port;
@property (weak, nonatomic) IBOutlet POButton *btn_Save;
@property (weak, nonatomic) IBOutlet UITextView *txt_Message;


@end

