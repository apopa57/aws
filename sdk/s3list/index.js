const { S3Client, ListObjectsCommand } = require('@aws-sdk/client-s3');

const main = async () => {
  const client = new S3Client({ region: 'us-east-2' });
  const keys = [];

  let more = true;
  let marker = undefined;

  while (more) {
    const listObjectsCommand = new ListObjectsCommand({
      Bucket: '...', // add your bucket name
      Prefix: '...', // add your prefix or delete this line if you want to list all the objects
      Marker: marker
    });

    const output = await client.send(listObjectsCommand);

    for (const object of output.Contents) {
      keys.push(object.Key);
    }

    marker = keys[keys.length-1];

    if (!output.IsTruncated) {
      console.log('no more objects');
      more = false;
    }
  }

  console.log(keys.length);
};

main();

