Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876D4D0E75
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Mar 2022 04:47:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KCLqg6HYJz3bNx
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Mar 2022 14:47:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hongnan.li@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 311 seconds by postgrey-1.36 at boromir;
 Tue, 08 Mar 2022 14:47:03 AEDT
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KCLqW4rPVz2x9W
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Mar 2022 14:47:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hongnan.li@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V6bcFtB_1646710899; 
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com
 fp:SMTPD_---0V6bcFtB_1646710899) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 11:41:39 +0800
From: Hongnan Li <hongnan.li@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] Documentation/filesystem/dax: update DAX description on erofs
Date: Tue,  8 Mar 2022 11:41:39 +0800
Message-Id: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
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
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: lihongnan <hongnan.lhn@alibaba-inc.com>

Add missing erofs fsdax description since fsdax has been supported
on erofs from Linux 5.15.

Signed-off-by: lihongnan <hongnan.lhn@alibaba-inc.com>
---
 Documentation/filesystems/dax.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index e3b30429d703..c04609d8ee24 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -23,11 +23,11 @@ on it as usual.  The `DAX` code currently only supports files with a block
 size equal to your kernel's `PAGE_SIZE`, so you may need to specify a block
 size when creating the filesystem.
 
-Currently 4 filesystems support `DAX`: ext2, ext4, xfs and virtiofs.
+Currently 5 filesystems support `DAX`: ext2, ext4, xfs, virtiofs and erofs.
 Enabling `DAX` on them is different.
 
-Enabling DAX on ext2
---------------------
+Enabling DAX on ext2 and erofs
+------------------------------
 
 When mounting the filesystem, use the ``-o dax`` option on the command line or
 add 'dax' to the options in ``/etc/fstab``.  This works to enable `DAX` on all files
-- 
2.32.0 (Apple Git-132)

