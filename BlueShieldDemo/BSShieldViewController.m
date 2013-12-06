//
//  BSShieldViewController.m
//  BlueShieldDemo
//
//  Created by yy on 13-4-14.
//  Copyright (c) 2013年 Linlinqi. All rights reserved.
//

#import "BSShieldViewController.h"
#import "BlueShield.h"
#import "BSDefines.h"

@interface BSShieldViewController ()

@end

@implementation BSShieldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_shield connectPeripheral:_peripheral];
    
    [_shield didDiscoverCharacteristicsBlock:^(id response, NSError *error) {
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [_shield notification:[CBUUID UUIDWithString:BS_SERIAL_SERVICE_UUID]
               characteristicUUID:[CBUUID UUIDWithString:BS_SERIAL_RX_UUID]
                                p:_peripheral
                               on:YES];
            
            [_shield didUpdateValueBlock:^(NSData *data, NSError *error) {
                NSString *recv = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
                _rxLabel.text = recv;
            }];
        });
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom method

- (void)sendTx {
    NSData *data = [_sendText.text dataUsingEncoding:NSUTF8StringEncoding];
    [_shield writeValue:[CBUUID UUIDWithString:BS_SERIAL_SERVICE_UUID]
     characteristicUUID:[CBUUID UUIDWithString:BS_SERIAL_TX_UUID]
                      p:_peripheral
                   data:data];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    [self sendTx];
}

@end
