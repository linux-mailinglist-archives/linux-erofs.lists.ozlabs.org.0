Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1569938938
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 08:54:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g05C+jKU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WS9xY6Rd4z3cYg
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 16:54:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g05C+jKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WS9xB43w7z3cR3
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 16:54:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721631241; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UYpSj4aowgSkneghusvV91AmrWoKKa8XDs0QdrOcNxg=;
	b=g05C+jKUrYx9P2clEZ5YHMEgvWbiofbXy5UC3u5RwxFq0DcTBxYQX2c80q8VVkn8stQlFMZpAZuSMqlD84EjspCw5hwAGu6bAd35QM+IERlpFVOa+ytF6e3Eohyyu14mGfWTXC39QYTBrZgwnmbmgC3TSwnrCyRZ8XpI3pjTNpo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WB-pwy3_1721631239;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WB-pwy3_1721631239)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 14:54:00 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC 2/4] erofs: expose erofs_iomap_{begin, end}
Date: Mon, 22 Jul 2024 14:53:52 +0800
Message-ID: <20240722065355.1396365-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240722065355.1396365-1-hongzhen@linux.alibaba.com>
References: <20240722065355.1396365-1-hongzhen@linux.alibaba.com>
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

Expose erofs_iomap_{begin, end} to prepare for the implementation
of the page cache share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c     | 4 ++--
 fs/erofs/internal.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8be60797ea2f..0d0997c53ff9 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -249,7 +249,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	return 0;
 }
 
-static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
@@ -308,7 +308,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
-static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
 	void *ptr = iomap->private;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3f1984664dac..2c695ec6ee71 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -389,6 +389,11 @@ extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 extern struct file_system_type erofs_anon_fs_type;
 
+extern int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap);
+extern int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned int flags, struct iomap *iomap);
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
-- 
2.43.5

