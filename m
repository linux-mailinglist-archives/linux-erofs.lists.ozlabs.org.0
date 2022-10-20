Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C3605A28
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 10:50:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtLrv0JrFz3cfB
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 19:50:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.204.34.129; helo=smtpbguseast1.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=<UNKNOWN>)
X-Greylist: delayed 2199 seconds by postgrey-1.36 at boromir; Thu, 20 Oct 2022 19:50:02 AEDT
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtLrp3QXhz3c46
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 19:49:57 +1100 (AEDT)
X-QQ-mid: bizesmtp84t1666253578tm89pjze
Received: from [10.20.52.53] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 16:12:57 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000000
X-QQ-FEAT: cIAm9Ti9Z0xB2hAnhT416P5/SygxhsqniWmSAneh31Nn4tLI63NajNR9mDebZ
	jKOriceCI+A2xD6t3tp7dyAOHyUl4TTdjsuelOBhIMHU7ncAx9qWavabO0gYMHxz9SLSH3L
	lm/O4sm1rrdBDl5Eg8krpdctwM+xq6S/s9bYkU9mPGDMiWgJQkYQtcIDZ/6Cd24GEQM7i9x
	wDDRNwoWzSoKFKZWPpbUKNJ60XJ1GWDIoRi4fJ8EqMMdYMSsqdAj+kyAM5vFfb2k+N++UB2
	rOPXXRmnZIBln6SU7UO9LdKvrnkWvrv0kbZkEUnOdrNDCbspVp76StGa/mzDb3ybh0CrJhh
	yvXgb6VUYVwiYP+gHb+hjlxk+tg0PcItZRAWnEpD9bLh+fCFNw=
X-QQ-GoodBg: 2
Message-ID: <70667519DD94DA0B+b911194e-0b38-9674-eb9f-5ed8d93a3044@uniontech.com>
Date: Thu, 20 Oct 2022 16:12:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
From: chenlinxuan <chenlinxuan@uniontech.com>
Subject: A little patch fix dev_read to make it works with large file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using `fsck.erofs` to extract some image have a very large file 
(3G) inside, my fsck.erofs report some thing like:

<E> erofs_io: Failed to read data from device - erofs.image:[4096, 
2147483648].
<E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
<E> erofs: Failed to extract filesystem

You can use this script to reproduce this issue.

#!/bin/env sh

mkdir tmp extract
dd if=/dev/urandom of=tmp/big_file bs=1M count=2048

mkfs.erofs erofs.image tmp
fsck.erofs erofs.image --extract=extract

I found that dev_open will failed if we can not get all data we want 
with one pread call.

I write this little patch try to fix this issue.

This is my first patch send via email, sorry if anything goes wrong.

 From 156af5b173c1f9e2a91e4d2126214b96966babd1 Mon Sep 17 00:00:00 2001
From: chenlinxuan <chenlinxuan@uniontech.com>
Date: Thu, 20 Oct 2022 14:39:17 +0800
Subject: [PATCH] erofs-utils: lib: fix dev_read

We need to keep calling pread until we get all data we want
---
  lib/io.c | 28 +++++++++++++++++++++-------
  1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 524cfb4..bd3d790 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -256,7 +256,7 @@ int dev_resize(unsigned int blocks)

  int dev_read(int device_id, void *buf, u64 offset, size_t len)
  {
-   int ret, fd;
+   int read_count, fd;

     if (cfg.c_dry_run)
         return 0;
@@ -278,15 +278,29 @@ int dev_read(int device_id, void *buf, u64 offset, 
size_t len)
         fd = erofs_blobfd[device_id - 1];
     }

+   while (len > 0) {
  #ifdef HAVE_PREAD64
-   ret = pread64(fd, buf, len, (off64_t)offset);
+       read_count = pread64(fd, buf, len, (off64_t)offset);
  #else
-   ret = pread(fd, buf, len, (off_t)offset);
+       read_count = pread(fd, buf, len, (off_t)offset);
  #endif
-   if (ret != (int)len) {
-       erofs_err("Failed to read data from device - %s:[%" PRIu64 ", 
%zd].",
-             erofs_devname, offset, len);
-       return -errno;
+       if (read_count == -1 || read_count ==  0) {
+           if (errno) {
+               erofs_err("Failed to read data from device - "
+                     "%s:[%" PRIu64 ", %zd].",
+                     erofs_devname, offset, len);
+               return -errno;
+           } else {
+               erofs_err("Reach EOF of device - "
+                     "%s:[%" PRIu64 ", %zd].",
+                     erofs_devname, offset, len);
+               return -EINVAL;
+           }
+       }
+
+       offset += read_count;
+       len -= read_count;
+       buf += read_count;
     }
     return 0;
  }
-- 
2.37.3

