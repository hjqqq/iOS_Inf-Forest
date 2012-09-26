Info-Forest
===========

This is the iOS app code for InfoForest.

You should know that the app can import and cache images using HTTP requests using a third party network 
called AFNetworking.  Our summer group of students unfortunately had to use the furman server because 
our UK one crashed.  This is less than ideal because I couldn't implement the legacy photos, high res photos, etc.
because they are not on the furman server.  So if you are continuing this project, you should know that! 

As far as caching goes, the image data is stored in a temporary directory and the URLs are stored in an
array.  Once the array gets to a certain number, images are released in order to prevent the app from crashing.
Also, the image before and after the current image are caught in order to diminish loading time.
The slider at the bottom works for the images but not the xml.

Also, this app can get xml from the furman server too.  But it is in the early stages.  The furman server
stores the latin xml by chapters in books so it is not lined up correctly per page.  Hopefully you will have 
the UK server up and running so you can just plug in the correct urn and implement the correct xml.  
The xml parser basically takes the xml pulled from the server (which used kissXML) and ignores everything 
except for the text.  

The extras tab opens up a youtube video about the history of the vis center with the Chad Gospels.  
The 3D tab opens up a view of a 3D image of a page.  This code was taken from John Broadbent's work on
3D images.  The translation opens up a translation xml from the furman server.
These will have to be evolved to become dynamic.

THE FILES:
opening viewer= ViewController
about page= AboutViewController
some testing code dealing with requests=Request
caching images= imgcache
creating the correct URL for each image=ModleForImageViewer
the view of the low res image=ImageView
xml on the left and instance of image viewer on the right with other view options=SidebySideViewController
view of translation xml (used as a popover in SidebySide)= Translation
view of the youtube video (used as a popover in SidebySide)=videoViewController


I tried to put comments in the code, so just look for those if you get lost.

If the xcode project on the server ever acts up or gets deleted somehow, I have saved a copy
on John Broadbent's work mac in the folder "iOS infoforest" and I will also have a copy on my
personal laptop (just contact Becky Hogan).