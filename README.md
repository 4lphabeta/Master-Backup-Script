Backs up the FW/CS master file for coding and form changes in case reversion is needed. Logs the date and time of the copy for easier tracking. It also has the option to delete old backups seeing as people would rarely do this, adding unnecessary bloat.

Progress_Bar.hta is used by the batch file to show a loading bar to indicate that it is running the backup/deletion and to give an idea of how long until it finishes.
Some servers can take far longer than others due to hardware differences and the size of the master file.

The batch file contains the master file path and backup path on line #5 and #6 respectively. When installing this onto the server, make sure to change these as needed.

Both scripts must be in the Vortex Master folder.

In the event the date or time of backup is incorrect on the ouput file, check the server date and time settings.
