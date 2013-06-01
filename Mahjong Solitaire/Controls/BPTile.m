//
//  BPTile.m
//  Mahjong Solitaire
//
//  Created by Bruno Philipe on 6/1/13.
//  Copyright (c) 2013 Bruno Philipe. All rights reserved.
//

#import "BPTile.h"
#import "BPGameSettings.h"

@implementation BPTile
{
	int tile_height;
}

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (self) {
		//Initialize here
		tile_height = 5;
	}
	return self;
}

- (BOOL)isOpaque
{
	return NO;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSBezierPath	*path = [NSBezierPath bezierPath];
	NSPoint			auxPoint;

	{// Draw left side
		auxPoint = NSMakePoint(self.bounds.origin.x, self.bounds.origin.y);
		[path moveToPoint:auxPoint];

		translPoint(&auxPoint, 0, 75 - tile_height);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, tile_height, tile_height);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, 0, -75 + tile_height);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, -tile_height, -tile_height);
		[path lineToPoint:auxPoint];

		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_SIDE] set];
		[path fill];
	}
	[path removeAllPoints];
	{// Draw bottom side
		auxPoint = NSMakePoint(self.bounds.origin.x, self.bounds.origin.y);
		[path moveToPoint:auxPoint];

		translPoint(&auxPoint, 55 - tile_height, 0);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, tile_height, tile_height);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, -55 + tile_height, 0);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, -tile_height, -tile_height);
		[path lineToPoint:auxPoint];

		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_BOTTOM] set];
		[path fill];
	}
	[path removeAllPoints];
	{// Draw face
		auxPoint = NSMakePoint(self.bounds.origin.x + tile_height, self.bounds.origin.y + tile_height);
		[path moveToPoint:auxPoint];

		translPoint(&auxPoint, 55 - tile_height, 0);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, 0, 75 - tile_height);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, -55 + tile_height, 0);
		[path lineToPoint:auxPoint];

		translPoint(&auxPoint, 0, -75 + tile_height);
		[path lineToPoint:auxPoint];

		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_FACE] set];
		[path fill];
	}
}

void translPoint(NSPoint *p, int x, int y) { p->x += x; p->y += y; }

@end
