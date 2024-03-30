// kwin.js

// Process command line arguments
const args = process.argv.slice(2);

// Check if any arguments are provided
if (args.length > 0) {
//  console.log("Parameters received:");
  // Iterate over the arguments and print each one
 // args.forEach((param, index) => {
   // console.log(`${index + 1}. ${param}`);
  //});

  // Define variables based on args
  let config, BIN;
  try {
    // Try to parse the arguments as JSON
    config = JSON.parse(args.join(' '));
   // console.log("Config:", config);
  } catch (error) {
    // If parsing fails, set BIN variable
    BIN = args.join(' ');
   // console.log("BIN:", BIN);
  }
}
