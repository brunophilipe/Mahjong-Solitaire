//
//  BPTile.m
//  Mahjong Solitaire
//
//  Created by Bruno Philipe on 6/1/13.
//  Copyright (c) 2013 Bruno Philipe - www.brunophilipe.com - contact@brunophilipe.com
//
//	This program is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
