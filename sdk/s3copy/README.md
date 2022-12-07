This is an example of how to use the AWS JavaScript SDK to copy an object less than 5GB from one S3 bucket to another.

## How to run
First, run `npm  ci` in this directory to download the packages. Then, set the desired region, source bucket name, destination bucket name and object key in `index.js` and execute the script using a command such as:
```
AWS_PROFILE=... npm run main
```
`index.js` outputs the string `Done` if execution is successful.
