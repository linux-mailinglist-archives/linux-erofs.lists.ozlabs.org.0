Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D680255E
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Dec 2023 17:22:56 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NJ2vTJ3/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SjsXZ16Ypz3cHf
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 03:22:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NJ2vTJ3/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com; envelope-from=qkrwngud825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SjsXS1vzlz2yQL
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Dec 2023 03:22:46 +1100 (AEDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f65040beso10157961fa.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 03 Dec 2023 08:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701620555; x=1702225355; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjyI0NSqRP3tBZ/bxP+IFQUSUqwpEdqsPE0VFkTo74Q=;
        b=NJ2vTJ3/bl4EVIJzQGL9+/HJMciqq+yXxlyCNx9HV5c1437X1fZbPfaT39qdpjnliL
         2QjwI3Eu63wtThiIhjUmr29OO3XNTJBsr5b+zbhgosWRpZ5o4isXdCeYRgn8xKxaM3jY
         DJRmL0HTHXO5ApsWI9HSLOxi62BPMB8ujhoR7IZgyPdSn4XZajM9uYmcxhY+VKSA98UI
         o8Bm8KxQMkW4mxmDHDLOo6A3no3UcU9M1NZZY4us+fsLXRh7oKUA7JEMpozgNC6KTKGm
         KXQ1zmvMJ6ZYpokXMEcqd4MhM25A5DS/IGKN2bclurvoNgmqXY9gfj9CTD1G67UpO1dX
         VbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701620555; x=1702225355;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjyI0NSqRP3tBZ/bxP+IFQUSUqwpEdqsPE0VFkTo74Q=;
        b=TsdMs3YAIlAO27GqmW3jGtPysnYUnAwdEyLJLsezt3evYd1JECqG6X9fNYt73WMdox
         Egj5brzfX+Oo4Cf39JoGb9VpSbJFZWiJse6nLMGJ2AH2t8ucmEDJVbTb23MrjZsMUUNU
         4DauppcpAyLucRHaKthA8D/yxV5s4Ns/L2/HO88M8FrKYSwrUf+SGz6umR6RctCpYxyF
         0kp7ECqV4GSiDFJ+qmx+o43ARQHnu6nFSXFTrLY+rVuoBuIuQNjJRrYU28yMmlhB9mCZ
         2EUcbk1jhneuKnWU60pVYO5MJk55MreRepS31TNh0Noygl7lBD8bUUmLV0B8LHSxit/i
         h2Yw==
X-Gm-Message-State: AOJu0Yy44tQMpcY0GDi1O0ITJXaRioX1qCwzGGH6SM6ScY4ovbtahXfv
	cfe6B0hDKzUHJp28ApYGv74GKA3C/1FpGgBkfGA=
X-Google-Smtp-Source: AGHT+IGSGcEaIEtQqGblPrNkKc0fnKaGWMp7DebWCNmAF4TiNMHeKf+g1bbPlsKipqb59zTR2qB3Mxa048rMnBy3als=
X-Received: by 2002:a2e:8645:0:b0:2c9:e68e:aded with SMTP id
 i5-20020a2e8645000000b002c9e68eadedmr1460629ljj.61.1701620554728; Sun, 03 Dec
 2023 08:22:34 -0800 (PST)
MIME-Version: 1.0
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Mon, 4 Dec 2023 01:22:23 +0900
Message-ID: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
Subject: Weird EROFS data corruption
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Yann Collet <yann.collet.73@gmail.com>, linux-crypto@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(Cc'ing f2fs and crypto as I've noticed something similar with f2fs a
while ago, which may mean that this is not specific to EROFS:
https://lore.kernel.org/all/CAD14+f2nBZtLfLC6CwNjgCOuRRRjwzttp3D3iK4Of+1EEjK+cw@mail.gmail.com/
)

Hi.

I'm encountering a very weird EROFS data corruption.

I noticed when I build an EROFS image for AOSP development, the device
would randomly not boot from a certain build.
After inspecting the log, I noticed that a file got corrupted.

After adding a hash check during the build flow, I noticed that EROFS
would randomly read data wrong.

I now have a reliable method of reproducing the issue, but here's the
funny/weird part: it's only happening on my laptop (i7-1185G7). This
is not happening with my 128 cores buildfarm machine (Threadripper
3990X).

I first suspected a hardware issue, but:
a. The laptop had its motherboard replaced recently (due to a failing
physical Type-C port).
b. The laptop passes memory test (memtest86).
c. This happens on all kernel versions from v5.4 to the latest v6.6
including my personal custom builds and Canonical's official Ubuntu
kernels.
d. This happens on different host SSDs and file-system combinations.
e. This only happens on LZ4. LZ4HC doesn't trigger the issue.
f. This only happens when mounting the image natively by the kernel.
Using fuse with erofsfuse is fine.

This is how I'm reproducing the issue:

# mkfs.erofs -zlz4 -T0 --ignore-mtime tmp.img /mnt/lib64/
mkfs.erofs 1.7
Build completed.
------
Filesystem UUID: 3a7e1f90-5450-40f9-92a2-945bacdb51c3
Filesystem total blocks: 53075 (of 4096-byte blocks)
Filesystem total inodes: 973
Filesystem total metadata blocks: 73
Filesystem total deduplicated bytes (of source files): 0
# mount tmp.img /mnt
# for i in {1..30}; do echo 3 > /proc/sys/vm/drop_caches; find /mnt
-type f -exec xxh64sum {} + | sort -k2 | xxh64sum -; done
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
293a8e7de2a53019  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
293a8e7de2a53019  stdin
293a8e7de2a53019  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin
0b40f1abfbb6e9a8  stdin

As you can see, I sometimes get 0b40f1abfbb6e9a8 and 293a8e7de2a53019 in others.

This is when I manually inspect the failing file:

# echo 3 > /proc/sys/vm/drop_caches; xxh64sum
/mnt/vendor.qti.hardware.mwqemadapter@1.0.so
dc96f35f015a0e5d  /mnt/vendor.qti.hardware.mwqemadapter@1.0.so
# xxd < /mnt/vendor.qti.hardware.mwqemadapter@1.0.so > /tmp/1
[ several more attempts until I get a different hash... ]
# echo 3 > /proc/sys/vm/drop_caches; xxh64sum
/mnt/vendor.qti.hardware.mwqemadapter@1.0.so
1cfe5d69c28fff6c  /mnt/vendor.qti.hardware.mwqemadapter@1.0.so
# xxd < /mnt/vendor.qti.hardware.mwqemadapter@1.0.so > /tmp/2
# diff /tmp/[12]
3741c3741
< 0000e9c0: f40e 0000 b46b 0000 ac5c 0000 140e 0000  .....k...\......
---
> 0000e9c0: 445a 0000 e40d 0000 ac5c 0000 140e 0000  DZ.......\......

This could still very well be my hardware issue, but I highly suspect
something's wrong with the kernel software code that happens to only
trigger on my hardware configuration.

I've uploaded the generated image here:
https://arter97.com/.erofs/
but I'm not sure it'll be reproducible on other machines.

I've also tried updating the LZ4 module in the /lib/lz4 to the latest
v1.9.4 and the latest dev trunk (4032c8c787e6). I've managed to get it
working with the Linux kernel, but the corruption still happens.

Let me know if there's anything I can help to narrow down the culprit.

Thanks,
