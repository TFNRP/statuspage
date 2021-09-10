<h2 align="center">FiveM Atlassian Statuspage</h2>

<p align="center">
<a href="https://patreon.com/yeen"><img alt="Patreon" src="https://img.shields.io/badge/patreon-donate?color=F77F6F&labelColor=F96854&logo=patreon&logoColor=ffffff"></a>
<a href="https://discord.gg/xHaPKfSDtu"><img alt="Discord" src="https://img.shields.io/discord/463778631551025187?color=7389D8&labelColor=6A7EC2&logo=discord&logoColor=ffffff"></a>
</p>

## Table of Contents

- [About](#about)
- [Installation](#installation)
- [Configuration](#configuration)

## About

FiveM Statuspage integrates your [Atlassian Statuspage](statuspage.io)'s incidents to your server's chat, allowing you to notify your server's players when there's an active incident on your or a third-party's Statuspage.  
![img](https://i.imgur.com/XanQhO0.png)
![img](https://i.imgur.com/KoCuouE.png)

## Installation

Clone with Git or [download manually](https://github.com/TFNRP/statuspage/archive/refs/heads/main.zip)

```bash
$ git clone https://github.com/TFNRP/statuspage.git
```

Edit the resource `config.lua`, changing `'mypage.statuspage.io'` to your own Statuspage.  
Start the resource in your `server.cfg`  

```cfg
ensure statuspage
```

## Configuration

Not much configuration is needed.  
Simply edit `config.lua` to your liking. Keep in mind that `StatuspageURL` must not begin with `https://`.  
`StatuspageURL` can also be an array of Statuspages if you would like to get alerts for multiple.  

```lua
StatuspageURL = { 'mypage.statuspage.io', 'cloudflarestatus.com', 'discordstatus.com', 'status.cfx.re' }
```

The example above will also give alerts for any incident from [Cfx.re](https://status.cfx.re), [Discord](https://discordstatus.com/) and [Cloudflare](https://www.cloudflarestatus.com/).  
Note: This will give alerts for **all** incidents, including ones unrelated to your server, i.e. [Cfx.re forums](https://forum.cfx.re/), which does not affect your server or players joining it.  
Instead, I advise you to add them as third-party components to your own Statuspage.  
