var tar = require("tar");

var archiveName = "helsinki.tar.gz";

tar
  .create(
    {
      gzip: true,
      file: archiveName,
    },
    ["./helsinki"]
  )
  .then(() => {
    process.stdout.write(
      `"helsinki" theme packed successfully: ${archiveName}`
    );
  });
