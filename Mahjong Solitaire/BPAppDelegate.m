//
//  BPAppDelegate.m
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

#import "BPAppDelegate.h"
#import "BPTile.h"
#import "BPRulesOperator.h"

@implementation BPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusBar:) name:BP_UPDATE_STATUSBAR object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFreePairs:) name:BP_UPDATE_FREEPAIRS object:nil];

	[[NSNotificationCenter defaultCenter] postNotificationName:BP_NEW_GAME object:self];
}

- (IBAction)action_newGame:(id)sender
{
	NSAlert *alert = [NSAlert alertWithMessageText:@"Start new Game"
									 defaultButton:@"Yes"
								   alternateButton:@"No"
									   otherButton:nil
						 informativeTextWithFormat:@"Are you sure you want to start a new game?"];
	NSInteger ret = [alert runModal];

	if (ret == 1)
	{
		[self.window makeKeyAndOrderFront:self];
		[BPRulesOperator startNewGame];
	}
}

- (void)updateStatusBar:(NSNotification *)notif
{
	[self.label_status setHidden:NO];
	NSString *msg = [[notif userInfo] objectForKey:BP_MESSAGE];
	[self.label_status setStringValue:msg];

	[self performSelector:@selector(clearStatusBar) withObject:nil afterDelay:1];
}

- (void)clearStatusBar
{
	NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^
	{
	   NSViewAnimation *anim = [[NSViewAnimation alloc] initWithViewAnimations:@[
								@{
									  NSViewAnimationTargetKey: self.label_status,
								  NSViewAnimationStartFrameKey: [NSValue valueWithRect:self.label_status.frame],
									NSViewAnimationEndFrameKey: [NSValue valueWithRect:self.label_status.frame],
									  NSViewAnimationEffectKey: NSViewAnimationFadeOutEffect
								}]];
		[anim startAnimation];
	}];
	[block start];
}

- (void)updateFreePairs:(NSNotification *)notif
{
	NSUInteger freePairs = [BPRulesOperator calculateSelectablePairs];
	[self.label_pairs setHidden:NO];
	NSString *msg = [NSString stringWithFormat:@"%ld possible moves",(unsigned long)freePairs];
	[self.label_pairs setStringValue:msg];

	if (freePairs == 0) {
		NSString *title;
		NSString *message;

		if ([BPRulesOperator calculatePlacedTiles] > 0) {
			title = @"Oh no!";
			message = @"There are no more possible moves.";
		} else {
			title = @"Congratulations!";
			message = @"You finished the game successfully!";
		}

		NSAlert *alert = [NSAlert alertWithMessageText:title defaultButton:@"New Game" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@", message];
		if ([alert runModal] == NSAlertDefaultReturn) {
			[BPRulesOperator startNewGame];
		}
	}
}

@end
