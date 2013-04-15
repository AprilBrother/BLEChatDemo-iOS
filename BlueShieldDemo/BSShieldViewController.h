//
//  BSShieldViewController.h
//  BlueShieldDemo
//
//  Created by yy on 13-4-14.
//  Copyright (c) 2013年 Linlinqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class BlueShield;

@interface BSShieldViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) BlueShield *shield;
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (strong, nonatomic) IBOutlet UITextField *sendText;
@property (strong, nonatomic) IBOutlet UILabel *rxLabel;

@end
