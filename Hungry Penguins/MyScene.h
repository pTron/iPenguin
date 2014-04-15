//
//  MyScene.h
//  Hungry Penguins
//

//  Copyright (c) 2014 Sinklier, Nicholas. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic)SKSpriteNode *penguin;
@property (strong, nonatomic)SKEmitterNode *bubbles;


@end
