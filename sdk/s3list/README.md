This is an example of how to use the AWS JavaScript SDK to list the objects in an S3 bucket.

## How to run
First, run `npm  ci` in this directory to download the packages. Then, set the desired bucket name and prefix in `index.js` and execute the script using a command such as:
```
AWS_PROFILE=... npm run s3list
```
`index.js` outputs the number of objects in the specified bucket and prefix but it can be changed to do something else depending on your needs.
