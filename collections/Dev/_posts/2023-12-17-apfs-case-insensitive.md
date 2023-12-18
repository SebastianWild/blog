---
title: "APFS is case-insensitive by default 😉"
layout: single
classes: wide
excerpt: >
  Working on a project with devs using different OSs/file systems? Be mindful of your directory naming!
categories:
    - Dev
tags:
    - APFS
    - Mac
    - Windows
---

## The Symptom

Recently I encountered an issue when building an Android project on our Jenkins CI server. The Gradle build would error out because of many duplicate symbols - but when checking the actual project structure and files those duplicate symbols were nowhere to be found. I spend countless hours on this issue and pulled in several colleagues, but to no avail. Eventually after several days of off and on debugging and countless Google queries, I noticed that the capitalization of the package path for the files that were erroring out differed from what I could see locally, but I was perplexed - how could this be?

Though I had been a macOS user and Apple platforms developer for quite some years at that point, whether APFS was case sensitive or insensitive had never occurred to me. I knew that this was a characteristic filesystems had but I never had a reason to think about it until now.

## The Problem

Turns out APFS is case-insensitive by default! For example, this means that the following two paths appear identical to macOS and the OS (and apps/programs) cannot differentiate between them:

- `/path/To/Some/Dir`
- `/path/to/some/dir`

The customary development machine on my team are Macs, which of course all ship with APFS. However Jenkins was running on a OS running on ext4, which is a case-sensitive filesystem by default. At some point someone had moved some packages around, in the process renaming some directories and introducing the issue.

## The Fix

There's two things one can do in this case. The first is to take an approach like suggested in [this](https://stackoverflow.com/a/3011719) StackOverflow answer and configure git as follows: `git config core.ignorecase false`

The alternative is to make a new case-sensitive APFS volume, clone your repo there, and resolve the issue.

{% include figure image_path="/assets/images/dev/create-apfs-volume.png" alt="Creating a case-sensitive APFS volume" %}

## Tips

To prevent issues like this in the future, projects should have clear and adhered to naming guidelines. In our project, we had some packages that varied in capitalization, for example `com.mycompany.myapp.main.Common.models`. For Java and/or Kotlin projects, I'd recommend to not have any capitalization in packages names at all.

## Conclusion

I spent _way too much_ time on this bug. In the end however, I learned a bit more about filesystems and that naming conventions are more than just for readability & maintainability (amongst others) - but could also break your project 😉