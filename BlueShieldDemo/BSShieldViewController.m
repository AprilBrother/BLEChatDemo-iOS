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
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_peripheral discoverServices:nil];
        CBUUID *serviceId = [CBUUID UUIDWithString:BS_SERIAL_SERVICE_UUID];
        CBUUID *charId = [CBUUID UUIDWithString:BS_SERIAL_RX_UUID];
        [_shield notification:serviceId
           characteristicUUID:charId
                            p:_peripheral
                           on:YES];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom method

- (void)sendTx {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self sendTx];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    [self sendTx];
}

@end
