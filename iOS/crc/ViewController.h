//
//  ViewController.h
//  crc
//
//  Created by Diogo Carvalho on 13/10/13.
//  Copyright (c) 2013 Diogo Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}

-(IBAction)interromptorLuz:(id)sender;
-(IBAction)macanetaPorta:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *luz;
@property (weak, nonatomic) IBOutlet UISwitch *porta;

@end
