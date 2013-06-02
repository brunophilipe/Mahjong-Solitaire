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

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (self) {
		//Initialize here
		self.label = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, 40, 20)];
		[self.label setEditable:NO];
		[self addSubview:self.label];

		self.selected = NO;
	}
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSBezierPath	*path = [NSBezierPath bezierPath];
	NSPoint			auxPoint;

	int width		= [[BPGameSettings getSetting:BPGAME_TILE_SIZE_WIDTH] intValue];
	int height		= [[BPGameSettings getSetting:BPGAME_TILE_SIZE_HEIGHT] intValue];
	int thickness	= [[BPGameSettings getSetting:BPGAME_TILE_SIZE_THICKNESS] intValue];

	{// Draw left side
		auxPoint = NSMakePoint(self.bounds.origin.x, self.bounds.origin.y);
		[path moveToPoint:auxPoint];
		translPoint(&auxPoint, 0, height - thickness);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, thickness, thickness);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, 0, -height + thickness);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, -thickness, -thickness);
		[path lineToPoint:auxPoint];
		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_SIDE] set];
		[path fill];
	}
	[path removeAllPoints];
	{// Draw bottom side
		auxPoint = NSMakePoint(self.bounds.origin.x, self.bounds.origin.y);
		[path moveToPoint:auxPoint];
		translPoint(&auxPoint, width - thickness, 0);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, thickness, thickness);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, -width + thickness, 0);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, -thickness, -thickness);
		[path lineToPoint:auxPoint];
		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_BOTTOM] set];
		[path fill];
	}
	[path removeAllPoints];
	{// Draw face
		auxPoint = NSMakePoint(self.bounds.origin.x + thickness, self.bounds.origin.y + thickness);
		[path moveToPoint:auxPoint];
		translPoint(&auxPoint, width - thickness, 0);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, 0, height - thickness);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, -width + thickness, 0);
		[path lineToPoint:auxPoint];
		translPoint(&auxPoint, 0, -height + thickness);
		[path lineToPoint:auxPoint];

		if (self.selected)
		{
			[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_SELECTED] set];
		}
		else
		{
			[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_FACE] set];
		}

		[path fill];
		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_LINE] set];
		[path stroke];
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
	self.selected = !self.selected;
	[self setNeedsDisplay:YES];
}

void translPoint(NSPoint *p, int x, int y) { p->x += x; p->y += y; }

@end
