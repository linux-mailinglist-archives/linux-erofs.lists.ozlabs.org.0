Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5C8949C7
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 04:59:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QGX6+Yy+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7szY6Kfkz3d2j
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 13:59:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QGX6+Yy+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7szQ1cgsz3bpp
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 13:59:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712026746; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DxxTh+utFrSgADXALpjyz9hZthEtHg6B9SAU/aXdWfI=;
	b=QGX6+Yy+WNNOw+rYEx0COHYmk/NAmjLQiQNtaypuLNbHMT/HUK/H/hKSLkgB9JnhiYaG6O8aazD/wR8BfRV0TP4YiXlXtSF/I85sM2MwirGNMM5NGHEo+vhY5RE83xcUHoRaxKU5EPLB3+aHJNDbfq76IunYWgjZBxkjuvvriek=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W3mj7mk_1712026739;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3mj7mk_1712026739)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 10:59:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: set opaque flag for directories in tarerofs mode
Date: Tue,  2 Apr 2024 10:58:58 +0800
Message-Id: <20240402025858.1729161-1-hsiangkao@linux.alibaba.com>
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

Opaque dir flag is needed if the tar tree is used immediately for
the upcoming append mode.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 7c271f6..b45657d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -909,6 +909,11 @@ restart:
 	} else if (opq) {
 		DBG_BUGON(d->type == EROFS_FT_UNKNOWN);
 		DBG_BUGON(!d->inode);
+		/*
+		 * needed if the tar tree is used soon, thus we have no chance
+		 * to generate it from xattrs.  No impact to mergefs.
+		 */
+		d->inode->opaque = true;
 		ret = erofs_set_opaque_xattr(d->inode);
 		goto out;
 	} else if (th->typeflag == '1') {	/* hard link cases */
-- 
2.39.3

