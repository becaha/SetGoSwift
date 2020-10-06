Set Go

Model

    The card game Set is represented in the Model SetGame. Each card is represented in the Model as well. I used enums to represent the props of each card, including Shape, Color, and Pattern. These raw values of these props were used to determine whether a set of 3 cards was a match. 

View Model

    The View Model controls the interaction of the user with the view and the result of that interaction on the model. 

View

    The View represents the Model through the View Model as an observed object. The overall view of the Set Game is broken down into Card Views which is then broken down into Card Content which is further broken down into a Shape View. A Shape View draws the unique Shapes for the game, including an oval, diamond, and a squiggle. 
    
The Game

    I followed the basic rules of the Set Game while adding a Cheat function to show a glimpse of a matching set of cards. 

Score

    I dramatically decreased score when a user deals out 3 more cards by decreasing it by the number of possible sets that were shown before they asked for new cards. Otherwise, cheating and bad sets count for -1 while a correct set counts for +1.

End 

    At the end of the game, it will show your final score and ask you if you would like to play again.

Comments:

    I liked being able to learn how to make a good looking app with animation. The basics for the game were easy, but I struggled with the fight for object oriented code that I am used to. It was also not an easy task to look up any documentation for swift. This was very frustrating.

    I want to be able to learn things on my own easily with documentation online but found myself unable to find good documentation for most of my questions. I worked for many hours on this, and I enjoyed it, but I would really appreciate comparing ways to do things because sometimes I felt like I had to write hacky solutions because I couldn't find another way to solve a problem.
