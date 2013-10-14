//
//  ViewController.m
//  crc
//
//  Created by Diogo Carvalho on 13/10/13.
//  Copyright (c) 2013 Diogo Carvalho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Turn on Led
-(IBAction)interromptorLuz:(id)sender
{
    UISwitch *inter = (UISwitch *)sender;
    
    if(inter.isOn)
    {
        NSLog(@"Ligou");
        [self sendActionToHome:@"ledon"];
    }
    else
    {
        NSLog(@"Desligou !");
        [self sendActionToHome:@"ledoff"];
    }
}

//Move servo
-(IBAction)macanetaPorta:(id)sender
{
    UISwitch *inter = (UISwitch *)sender;
    
    if(inter.isOn)
    {
        [self sendActionToHome:@"opendoor"];
    }
    else
    {
        [self sendActionToHome:@"closedoor"];
    }
}

-(void)sendActionToHome:(NSString *)action
{
    NSString *post = [NSString stringWithFormat:@"action =%@",action];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://www.urlToPhpCOde.com"]];//put here your url to php code
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    NSLog(@"Response: %@",_responseData);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
