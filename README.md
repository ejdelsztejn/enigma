# Enigma

## Self-Evaluation

- **Functionality: 3 or 4 *(probably 4)***
  - The `Enigma` class is fully functional, including CLI interface.
  - The `crack` method and `crack.rb` runner file work, however the key that it finds is not guaranteed to be the key that was originally randomly generated.  For example, I encrypted the message `"you are a little sweet birdy end"` and it was given key `"69732"` and today's date `"090620"`.  The encrypted message `"qhmetkxettdnlmdjslojxmsgakwcsyfi"` was corrected cracked, but the key returned was `"15093"`.  I am ok with this functionality for now, but I am curious how one could figure out the exact key that the message was encrypted with.
- **Object Oriented Programming: 3**
  - My project was broken into two classes: `Shift` and `Enigma`.  `Shift` was created because I wanted to keep the `key` and `date` in their own objects, although the `date` attribute was admittedly not used the way that I initially inteded.  
  - I contemplated creating a parent class of `Cipher` for `Enigma` to inherit from, but I chose instead to break some of the functionality that `Enigma` uses into modules `Shiftable` (for all functionality related to shifting keys and characters), and `Crackable` (for all functionality related to the `crack` method.). These modules kept the code more organized and allowed the `Enigma` class to maintain the responsibility of encrpyting and decrypting.
  - I had an interesting conversation with my mentor about OO languages vs. functional languages.  She shared her experiences with Clojure and explained (at a basic level) how it can be difficult, coming from Ruby, how to use a language that builds programs by composing functions as opposed to objects, but that one nice aspect of it is that it can be sometimes difficult to imagine everything as an object, because not everything you code will map neatly onto an object.  In this case, we both discussed how modules would be nice to extract some of the functions, since much of what `Enigma` needed to do was "shift" and "crack."  This is what informed my decision to use modules as opposed to additional classes.
- **Ruby Conventions and Mechanics: 3**
  - All of my classes and methods are at least decently named, and my code is properly indented with correct syntax.  I can explain my choices of enumerables and data structures.
  - I did not get around to refactoring the way that I wanted to, and much of my code is far from as DRY as I wanted it to be.  For example, a lot of the "shifting" in my methods is repetitive.  I got caught up in the `crack` method and in extracting code to modules that I didn't finish the refactoring.  However, my code should be easy to read and follow, which is very important to me.
- **Test Driven Development: 3**
  - I used TDD consistently throughout my program, with the exception of when I created methods for the `Crackable` module (I got carried away with playing around with the code.)
  - I planned to stub the date in my last `enigma_test` method, for when using `crack` without inputting a date as an argument, but didn't get to it.
  - Coverage is at 100%.
- **Version Control 3**
  - 77 commits and 7 PRs.  I deleted my branches after I finished using them, but there were approximately 7. 
  - I tried to be detailed in my PRs, but I think that I could have done even more.  I worked hard to make them comprehensive, though, and I am proud with my progress as a Github user and this project really helped me building skills with branching, creating pull requests, and writing commit messages.
