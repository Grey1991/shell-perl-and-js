// write a program to prepend a string passed by the function
// with the word, with a space ie: "Hello "
// should return the new string.
function hello(name) {
   // ur code here.
   name = 'Hello '.concat(name);
   return name;
}

module.exports = hello;
