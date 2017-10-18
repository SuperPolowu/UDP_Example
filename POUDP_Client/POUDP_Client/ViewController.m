//
//  ViewController.m
//  POUDP_Client
//
//  Created by Polo on 2017/10/17.
//  Copyright © 2017年 Polo. All rights reserved.
//

#import "ViewController.h"
static AsyncUdpSocket *asyncUdpSocket;
@interface ViewController ()

@end

@implementation ViewController{
    NSString *tempResponse;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUDPSocketFromPort:5274];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark  IBAction

- (IBAction)btn_Save_Action:(id)sender {
    [self initUDPSocketFromPort:[_tf_Port.text intValue]];
    [_tf_Port resignFirstResponder];
}
#pragma mark -
#pragma mark  Private

-(void)initUDPSocketFromPort:(int)port{
    if (asyncUdpSocket) {
        [asyncUdpSocket close];
        asyncUdpSocket=nil;
    }
    _tf_Port.text=[NSString stringWithFormat:@"%d",port];
    asyncUdpSocket = [[AsyncUdpSocket alloc] initWithDelegate: self ];
    NSError  *err = nil ;
    [asyncUdpSocket enableBroadcast: YES  error:&err];
    [asyncUdpSocket bindToPort:port error:&err];
    NSLog(@"err %@",err);
    [asyncUdpSocket receiveWithTimeout:-1 tag:0];

}
- (void)appendLog:(NSString*)text{
    [_txt_Message setText:[NSString stringWithFormat:@"%@%@\n", _txt_Message.text, text]];
    [_txt_Message scrollRangeToVisible:NSMakeRange([_txt_Message.text length], 0)];
}
#pragma mark - UDP  Delegate
//已接收到消息
- ( BOOL )onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:( NSData  *)data withTag:( long )tag fromHost:( NSString  *)host port:(UInt16)port{
      NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (![tempResponse isEqualToString:response]) {
        tempResponse=response;
        [self appendLog:response];
        NSLog(@"已接收到消息 %@",response);
        NSLog(@"tag %ld",tag);
    }
    


    return NO;
}
//沒有接受到消息
-( void )onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:( long )tag dueToError:( NSError  *)error{
    NSLog(@"沒有接受到消息");
}
//沒有發送出消息
-( void )onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:( long )tag dueToError:( NSError  *)error{
    NSLog(@"沒有發送出消息");
}
//已發送出消息
-( void )onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:( long )tag{
    NSLog(@"已發送出消息");
}
//斷開連接
-( void )onUdpSocketDidClose:(AsyncUdpSocket *)sock{
    NSLog(@"斷開連接");
}

@end
