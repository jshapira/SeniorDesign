//
//  HelloWorldScene.m
//  jenniemaze
//
//  Created by Jennie Shapira on 4/3/14.
//  Copyright Jennie Shapira 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "NewtonScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *_player;
    CCPhysicsNode *_physicsWorld;
    SneakyJoystickSkinnedBase *leftJoy;// = [[SneakyJoystickSkinnedBase alloc] init];
}
@synthesize myWebView;

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    
    
    
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    [[OALSimpleAudio sharedInstance] playBg:@"background-music-aac.caf" loop:YES];
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
    [self addChild:background];
    
    _physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    //   _physicsWorld.debugDraw = YES;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    // Add a sprite
    _player = [CCSprite spriteWithImageNamed:@"player.png"];
    _player.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    _player.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, _player.contentSize} cornerRadius:0]; // 1
    _player.physicsBody.collisionGroup = @"playerGroup"; // 2
    [_physicsWorld addChild:_player];
    
    // Animate sprite with action
    //CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
    //[_player runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    _player.position = ccp(self.contentSize.width/8,self.contentSize.height/2);
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
    leftJoy.joystick.isDPad = YES;
    leftJoy.joystick.numberOfDirections = 4;
    leftJoy.position = ccp(64,64);
    // Sprite that will act as the outter circle. Make this the same width as joystick.
    leftJoy.backgroundSprite = [CCSprite spriteWithImageNamed:@"dpad.png"];
    // Sprite that will act as the actual Joystick. Definitely make this smaller than outer circle.
    leftJoy.thumbSprite = [CCSprite spriteWithImageNamed:@"joystick.png"];
    
    leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,128,128)];
    [self addChild: leftJoy];
    //leftJoystick = leftJoy.joystick;
    //[self addChild:leftJoy];
    
    // done
    
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 460.0);
    myWebView = [[UIWebView alloc] initWithFrame:webFrame];
    [myWebView setBackgroundColor:[UIColor greenColor]];
    
	return self;
}

-(IBAction)tick:(float)delta {
    /* This will take the joystick and tell a special method (not listed here, outside the scope of this guide) to take the joystick, apply movement to hero (CCSprite or else) and apply the real delta (to avoid uneven or choppy movement, delta is the time since the last time the method was called, in milliseconds). */
    if (leftJoy.joystick.degrees == 0){
        NSURL *url = [NSURL URLWithString:@"http://172.16.0.5/$5"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
        
    }
    else if ((leftJoy.joystick.degrees >= 315 && leftJoy.joystick.degrees < 360) ||
             (leftJoy.joystick.degrees > 0 && leftJoy.joystick.degrees < 45)){
        // if (leftJoy.joystick.velocity.x < 0){
        _player.rotation = -90.0;
        NSURL *url = [NSURL URLWithString:@"http://172.16.0.5/$2"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
    else if (leftJoy.joystick.degrees >= 45 && leftJoy.joystick.degrees < 135){
        //else if (leftJoy.joystick.velocity.x > 0){
        _player.rotation = 0.0;
        NSURL *url = [NSURL URLWithString:@"http://172.16.0.5/$3"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
    else if (leftJoy.joystick.degrees >= 135 && leftJoy.joystick.degrees < 225){
        //else if (leftJoy.joystick.velocity.y > 0){
        _player.rotation = 180.0;
        NSURL *url = [NSURL URLWithString:@"http://172.16.0.5/$1"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
    else if (leftJoy.joystick.degrees >= 225 && leftJoy.joystick.degrees < 315){
        //else if (leftJoy.joystick.velocity.y < 0){
        _player.rotation = 90.0;
        NSURL *url = [NSURL URLWithString:@"http://172.16.0.5/$4"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
    else{
        NSURL *url = [NSURL URLWithString:@"http://172.16.0.5/$5"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
    // [self applyJoystick:leftJoy toNode:_player forTimeDelta:delta];
    // if(leftJoy.value < 0){
    // }
}

- (void)addMonster:(CCTime)dt {
    
    CCSprite *monster = [CCSprite spriteWithImageNamed:@"monster.png"];
    
    int minY = monster.contentSize.height/2;
    int maxY = self.contentSize.height - monster.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    
    // 2
    monster.position = CGPointMake(self.contentSize.width + monster.contentSize.width/2, randomY);
    monster.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, monster.contentSize} cornerRadius:0];
    monster.physicsBody.collisionGroup = @"monsterGroup";
    monster.physicsBody.collisionType  = @"monsterCollision";
    [_physicsWorld addChild:monster];
    
    // 3
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int randomDuration = (arc4random() % rangeDuration) + minDuration;
    
    // 4
    CCAction *actionMove = [CCActionMoveTo actionWithDuration:randomDuration position:CGPointMake(-monster.contentSize.width/2, randomY)];
    CCAction *actionRemove = [CCActionRemove action];
    [monster runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
    
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    // [self schedule:@selector(addMonster:) interval:1.5];
    [self schedule:@selector(tick:) interval: 0.01];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1
    CGPoint touchLocation = [touch locationInNode:self];
    
    // 2
    CGPoint offset    = ccpSub(touchLocation, _player.position);
    float   ratio     = offset.y/offset.x;
    int     targetX   = _player.contentSize.width/2 + self.contentSize.width;
    int     targetY   = (targetX*ratio) + _player.position.y;
    CGPoint targetPosition = ccp(targetX,targetY);
    
    // 3
    CCSprite *projectile = [CCSprite spriteWithImageNamed:@"projectile.png"];
    projectile.position = _player.position;
    projectile.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:projectile.contentSize.width/2.0f andCenter:projectile.anchorPointInPoints];
    projectile.physicsBody.collisionGroup = @"playerGroup";
    projectile.physicsBody.collisionType  = @"projectileCollision";
    [_physicsWorld addChild:projectile];
    
    [[OALSimpleAudio sharedInstance] playEffect:@"pew-pew-lei.caf"];
    
    // 4
    CCActionMoveTo *actionMove   = [CCActionMoveTo actionWithDuration:1.5f position:targetPosition];
    CCActionRemove *actionRemove = [CCActionRemove action];
    [projectile runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
    
}


- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster projectileCollision:(CCNode *)projectile {
    [monster removeFromParent];
    [projectile removeFromParent];
    return YES;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)onNewtonClicked:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[NewtonScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
