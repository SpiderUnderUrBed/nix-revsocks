// kwin.js

// Process command line arguments
const args = process.argv.slice(2);

// Check if any arguments are provided
if (args.length > 0) {
  console.log("Parameters received:");
  // Iterate over the arguments and print each one
  args.forEach((param, index) => {
    console.log(`${index + 1}. ${param}`);
  });
} else {
  console.log("No parameters received.");
}

// Your main script logic goes here
