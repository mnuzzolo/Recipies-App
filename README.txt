### Summary: 
Here's a video of the app and the scrolling behavior under a slow network condition that best displays the behavior of loading and the caching of images:

https://drive.google.com/file/d/1Lukuo_ChcUBUvu6OCYu3OPM4V9Mm39y-/view?usp=sharing

### Focus Areas: 
I spent a good amount of time using the profiler and logging to verify that my caching and image loading was working as I expected, as well as on building my unit tests. I felt this was an important part of the project to make sure that was working correctly based on the prompt. I also made sure that my image view started with a busy spinner, then loaded the image. I also verified that it would display placeholder artwork if it failed to load the image. 

### Trade-offs and Decisions: 
Since this is a sample project, I didn't spend a ton of time designing or customizing the UI. I decided to use a list view rather than a grid and did not attempt to design anything for tablet or for MacOS, just in the interest of time. I did make a basic UI for when the endpoint returned invalid or empty data however. I also implemented a ViewModel for my RecipeView, which wraps some of the basic data in the Recipe object and handles business logic. 
