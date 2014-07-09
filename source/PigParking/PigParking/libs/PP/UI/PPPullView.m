//
//  PPPullView.m
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPPullView.h"

@interface PPPullView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation PPPullView

- (void)dealloc
{
    self.maskView = nil;
    self.contentView = nil;
    self.parentView = nil;
}

- (id)initWithParentView:(UIView *)parentView contentView:(UIView *)contentView
{
    self = [super initWithFrame:parentView.bounds];
    if (self)
    {
        self.parentView = parentView;
        
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
        _maskView.alpha = 0.0f;
        [self addSubview:_maskView];
        
        self.contentView = contentView;
        _contentView.frame = CGRectMake(0.0f, 0.0f-_contentView.bounds.size.height-40.0f, _contentView.bounds.size.width, _contentView.bounds.size.height-40.0f);
        [self addSubview:_contentView];
    }
    return self;
}

- (void)show
{
    [self.parentView addSubview:self];
    
    self.contentView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.maskView.alpha = 1.0f;
                         self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y+self.contentView.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             self.contentView.userInteractionEnabled = YES;
                         }
                     }];
}

- (void)hide
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.maskView.alpha = 0.0f;
                         self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y-self.contentView.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [self removeFromSuperview];
                         }
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
