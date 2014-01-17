//
//  MRToggleButton.m
//  MatchReminder
//
//  Created by Rogelio Gudino on 12/22/13.
//  Copyright (c) 2013 Cananito. All rights reserved.
//

#import "MRToggleButton.h"

@interface MRToggleButton ()

@property (nonatomic, strong) UIView *onView;
@property (nonatomic, strong) UIView *offView;
@property (nonatomic, strong) UILabel *onLabel;
@property (nonatomic, strong) UILabel *offLabel;

@end

@implementation MRToggleButton

#pragma mark - Overriden Methods
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame;
    
    [super layoutSubviews];
    
    self.onView.frame = self.bounds;
    self.offView.frame = self.bounds;
    
    if ( _isOn ) {
        frame = self.offView.frame;
        frame.origin.y = -CGRectGetHeight(self.offView.bounds);
        self.offView.frame = frame;
    } else {
        frame = self.onView.frame;
        frame.origin.y = CGRectGetHeight(self.offView.bounds);
        self.onView.frame = frame;
    }
    
    self.onLabel.frame = self.onView.bounds;
    self.offLabel.frame = self.offView.bounds;
}

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSString *)accessibilityValue {
    if (self.isOn) {
        return self.onText;
    } else {
        return self.offText;
    }
}

- (UIAccessibilityTraits)accessibilityTraits {
    return UIAccessibilityTraitButton;
}

- (void)setOnText:(NSString *)onText {
    if (_onText != onText) {
        _onText = onText;
        [self.onLabel setText:_onText];
    }
}

- (void)setOffText:(NSString *)offText {
    if (_offText != offText) {
        _offText = offText;
        [self.offLabel setText:_offText];
    }
}

- (void)setOnColor:(UIColor *)onColor {
    if (_onColor != onColor) {
        _onColor = onColor;
        [self.onView setBackgroundColor:_onColor];
    }
}

- (void)setOffColor:(UIColor *)offColor {
    if (_offColor != offColor) {
        _offColor = offColor;
        [self.offView setBackgroundColor:_offColor];
    }
}


#pragma mark - Public Methods
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    [self setOn:on animated:animated withCompletion:nil];
}

#pragma mark - Private Methods
- (void)setupUI {
    UITapGestureRecognizer *tapGestureRecognizer;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView:)];
    self.onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.onLabel setTextAlignment:NSTextAlignmentCenter];
    [self.onLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:11]];
    [self.onLabel setTextColor:[UIColor whiteColor]];
    
    self.onView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.onView setOpaque:YES];
    [self.onView addSubview:self.onLabel];
    [self.onView addGestureRecognizer:tapGestureRecognizer];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOffView:)];
    self.offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.offLabel setTextAlignment:NSTextAlignmentCenter];
    [self.offLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:11]];
    [self.offLabel setTextColor:[UIColor whiteColor]];
    
    self.offView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.offView setOpaque:YES];
    [self.offView addSubview:self.offLabel];
    [self.offView addGestureRecognizer:tapGestureRecognizer];
    
    [self addSubview:self.onView];
    [self addSubview:self.offView];
}

- (void)didTapOnView:(UITapGestureRecognizer *)tapGestureRecognizer {
    __weak id weakSelf;
    
    weakSelf = self;
    [self setOn:NO animated:YES withCompletion:^{
        [weakSelf sendActionsForControlEvents:UIControlEventValueChanged];
    }];
}

- (void)didTapOffView:(UITapGestureRecognizer *)tapGestureRecognizer {
    __weak id weakSelf;
    
    weakSelf = self;
    [self setOn:YES animated:YES withCompletion:^{
        [weakSelf sendActionsForControlEvents:UIControlEventValueChanged];
    }];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated withCompletion:(void (^)(void))completion {
    if (_isOn == on) {
        return;
    }
    
    _isOn = on;
    
    if (_isOn) {
        [self showOnViewAnimated:animated withCompletion:completion];
    } else {
        [self showOffViewAnimated:animated withCompletion:completion];
    }
}

- (void)showOnViewAnimated:(BOOL)animated withCompletion:(void (^)(void))completion {
    CGRect offFrame;
    CGRect onFrame;
    
    offFrame = self.offView.frame;
    offFrame.origin.y = -CGRectGetHeight(self.onView.bounds);
    
    onFrame = self.onView.frame;
    onFrame.origin.y = 0.0;
    
    if (!animated) {
        self.onView.frame = onFrame;
        self.offView.frame = offFrame;
        if (completion) {
            completion();
        }
        return;
    }
    
    [UIView animateWithDuration:0.24 animations:^{
        self.onView.frame = onFrame;
        self.offView.frame = offFrame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)showOffViewAnimated:(BOOL)animated withCompletion:(void (^)(void))completion {
    CGRect offFrame;
    CGRect onFrame;
    
    offFrame = self.offView.frame;
    offFrame.origin.y = 0.0;
    
    onFrame = self.onView.frame;
    onFrame.origin.y = CGRectGetHeight(self.onView.bounds);
    
    if (!animated) {
        self.onView.frame = onFrame;
        self.offView.frame = offFrame;
        if (completion) {
            completion();
        }
        return;
    }
    
    [UIView animateWithDuration:0.24 animations:^{
        self.onView.frame = onFrame;
        self.offView.frame = offFrame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

@end
