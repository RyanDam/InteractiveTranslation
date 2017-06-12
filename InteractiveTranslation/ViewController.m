//
//  ViewController.m
//  InteractiveTranslation
//
//  Created by CPU11815 on 6/12/17.
//  Copyright © 2017 dotRStudio. All rights reserved.
//

#import "ViewController.h"
#import "SampleTableViewCell.h"
#import "InterativeTranslation.h"
#import "CameraViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ScrollViewInteractiveActionsDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray * sampleData;


@property (nonatomic) ScrollViewInteractiveActions * interactiveActions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sampleData = [self getSampleData:50];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self initTableViewInteractiveAction];
}

- (void)initTableViewInteractiveAction {
    self.interactiveActions = [[ScrollViewInteractiveActions alloc] initForViewController:self andScrollView:self.tableView];
    
    
    CameraViewController * cameraVC = [CameraViewController viewController];
    StackTrainsitionAnimator * cameraPresentAnimator = [StackTrainsitionAnimator animationWithOption:AnimateOptionToDown
                                                                                 forPresentionOption:PresentingOptionWillShow];
    SwipeInterativeObject * bottomPresentAction = [[SwipeInterativeObject alloc] initPresentViewController:cameraVC fromViewController:self withAnimation:cameraPresentAnimator];
    [self.interactiveActions setTopBouncingAction:bottomPresentAction];
    
    
    CameraViewController * cameraVC2 = [CameraViewController viewController];
    StackTrainsitionAnimator * cameraPresentAnimator2 = [StackTrainsitionAnimator animationWithOption:AnimateOptionToUp
                                                                                  forPresentionOption:PresentingOptionWillShow];
    SwipeInterativeObject * bottomPresentAction2 = [[SwipeInterativeObject alloc] initPresentViewController:cameraVC2 fromViewController:self withAnimation:cameraPresentAnimator2];
    [self.interactiveActions setBottomBouncingAction:bottomPresentAction2];
    
    
    self.interactiveActions.interactiveWhenDecelerating = YES;
    self.interactiveActions.delegate = self;
}

- (NSArray *)getSampleData:(NSUInteger)number {
    NSMutableArray * ret = [NSMutableArray array];
    for (int i = 0; i < number; i++) {
        [ret addObject:[NSString stringWithFormat:@"Sample %d", i]];
    }
    return ret;
}

#pragma mark UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.interactiveActions scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.interactiveActions scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.interactiveActions scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.interactiveActions scrollViewWillBeginDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.interactiveActions scrollViewDidEndDecelerating:scrollView];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sampleData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SampleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSampleTableViewCellIdentify];
    cell.contentLabel.text = self.sampleData[indexPath.row];
    return cell;
}

#pragma mark - ScrollViewInteractiveActionsDelegate

- (BOOL)scrollViewInteractiveActions:(ScrollViewInteractiveActions *)interactiveActions startAction:(SwipeInterativeObject *)action {
    return YES;
}

- (void)scrollViewInteractiveActions:(ScrollViewInteractiveActions *)interactiveActions transferingAction:(SwipeInterativeObject *)action withProcess:(CGFloat)process {
    
}

- (void)scrollViewInteractiveActions:(ScrollViewInteractiveActions *)interactiveActions endAction:(SwipeInterativeObject *)action success:(BOOL)success {
    
}

@end
