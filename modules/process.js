// kwin.js

// Process command line arguments
const args = process.argv.slice(2);
const { exec } = require('child_process');

let config, BIN;
//let BIN = null;
// Check if any arguments are provided
if (args.length > 0) {
  for (let i = 0; i < args.length; i++) { 
    try {
      config =  JSON.parse(args[i])
    } catch {
      config = null
    }
    if (config == null){
      BIN = args[i]
    }
  }
  console.log(BIN)
  console.log(config)
  //  console.log("Parameters received:");
  // Iterate over the arguments and print each one
 // args.forEach((param, index) => {
   // console.log(`${index + 1}. ${param}`);
  //});

  // Define variables based on args
/* 
  try {
    // Try to parse the arguments as JSON
    config = JSON.parse(args);
    console.log("Config:", config);
  } catch (error) {
    // If parsing fails, set BIN variable
    console.log(error)
    BIN = args.join(' ');
   console.log("BIN:", BIN);
*/
  }
}
  
exec(BIN, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error executing ${BIN}: ${error.message}`);
        return;
      }
      console.log(`Output:\n${stdout}`);
      console.error(`Error:\n${stderr}`);
});
