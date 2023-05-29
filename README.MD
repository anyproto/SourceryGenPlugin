# Install

Add in your package:

```
dependencies: [
        ...
        .package(url: "https://github.com/anyproto/SourceryGenPlugin.git", revision: "1.9.2")
],
targets: [
    .target(
        ...
        plugins: [
            .plugin(name: "SourceryGenPlugin", package: "SourceryGenPlugin")
        ]
    )
]
```

Add `sourcery.yml` in root package folder.

Run build.

# Update

1. Create folder `sourcery-[VERSION].artifactbundle`.
2. In folder create `info.json`.
```
{
    "schemaVersion": "1.0",
    "artifacts": {
        "sourcery": {
            "version": "[VERSION]",
            "type": "executable",
            "variants": [
                {
                    "path": "sourcery/bin/sourcery",
                    "supportedTriples": ["x86_64-apple-macosx", "arm64-apple-macosx"]
                }
            ]
        }
    }
}
```
3. Download Sourcery [release](https://github.com/krzysztofzablocki/Sourcery/releases).
4. Unpack to `sourcery` folder. Struct looks be like:
```
sourcery-[VERSION].artifactbundle
 | info.json
 | sourcery
    | Templates
    | README.md
    | Sourcery.docset
    | Resources
    | ...
    | bin
       | sourcery
```
Very important, your path to bin sould be `sourcery-[VERSION].artifactbundle/sourcery/bin/sourcery`.

5. Zip `sourcery-[VERSION].artifactbundle`.
6. Computer checksum `swift package compute-checksum [PATH-TO-ZIP]`.
7. Update checksum and version for `binaryTarget` in `Package.swift`.
8. Push chages.
9. Create tag and release, upload `sourcery-[VERSION].artifactbundle.zip`

