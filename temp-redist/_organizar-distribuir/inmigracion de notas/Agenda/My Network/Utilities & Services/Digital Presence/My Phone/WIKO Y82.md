
# WIKO Y82

W-K630-EEA

Reset
https://www.youtube.com/watch?v=zgRzlcBhwLQ

Wiko FRP tool


If your phone does not have internet access, you can still access it from your computer through USB using a tool called **ADB (Android Debug Bridge)**. ADB is a command-line tool that allows you to communicate with your Android device from a computer.

Here are the steps on how to access your Wiko Y82 phone from your computer through USB:

1. Enable USB debugging on your phone. To do this, go to **Settings > Developer options > USB debugging** and enable the switch.
    
2. Connect your phone to your computer using a USB cable.
    
3. Open a command prompt window on your computer.
    
4. Type the following command and press Enter:
    

```
adb devices
```

This command will list all of the Android devices that are connected to your computer. Your Wiko Y82 phone should be listed in the output.

5. Type the following command and press Enter:

```
adb shell
```

This command will open a shell session on your phone.

Now that you are connected to your phone, you can use ADB commands to control your phone and access its files. For example, you can use the following commands to:

- **List the files on your phone:**

```
ls /sdcard
```

- **Copy a file from your phone to your computer:**

```
adb pull /sdcard/filename computer/path/to/destination
```

- **Copy a file from your computer to your phone:**

```
adb push computer/path/to/filename /sdcard/
```

- **Run a command on your phone:**

```
adb shell command
```

For more information on using ADB, you can refer to the Android Debug Bridge documentation.

---

If you can only access your phone from your computer using ADB, you will not be able to set up any new features or apps. This is because ADB is a tool for communicating with a device, not for setting up or configuring it.

However, you can still use ADB to access and manage files on your phone, as well as run commands on the phone's operating system. This can be useful for troubleshooting problems or recovering data from your phone.

Here are some things you can do with ADB if you can only access your phone from your computer:

- **Copy files to and from your phone:** You can use the `adb pull` and `adb push` commands to copy files between your phone and your computer.
    
- **Run commands on your phone:** You can use the `adb shell` command to open a shell session on your phone and run commands directly on the operating system.
    
- **Install apps:** You can use the `adb install` command to install APK files on your phone.
    
- **Backup your data:** You can use the `adb backup` command to backup your phone's data to your computer.
    

I hope this helps!