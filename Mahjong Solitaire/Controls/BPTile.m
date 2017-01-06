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
#import "BPRulesOperator.h"

@implementation BPTile
{
	NSInteger _kind;
}

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (self)
	{
		self.selected = NO;
	}
	return self;
}

- (void)setKind:(NSInteger)kind
{
	_kind = kind;

	NSUInteger thickness = [(NSNumber *)[BPGameSettings getSetting:BPGAME_TILE_SIZE_THICKNESS] unsignedIntegerValue];
	NSUInteger width = self.frame.size.width;
	NSUInteger height = self.frame.size.height;

	_icon = [[NSImageView alloc] initWithFrame:NSMakeRect(thickness + 5, thickness + 5, width-15, height-15)];
	[self.icon setImage:[NSImage imageNamed:[NSString stringWithFormat:@"icon_%ld",(long)kind]]];
	[self.icon setAutoresizingMask:NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin | NSViewMinYMargin | NSViewHeightSizable | NSViewMaxYMargin];

	[self addSubview:self.icon];
}

- (NSInteger)kind
{
	return _kind;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSBezierPath	*path = [NSBezierPath bezierPath];
	NSPoint			auxPoint;

	int width		= self.frame.size.width;
	int height		= self.frame.size.height;
	int thickness	= [[BPGameSettings getSetting:BPGAME_TILE_SIZE_THICKNESS] intValue];

	{
		// Draw left side
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
		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_LINE] set];
		[path stroke];
	}
	[path removeAllPoints];
	{
		// Draw bottom side
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
	{
		// Draw face
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

		BPGAME_SETTINGS setting = self.selected ? BPGAME_TILE_COLOR_SELECTED : BPGAME_TILE_COLOR_FACE;
		[[self lightenColor:(NSColor *)[BPGameSettings getSetting:setting] iterations:self.coords.z] set];
		[path fill];

		[(NSColor *)[BPGameSettings getSetting:BPGAME_TILE_COLOR_LINE] set];
		[path stroke];
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
	int thickness = [[BPGameSettings getSetting:BPGAME_TILE_SIZE_THICKNESS] intValue];
	NSPoint event_location = [theEvent locationInWindow];
	NSPoint local_point = [self convertPoint:event_location fromView:nil];

	if (local_point.x > thickness && local_point.y > thickness)
	{
		[BPRulesOperator tryToSelectTile:self];
	}
}

- (NSColor *)lightenColor:(NSColor *)color iterations:(NSUInteger)it
{
	CGFloat saturation	= color.saturationComponent;
	CGFloat brightness	= color.brightnessComponent;

	for (NSUInteger i=0; i<it; i++)
	{
		saturation *= 0.95;
		brightness *= 1.05;
	}

	return [NSColor colorWithCalibratedHue:color.hueComponent
								saturation:saturation
								brightness:brightness
									 alpha:color.alphaComponent];
}

void translPoint(NSPoint *p, int x, int y) { p->x += x; p->y += y; }

BPPoint BPMakePoint(CGFloat x, CGFloat y, CGFloat z)
{
	BPPoint newpoint;
	newpoint.x = x;
	newpoint.y = y;
	newpoint.z = z;

	return newpoint;
}

@end
