Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5688D374
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Mar 2024 01:46:42 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y83+cpVk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V47K82cd7z3dSr
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Mar 2024 11:46:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y83+cpVk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V47Jz6y1qz3cVG
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Mar 2024 11:46:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711500381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=paY48OCnKroS9THiyRJRfxByCLJ7MJGymmhFQObtgMk=;
	b=Y83+cpVk3+ajP3CQlg0a8mur8Ahuw/2lVEbDpQDiQwFoPX/h9KC0Jo8syqqmxvDTOS2t2zMf9ldBiKpur6SGOto9RcYJNhaunfbY7NOW01Z75whMYGKEaACpJUi3pE57yiM0RXR93MfESn1wd8hxQoeRSzoRICDgWCUHDht0jKE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W3MiOFi_1711500374;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3MiOFi_1711500374)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 08:46:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix compression fallback in tarerofs mode
Date: Wed, 27 Mar 2024 08:46:14 +0800
Message-Id: <20240327004614.1465889-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The return value of `lseek(fd, fpos, SEEK_SET)` can overflow the `int`
type.  Fix this.

Fixes: 376fb2dbe66d ("erofs-utils: lib: introduce diskbuf")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 4c29aa7..ba0419f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -497,8 +497,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 		if (!ret || ret != -ENOSPC)
 			return ret;
 
-		ret = lseek(fd, fpos, SEEK_SET);
-		if (ret < 0)
+		if (lseek(fd, fpos, SEEK_SET) < 0)
 			return -errno;
 	}
 
-- 
2.39.3

