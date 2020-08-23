---
title: "Engine Noise? Might want to check your timing chain tensioner!"
layout: single
classes: wide
excerpt: >
  Ticking noises in your engine could be due to a faulty timing chain tensioner.
categories: 
    - Motorcycle
tags:
    - diy
    - repair
    - motorcycle

gallery:
  - url: "/assets/images/motorcycle/390duke_cam_chain_tensioner_side.jpeg"
    image_path: "/assets/images/motorcycle/390duke_cam_chain_tensioner_side.jpeg"
    alt: "Cam chain tensioner lying down"
  - url: "/assets/images/motorcycle/390duke_cam_chain_tensioner_standing.jpeg"
    image_path: "/assets/images/motorcycle/390duke_cam_chain_tensioner_standing.jpeg"
    alt: "Cam chain tensioner standing upright"
---

**TL;DR** If you motorcycle engine starts making funny, loud ticking noises, you might want to check your timing chain tensioner.

I own a KTM 390 Duke that I love dearly. It's light, has good power for its size, and is super fun to flick around in corners. Yet especially the earlier models (mine is a '16) do not - according to some people - have the best reputation when it comes to reliability. I've only put ~10k miles on my bike and up until now no real repairs were needed besides the usual oil changes, valve adjustments, etc.

Some weeks back as I was getting off the highway I started hearing what I at first thought was a faulty exhaust from the car in front of me. I was stopped at a light and what I was hearing sounded a lot like an exhaust leak - as if something had rattled loose and let some gases escape. After another few seconds of riding though it became obvious that this wasn't coming from anyone around me, but from my bike. Luckily I was quite close to home and was able to quickly take a look.

## Initial Troubleshooting

When you spend a lot of time doing something, whether it'd be motorcycle riding or really any other activity you get used to how things behave, sound, and feel. If something is off, you can realize it pretty quickly. After getting off the bike and putting my ear to the engine I could immediately tell that something was just not right - and to be quite frank it scared the hell out of me. I recorded what I was hearing so I could send it to a buddy of mine:

{% include video id="y97m7XAnRBg" provider="youtube" %}

Looking at that video it sounds nothing like an exhaust leak - it's quite obvious that there is a lot of ticking going on. In person however, it sounded a lot different. After verifying that the exhaust system did not seem to have any loose parts or stray holes there really were only two things left that I figure might be the culprit:

- Out of spec valves
- Super loose timing chain

The valves were adjusted somewhat recently, and so I decided to check out potential culprit #2 first.

## Examining the Timing Chain Tensioner

{: .notice--danger}
**As a prerequisite, make sure your engine is at top dead center. If this is not the case, you could risk the engine jumping timing.**

On the 390 Duke, removing the tensioner is simple. Remove the screw marked in step 1, noting that there is an O-ring underneath. Then, remove the two screws marked in step 2. Finally, you can take out the tensioner and its gasket.

{% include figure image_path="/assets/images/motorcycle/390duke_cam_chain_tensioner_removal.jpeg" alt="Shows steps to remove the cam chain tensioner from the engine" %}

Once taken out, the tensioner looks like this:

{% include gallery id="gallery" %}

Let's look at its function a little more closely.

## Replacing the Tensioner

The stock tensioner is an automatic, spring based tensioner. It features a little tensioning rod (pictured above) that exerts pressure on a guide rail inside the engine (not pictured) in order to tension the timing chain. The purpose of the timing chain is to synchronize the rotation of the camshaft with the crankshaft - making sure that valves open & close exactly when needed. A loose timing chain could result in jumped timing, which will cause the engine to not perform the precise sequence of events to complete a four-stroke combustion cycle, or worse grenade the engine.

The tensioner in the 390 Duke is essentially on or off - either the spring pushes the tensioner out, or the tensioner is "locked" all the way in. Proper operation can be verified with the tensioner still in the bike by doing the following:

1. With a flat-head screwdriver, turn the adjustor bolt (#2 - hard to see) clockwise (#3) until you can't anymore. This is the lock point.
2. Remove the screwdriver. Note that the tensioner is now at its shortest length.
3. "Unlock" the tensioner by using the flat-head screwdriver to nudge the adjustor bolt counterclockwise (#4) ~ a quarter turn. You should feel pressure on your screwdriver as the spring engages.
4. Remove the screwdriver, and the spring will extend the tensioner until hit hits the timing chain guide - you'll hear a small clack.

{: .notice--warning}
**It is possible to over-extend the tensioner by rotating counterclockwise after its automatic spring-based tension!**

{% include figure image_path="/assets/images/motorcycle/390duke_cam_chain_tensioner_adjustment.jpeg" alt="Checking the tensioner's function" %}

In my case the issue quickly became obvious. In step 1 above, I noticed that there was no tension on my screwdriver at all the as spring had completely failed. As such, the timing chain was at its loosest setting - hence the noise. I ordered an OEM replacement and installed it like so:

1. Bring the tensioner to the locked position as described in step 1 above.
2. Place a gasket to sit between the engine and the tensioner.
3. Insert the tensioner, making sure to orient it correctly.
4. Mount and tighten the screws with the correct torque values.
5. Like in step 3. above, unlock the timing chain tensioner. You should faintly hear it impact the guide inside the engine.
6. Mount and tighten the cover screw along with its O-ring.

In my case, this immediately made the horrible noises I was hearing go away, and I knew I had found the root cause ✅

## Final Thoughts

While the concept of timing chains & their tensioners is not motorcycle specific, the steps described in this post are. They are probably similar for other bikes, but I would always recommend following your owner's manual. It is also very much worthwhile to get a repair manual for your motorcycle as those go much more in depth than an owner's manual.

There are also manual timing chain tensioners. Instead of being spring powered, they are manually adjustable. Some people prefer those as they are simpler and more reliable.
