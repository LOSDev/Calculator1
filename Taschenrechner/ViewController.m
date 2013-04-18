//
//  ViewController.m
//  Taschenrechner
//
//  Created by Rincewind on 27.12.12.
//  Copyright (c) 2012 Rincewind. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//performing the operations that need 2 operands
- (void)performWaitingOperation
{
    if ([@"+" isEqual:waitingOperation]) {
        operand = waitingOperand + operand;
    }
    else if ([@"*" isEqual:waitingOperation]){
        operand = waitingOperand * operand;
    }
    else if ([@"-" isEqual:waitingOperation]){
        operand = waitingOperand - operand;
    }
    else if ([@"/" isEqual:waitingOperation]){
        if (operand) {
            operand = waitingOperand / operand;
        }else [self showMessage:@"Can't divide by zero"];
    }
}
//performing the actual calculation if possible
- (double)performOperation:(NSString *)operation{
    if ([operation isEqual:@"sqrt"]){
         if(operand>=0)operand = sqrt(operand);
        else [self showMessage:@"No square root of a negative number!"];
    }
    else if ([@"+/-" isEqual:operation]){
        operand = - operand;
    }
    else if ([@"1/x" isEqual:operation]){
        if(operand) operand = 1/operand;
        else [self showMessage:@"Can't divide by zero"];
    }
    else if ([@"sin" isEqual:operation]){
         operand = sin(operand);
    }
    else if ([@"cos" isEqual:operation]){
        operand = cos(operand);
    }
    else if ([@"Store" isEqual:operation]){
        [self updateMemory:operand];
    }
    else if ([@"Recall" isEqual:operation]){
         operand = memory;
    }
    else if ([@"Pi" isEqual:operation]){
        operand = M_PI;
    }
    else if ([@"Back" isEqual:operation]){
        
        
        
    }
    else if ([@"Mem +" isEqual:operation]){
         [self updateMemory:memory+operand];
    }
    else if ([@"C" isEqual:operation]){
        [self updateMemory:0];
        operand=0;
        waitingOperand=0;
        
    }
    else{
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
        userIsTyping=NO;
        if (![waitingOperation isEqualToString:@"="])
            termLabel.text= [NSString stringWithFormat:@"%g %@",waitingOperand,waitingOperation];
        else termLabel.text=@"";
    }
    
    return operand;
}
//set instance variables 
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    calcScreen.userInteractionEnabled=NO;
    calcScreen.text=@"0";
    [self updateMemory:0];
    termLabel.text=@"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Display the new number on the screen depending on the nachKomma variable
- (IBAction) numberPressed: (id) sender{
    NSString *number = [NSString stringWithFormat:@"%d",[sender tag]];
    if(userIsTyping){
       calcScreen.text = [calcScreen.text stringByAppendingString:number];
       
    }else{
        calcScreen.text=number;
        userIsTyping=YES;
    }
}

//set the operation selected
- (IBAction) operationPressed: (id) sender{
    if (userIsTyping) {
        operand=[calcScreen.text doubleValue];
        userIsTyping = NO;
    }
    NSString *operation = [[sender titleLabel] text];
    double result = [self performOperation:operation];
   
    calcScreen.text=[NSString stringWithFormat:@"%g", result];
}

//calculating the value stored in memory
-(void) updateMemory:(double)numberToStore{
    memory=numberToStore;
    memoryLabel.text = [NSString stringWithFormat:@"Memory: %g",numberToStore];

}

// showing an AlertView when something went wrong
-(void) showMessage:(NSString *) message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                message:message
                delegate:self
                cancelButtonTitle:@"OK"
                otherButtonTitles:nil];
    [alert show];

}

//called when the Back-Button is pressed. Deletes last number entered
-(IBAction) deleteNumber{
    if(userIsTyping){
        NSString *number = calcScreen.text;
        if(number.length>1){
            number = [number substringToIndex:number.length-1];
            NSLog(@"%@",number);
            calcScreen.text=number;
            operand = [number floatValue];
        }else{
            operand=0;
            calcScreen.text=@"0";
        
        }
    }
}

//sets a dot if there is none already in the display
- (IBAction) afterDot{
    if ([calcScreen.text rangeOfString:@"."].location == NSNotFound && userIsTyping==YES) {
        NSString *komma = @".";
        calcScreen.text = [calcScreen.text stringByAppendingString:komma];
    }else if (userIsTyping==NO){
        calcScreen.text = @"0.";
        userIsTyping=YES;
    }
}


@end
    
