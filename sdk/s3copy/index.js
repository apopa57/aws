const { S3Client, CopyObjectCommand, GetObjectAttributesCommand, ObjectAttributes } = require('@aws-sdk/client-s3');

const main = async () => {
  const region = '...'; // set the desired region
  const SOURCE_BUCKET_NAME = '...'; // set the name of the bucket you want to copy from
  const DESTINATION_BUCKET_NAME = '...'; // set the name of the bucket you want to copy to
  const OBJECT_KEY = '...'; // set the key of the object you want to copy

  const client = new S3Client({ region });

  const getObjectAttributesCommand = new GetObjectAttributesCommand({
    Bucket: SOURCE_BUCKET_NAME,
    Key: OBJECT_KEY,
    ObjectAttributes: [
      ObjectAttributes.OBJECT_SIZE,
    ]
  });

  const getObjectsAttributeOutput = await client.send(getObjectAttributesCommand);

  if (getObjectsAttributeOutput.ObjectSize >= 5_000_000_000) {
    console.log(`Cannot copy objects greater than 5 GB using CopyObjectCommand; size is ${getObjectsAttributeOutput.ObjectSize}.`);
    process.exit(1);
  } else {
    console.log(`Size is ${getObjectsAttributeOutput.ObjectSize}; proceeding with CopyObjectCommand.`);
  }

  const copyObjectCommand = new CopyObjectCommand({
    Bucket: DESTINATION_BUCKET_NAME,
    Key: OBJECT_KEY,
    CopySource: `${SOURCE_BUCKET_NAME}/${OBJECT_KEY}`,
  });

  const output = await client.send(copyObjectCommand);

  console.log('Done');
};

main();
