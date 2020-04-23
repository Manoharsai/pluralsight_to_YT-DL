# pluralsight_to_YT-DL
powershell script to download pluralsight courses by using youtube-dl. The courses contains subtitles, but you can skip them by removing the ```--all-subs``` flag in the [file](https://github.com/rohan5564/pluralsight_to_YT-DL/blob/master/script.ps1#L29).

The courses must be in a text file placed in the same folder where is the script, and only one should go per line like. e.g :

```
https://app.pluralsight.com/library/courses/(COURSE1)/table-of-contents
https://app.pluralsight.com/library/courses/(COURSE2)/table-of-contents
https://app.pluralsight.com/library/courses/(COURSE3)/table-of-contents
...etc
```

## Parameters
* username: Email associated to the pluralsight account.
* password: Password validation
* path: Path to Youtube-dl executable file.
    * DEFAULT: ".\youtube-dl.exe" (same folder that contains the script)
* courses: Text file that contains the URL of each course you want to download.
    * DEFAULT: "courses.txt"
* output: Text filename to save the downloaded courses list.
    * DEFAULT: "downloaded-courses"
* try: Number of tries to download for every course. If the argument given is 0, it'll perform the operation in an infinite loop until it's done.
    * DEFAULT: 0
* sleep: Sleep time to download each file in seconds. Valid range starts from 1.
    * DEFAULT: 120 (recommended)