//
//  ViewController.m
//  POUDP_Server
//
//  Created by Polo on 2017/10/17.
//  Copyright © 2017年 Polo. All rights reserved.
//

#import "ViewController.h"

static AsyncUdpSocket *asyncUdpSocket;
@interface ViewController ()

@end

@implementation ViewController{
    int count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initUDPSocket];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_Sent_Action:(id)sender {
    NSData *data = [[NSString stringWithFormat:@"test %d",++count]dataUsingEncoding:NSUTF8StringEncoding];
    [asyncUdpSocket sendData:data
                      toHost:@"255.255.255.255"
                        port:6000
                 withTimeout:-1
                         tag:0];
 
}

#pragma mark -
#pragma mark  Private

-(void)initUDPSocket{
    
    count=0;
    
    asyncUdpSocket = [[AsyncUdpSocket alloc] initWithDelegate: self ];
    NSError  *err = nil ;
    [asyncUdpSocket localPort];
    [asyncUdpSocket enableBroadcast: YES  error:&err];
    [asyncUdpSocket bindToPort:6000 error:&err];
    NSLog(@"err %@",err);
    [asyncUdpSocket receiveWithTimeout:-1 tag:0];
    
}
#pragma mark - UDP  Delegate
//已接收到消息
- ( BOOL )onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:( NSData  *)data withTag:( long )tag fromHost:( NSString  *)host port:(UInt16)port{
    NSLog(@"已接收到消息");
    NSLog(@"tag %ld",tag);
    
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
