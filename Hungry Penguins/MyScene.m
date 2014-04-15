//
//  MyScene.m
//  Hungry Penguins
//
//  Created by Sinklier, Nicholas on 3/15/14.
//  Copyright (c) 2014 Sinklier, Nicholas. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self;
        [self addChild:[self ground]];
        [self addChild:[self ramp]];
        self.backgroundColor = [SKColor colorWithRed:0.70 green:0.92 blue:0.96 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0.0, -9.8);
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hungry Penguins";
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if(!_penguin) {
        _penguin = [self createPenguin];
        [self addChild:_penguin];
    }
    _penguin.position = location;
    _bubbles.position = _penguin.position;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    _penguin.position = location;
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    if(contact.bodyB == self.physicsBody || contact.bodyA == self.physicsBody) {
        return;
    }
}

-(void)didSimulatePhysics{
    [self enumerateChildNodesWithName:@"penguin" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0) {
            [node removeFromParent];
        }
        if (node.position.x < -20) {
            [node removeFromParent];
            self.penguin = nil;
        }
        if (node.position.x > 350) {
            [node removeFromParent];
            self.penguin = nil;
        }
        if (node.position.y <= 250) {
            [self simulateWater];
        }
    }];
}

-(void)update:(CFTimeInterval)currentTime {

}

-(void)simulateWater {
    [self.penguin.physicsBody applyForce:CGVectorMake(0.0, 8500.0)];
    self.penguin.physicsBody.linearDamping = 4.5;
}

-(SKSpriteNode*)createPenguin {
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"PenguinSideSmall"];
    sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width/2.5];
    sprite.physicsBody.dynamic = YES;
    sprite.physicsBody.affectedByGravity = YES;
    sprite.physicsBody.mass = 5;
    sprite.physicsBody.restitution = 0.4;
    sprite.name = @"penguin";
    return sprite;
}

- (SKSpriteNode *)ground {
    SKSpriteNode *floor = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:(CGSize){self.frame.size.width, 200}];
    [floor setAnchorPoint:(CGPoint){0, 0}];
    [floor setName:@"floor"];
    [floor setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:floor.frame]];
    floor.physicsBody.dynamic = NO;
    return floor;
}

- (SKSpriteNode *)ramp {
    SKSpriteNode *ramp = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:(CGSize){self.frame.size.width, 100}];
    [ramp setAnchorPoint:(CGPoint){30, 30}];
    [ramp setName:@"ramp"];
    [ramp setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:ramp.frame]];
    ramp.physicsBody.dynamic = NO;
    return ramp;
}

@end
