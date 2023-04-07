Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4B6DAEAE
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:17:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtL6T2sy1z3fVR
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:17:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtL6N5Sm0z3fDd
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:17:16 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX2QPl_1680877030;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX2QPl_1680877030)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:11 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/7] erofs: introduce long xattr name prefixes feature
Date: Fri,  7 Apr 2023 22:17:03 +0800
Message-Id: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Background
=========
overlayfs uses xattrs to keep its own metadata.  If such xattrs are
heavily used, such as Composefs model [1], large amount of xattrs
with diverse xattr values exist but only a few common xattr names
are valid (trusted.overlay.redirect, trusted.overlay.digest, and
maybe more in the future) . For example:

# file 1
trusted.overlay.redirect="xxx"

# file 2
trusted.overlay.redirect="yyy"

That makes the existing predefined prefixes ineffective in both image
size and runtime performance.

Solution Proposed
====================
Let's introduce long xattr name prefixes now to fix this.  They work
similarly as the predefined name prefixes, except that long xattr name
prefixes are user specified.

When a long xattr name prefix is used, the shared long xattr prefixes
are stored in the packed or meta inode, while the remained trailing part
of the xattr name apart from the long xattr name prefix will be stored
in erofs_xattr_entry.e_name.  e_name is empty if the xattr name matches
exactly as the long xattr name prefix.

Erofs image sizes will be smaller in the above described scenario where
all files have diverse xattr values with the same set of xattr names[2],
such as having following xattrs like:

trusted.overlay.metacopy=""
trusted.overlay.redirect="xxx"

Here are the image sizes for comparison (32-byte inodes are used):

```
7.4M  large.erofs.T0.xattr
6.4M  large.erofs.T0.xattr.share
```

- share: "--xattr-prefix=trusted.overlay.redirect" option of mkfs.erofs.
w/ this option, the long xattr name prefixes feature is enabled.

It can be seen ~14% disk space is saved with this feature in this
typical workload, therefore metadata I/Os could also be more effective
then.

Test
====
It passes erofs/019 of erofs-utils.


[1] https://lore.kernel.org/all/CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com/
[2] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i



Gao Xiang (1):
  erofs: keep meta inode into erofs_buf

Jingbo Xu (6):
  erofs: initialize packed inode after root inode is assigned
  erofs: move packed inode out of the compression part
  erofs: introduce on-disk format for long xattr name prefixes
  erofs: add helpers to load long xattr name prefixes
  erofs: handle long xattr name prefixes properly
  erofs: enable long extended attribute name prefixes

 fs/erofs/data.c     |  23 +++++----
 fs/erofs/dir.c      |   3 +-
 fs/erofs/erofs_fs.h |  20 +++++++-
 fs/erofs/internal.h |  20 ++++++--
 fs/erofs/namei.c    |   4 +-
 fs/erofs/super.c    |  42 +++++++++-------
 fs/erofs/xattr.c    | 116 +++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/xattr.h    |   4 ++
 fs/erofs/zdata.c    |   4 +-
 9 files changed, 192 insertions(+), 44 deletions(-)

-- 
2.19.1.6.gb485710b

