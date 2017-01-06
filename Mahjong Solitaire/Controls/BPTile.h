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

/**
 Three-float struct used to represent a coordinate in a 3D space.
 */
typedef struct
{
	CGFloat x,y,z;
} BPPoint;

/**
 Factory for `BPPoint` struct.
 */
BPPoint BPMakePoint(CGFloat x, CGFloat y, CGFloat z);

/**
 Class responsible for storing the information of each tile, and also used to display the tile on the screen, since it is a subclass of `NSView`.
 */
@interface BPTile : NSView

/**
 Label used for debugging. Currently disabled.
 */
@property (strong, nonatomic) NSTextField *label;

/**
 Displays the icon for the tile. This property is only setted by setting the `kind` property.
 
 @note Read-only
 */
@property (strong, nonatomic, readonly) NSImageView *icon;

/**
 Stores the kind of the tile, currently varying from 0 to 14.
 
 Setting this property also sets the `icon` property.
 */
@property NSInteger kind;

/**
 Stores the spatial location of the tile in the game board.
 */
@property BPPoint coords;

/**
 Stores whether or not the tile was selected by the user. Not used for game logic, only for drawing. 
 */
@property BOOL selected;

@end
