


https://github.com/alexngn/intro-to-system-design
https://cses.fi/problemset/
https://neetcode.io/


Serilog login (move to own note)
--- c#
dotnet add package Serilog  
dotnet add package Serilog.Sinks.Console

---
using System;  
using Serilog;  
  
class Program  
{  
    static void Main()  
    {  
        Log.Logger = new LoggerConfiguration()  
            .WriteTo.Console()  
            .CreateLogger();  
  
        Log.Information("Hello, Serilog!");  
  
        // Rest of your application logic  
  
        Log.CloseAndFlush();  
    }  
}

In this code, we configure Serilog to write log events to the console. 

---


https://www.gitkraken.com/

https://www.git-tower.com/windows

https://sourcegraph.com/

https://rize.io/

https://www.bytehide.com/blog/visual-studio-2022-extensions


There are several extensions that are highly recommended for web development. Here are some of them:

1. [**Wappalyzer**: This extension can identify the technologies powering any website](https://wpastra.com/resources/chrome-developer-extensions/)[1](https://wpastra.com/resources/chrome-developer-extensions/).
2. [**HTML Validator**: It checks HTML code for errors and ensures proper syntax](https://wpastra.com/resources/chrome-developer-extensions/)[1](https://wpastra.com/resources/chrome-developer-extensions/).
3. [**JSON Viewer**: This extension renders JSON data in a human-readable format](https://wpastra.com/resources/chrome-developer-extensions/)[1](https://wpastra.com/resources/chrome-developer-extensions/).
4. [**Web Developer Checklist**: Provides a checklist of best practices for web development](https://wpastra.com/resources/chrome-developer-extensions/)[1](https://wpastra.com/resources/chrome-developer-extensions/).
5. [**React Developer Tools**: An open-source tool for the React JavaScript library](https://wpastra.com/resources/chrome-developer-extensions/)[1](https://wpastra.com/resources/chrome-developer-extensions/).
6. [**BrowserStack**: Allows live cross-browser testing that lets you preview your website in various browsers](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
7. [**Window Resizer**: Simulates different screen sizes and resolutions](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
8. [**ColorZilla**: A color picker and eyedropper extension](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
9. [**WhatFont**: Identifies fonts used on web pages](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
10. [**Check My Links**: Checks web pages for broken links](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
11. [**JavaScript and CSS Code Beautifier**: Beautifies JavaScript and CSS code](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
12. [**Web Developer**: Adds a toolbar button with various web developer tools](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
13. [**Session Buddy**: Manages browser sessions](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
14. [**JSON Viewer**: Views JSON documents in a human-readable format](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
15. [**Wappalyzer**: Identifies software on websites](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
16. [**Test IE**: Tests websites in Internet Explorer](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
17. [**Lighthouse**: An open-source, automated tool for improving the quality of web pages](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
18. [**Ghostery**: Blocks ads and stops trackers](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
19. [**CSSViewer**: A simple CSS property viewer](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
20. [**ClickUp**: A productivity platform that allows you to manage your work and personal tasks in a single place](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).
21. [**React Developer Tools**: Allows you to inspect the React component hierarchies in the Chrome Developer Tools](https://wpastra.com/resources/chrome-developer-extensions/)[2](https://www.browserstack.com/guide/chrome-extensions-for-web-developers).

Please note that the effectiveness of these extensions can vary depending on your specific needs and the nature of the projects you are working on. Always remember to download and install extensions from trusted sources.