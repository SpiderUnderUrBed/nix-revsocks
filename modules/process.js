// kwin.js

// Process command line arguments
const args = process.argv.slice(2);
const { exec } = require('child_process');
const net = require('net');

function isValidIPAddress(ip) {
    return net.isIP(ip) !== 0;
}
function isValidPort(port) {
    const portNum = parseInt(port);
    return portNum >= 0 && portNum <= 65535;
}
function isValidIPPortPair(ipPort) {
    const [ip, port] = ipPort.split(':');
    return isValidIPAddress(ip) && isValidPort(port);
}

function correctInstances(instances) {
    for (const instanceName in instances) {
        const instance = instances[instanceName];
        if (!isValidIPPortPair(instance.connect)) {
            console.error(`Error: Invalid connect address for instance "${instanceName}"`);
        }
        if (!isValidIPPortPair(instance.proxy)) {
            console.error(`Error: Invalid proxy address for instance "${instanceName}"`);
        }
        if (!isValidIPPortPair(instance.listen)) {
            console.error(`Error: Invalid listen address for instance "${instanceName}"`);
        }
        if (!isValidIPPortPair(instance.socks)) {
            console.error(`Error: Invalid socks address for instance "${instanceName}"`);
        }
    }
}

console.log(args)

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
 // }
}
if (config) {
    correctInstances(config.instances);
}
else {
    console.error("Error: No valid JSON configuration provided");
}
  
exec(BIN, (error, stdout, stderr) => {
    if (error) {
        if (stderr.includes("You must specify a listen port or a connect address")) {
            console.error("Error: You must specify a listen port or a connect address");
        } else {
            console.error(`Error executing ${BIN}: ${error.message}`);
        }
        return;
    }
    console.log(`Output:\n${stdout}`);
    console.error(`Error:\n${stderr}`);
});
