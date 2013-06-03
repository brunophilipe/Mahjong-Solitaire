//
//  BPTile.h
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

#import <Cocoa/Cocoa.h>

typedef struct{
	CGFloat x,y,z;
} BPPoint;

BPPoint BPMakePoint(CGFloat x, CGFloat y, CGFloat z);

@interface BPTile : NSView

@property (strong, nonatomic) NSTextField *label;
@property (strong, nonatomic) NSImageView *icon;
@property NSInteger kind;
@property BPPoint coords;
@property BOOL selected;

@end
