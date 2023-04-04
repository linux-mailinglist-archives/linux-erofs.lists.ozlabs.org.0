Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FF6D5A2E
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxX0DQ9z3cfL
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxP3Wp3z3c8b
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfKztNq_1680595344;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfKztNq_1680595344)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:25 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 0/6] erofs-utils: introduce extra xattr name prefix
Date: Tue,  4 Apr 2023 16:02:17 +0800
Message-Id: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As discussed in [1], erofs paring with overlayfs could satisfy the
scenario which originally composefs targets.  In this case, each file of
erofs is tagged with overlay.metacopy and overlay.redirect xattr, which
can be consumed by overlayfs.

The example xattr arrangement is like:

user.overlay.metacopy=""
user.overlay.redirect="/d6/a6748c13e2ef146a9587c47cd51ef692a368b180fc3d32b1ee32df4bb99133"


In the current implementation of erofs, "user.overlay.redirect" xattr
name will consume duplicate on-disk space.  In other words, each file
will allocate on-disk space for its "user.overlay.redirect" xattr name,
which explodes the output erofs image as a consequence.

This patch set introduces extra xattr name prefix feature, in which user
could specify customised xattr name prefix through mkfs.erofs.  When
matched with a user specified extra xattr name prefix, only the
trailing part of the xattr name apart from the xattr name prefix will be
stored on disk.  Please refer to patch 3 for more details of the on-disk
format.

This feature can significantly reduces the size of the output erofs image
in the scenario where files share the same xattr name or prefix heavily.

Below is the test result of the size of the output erofs image with
different option combinations of mkfs.erofs.  This is tested on the
rootfs givin in [2].

```
4.2M  large.erofs.T0.noxattr
7.4M  large.erofs.T0.xattr
6.4M  large.erofs.T0.xattr.share
5.7M  large.erofs.noxattr
8.9M  large.erofs.xattr
7.8M  large.erofs.xattr.share
```

T0: "-T0" of mkfs.erofs, w/ this option, 32 bytes on-disk inode is used;
wo/ this option, 64 byte on-disk inode is used instead

xattr: no extra option specified
noxattr: "-x -1", i.e. disable xattr

share: "--xattr-prefix=user.overlay.metacopy" and
"--xattr-prefix=user.overlay.redirect" option of mkfs.erofs. w/ this
option, the extra xattr name prefix feature is enabled.

It can be seen ~10% disk space is saved with this feature in the typical
workload.

patch 1-2 are preparing patch.


[1] https://lore.kernel.org/all/CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com/
[2] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i


Jingbo Xu (6):
  erofs-utils: declare prefix_len as u8
  erofs-utils: extract packedfile API
  erofs-utils: introduce on-disk format for extra xattr name prefix
  erofs-utils: introduce init/cleanup routine for extra xattr name prefix
  erofs-utils: build erofs_xattr_entry upon extra xattr name prefix
  erofs-utils: mkfs.erofs: introduce --xattr-prefix option

 include/erofs/config.h    |   2 +
 include/erofs/fragments.h |  19 +++++--
 include/erofs/inode.h     |   2 +
 include/erofs/internal.h  |   3 ++
 include/erofs/xattr.h     |   3 ++
 include/erofs_fs.h        |   7 ++-
 lib/fragments.c           |  20 +++-----
 lib/xattr.c               | 104 +++++++++++++++++++++++++++++++++++++-
 mkfs/main.c               |  48 +++++++++++++++---
 9 files changed, 183 insertions(+), 25 deletions(-)

-- 
2.19.1.6.gb485710b

