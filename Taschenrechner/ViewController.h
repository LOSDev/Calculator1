//
//  ViewController.h
//  Taschenrechner
//
//  Created by Rincewind on 27.12.12.
//  Copyright (c) 2012 Rincewind. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController{

    IBOutlet UITextField *calcScreen;
    __weak IBOutlet UILabel *memoryLabel;
    __weak IBOutlet UILabel *termLabel;
    double operand;
    NSString *waitingOperation;
    double waitingOperand;
    BOOL userIsTyping;
    double memory;
    
}

- (double)performOperation:(NSString *)operation;

- (IBAction) numberPressed: (id) sender;
- (IBAction) operationPressed: (id) sender;
- (IBAction) afterDot;
- (IBAction) deleteNumber;
@end
