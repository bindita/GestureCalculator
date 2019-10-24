# GestureCalc: An Eyes-Free Calculator for Touch Screens [[Main Paper]](https://homes.cs.washington.edu/~bindita/papers/gesturecalc_assets19.pdf) [[Demo Paper]](https://homes.cs.washington.edu/~bindita/papers/gesturecalc_assets19_demo.pdf)


[Bindita Chaudhuri](https://homes.cs.washington.edu/~bindita/), [Leah Perlmutter](https://homes.cs.washington.edu/~lrperlmu/), Justin Petelka, [Philip Garrison](https://philipgarrison.com/), [James Fogarty](https://homes.cs.washington.edu/~jfogarty/), [Jacob Wobbrock](https://faculty.washington.edu/wobbrock/) and [Richard Ladner](https://www.cs.washington.edu/people/faculty/ladner)

<p align="center"> 
<img src="https://homes.cs.washington.edu/~bindita/images/gesturecalcproject.gif" width="200px">
</p>

We introduce <i>GestureCalc</i>, a digital calculator that uses target-free gestures for arithmetic tasks. It allows eyes-free input in the form of taps and directional swipes with one to three fingers, guided by minimal audio feedback, to enter digits and operations. Our main contributions are:

* It is a novel eyes-free target-less digital calculator application that uses a minimal number of accessible gestures to enter digits and basic operations.

* It uses intuitive gestures based on conceptual metaphors that are both memorable and easily learnable for visually impaired people.

* In a mixed methods longitudinal study with eight screen reader users we found that they  entered characters with <i>GestureCalc</i> 40.5\% faster on average than with a typical touch screen calculator (baseline). They made more mistakes but also corrected more errors with <i>GestureCalc</i>, resulting in 52.2\% fewer erroneous calculations than the baseline.

### Usage

* The applications are written in Swift Language using Xcode on MacOS. The folder <i>GestureCalculator</i> contains the Xcode project for our <i>GestureCalc</i>, the folder <i>GeneralCalculator</i> contains the Xcode project for our baseline <i>ClassicCalc</i>, and the folder <i>PromptReader</i> contains the Xcode project for reading out the prompts to the participants during our sessions.

* The best way to try out our app is to come to the demo session on Wednesday (Oct 30, 2019) at 10:10 am at the ASSETS conference. If a user has an iPhone (preferably >= 6), we can distribute the iOS app via TestFlight.

Instructions:

* Install TestFlight app from the Apple App Store.
* Give your full name and email ID to an author. He/she will send you an invitation over email to install the app.
* Open the email invitation from Safari or regular Mail app.
* Click on “View in TestFlight” and then click install inside TestFlight. 

The app is now installed and usable as a regular App Store app. The expiry date of the app will be mentioned inside the TestFlight app.


### Citation
If you use this work for your research, please consider citing:
```
@inproceedings{Chaudhuri:2019:3308561.3353783,
 author = {Chaudhuri, Bindita and Perlmutter, Leah and Petelka, Justin and Garrison, Philip and Fogarty, James and Wobbrock, Jacob O. and Ladner, Richard E.},
 title = {GestureCalc: An Eyes-Free Calculator for Touch Screens},
 booktitle = {Proceedings of the 21st International ACM SIGACCESS Conference on Computers and Accessibility},
 series = {ASSETS '19},
 year = {2019},
 isbn = {978-1-4503-6676-2/19/10},
 location = {Pittsburgh, PA, USA},
 url = {http://doi.acm.org/10.1145/3308561.3353783},
 doi = {10.1145/3308561.3353783},
 acmid = {3353783},
 publisher = {ACM},
 address = {New York, NY, USA},
 keywords = {Eyes-free entry; gesture input; digital calculator; touch screen; mobile devices},
}
```
