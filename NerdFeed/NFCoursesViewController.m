//
// Created by 吕晴阳 on 2018/9/16.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import "NFCoursesViewController.h"

NSString const *URL_COURSE = @"https://bookapi.bignerdranch.com/courses.json";

@interface NFCoursesViewController () <NSURLSessionDelegate>
@property(strong, nonatomic) NSURLSession *urlSession;
@property(copy, nonatomic) NSArray *courses;
@end

@implementation NFCoursesViewController {

}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        self.navigationItem.title = @"BNR Courses";
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:configuration
                                                    delegate:self
                                               delegateQueue:nil];
        [self fetchFeed];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.courses[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *course = self.courses[indexPath.row];
    self.webViewController.title = course[@"title"];
    self.webViewController.url = course[@"url"];
    [self.navigationController pushViewController:self.webViewController
                                         animated:YES];
}

#pragma mark - Fetch data

- (void)fetchFeed {
    NSURL *url = [[NSURL alloc] initWithString:URL_COURSE];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [self.urlSession
            dataTaskWithRequest:request
              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                  NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:nil];
                  self.courses = jsonObject[@"courses"];
                  NSLog(@"%s %@", sel_getName(_cmd), self.courses);
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [self.tableView reloadData];
                  });
              }];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *_Nullable credential))completionHandler {
    NSLog(@"%s", sel_getName(_cmd));
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"BigNerdRanch"
                                                             password:@"AchieveNerdvana"
                                                          persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}
@end