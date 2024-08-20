# Issue && Reason && Solution
## Issue
Encountered a problem at work where the bottom tab bar disappeared, I made an abstraction of the process and showed it in this demo.

The path to reproduce this issue is:<br>
cold start <b>-></b> click ‘push’ button (page 0) <b>-></b> click ‘present...’ (page 1) <b>-></b> click ‘disiss’ <b>-></b> now we are back to page 0, and the tab bar disappears.

## Reason
The key part of the logic is in the method ‘onTapPresentAndCloseSelf:’, when I try to pop the viewcontroller from the navigation stack which is not visible to the user, setting the parameter 'animated' to YES causes the problem.

## Solution
As I demonstrated in the comments, one way to avoid this problem is to set 'animated' to NO, another is to manipulate the page stack directly (which I think makes more sense in scenarios like this).
