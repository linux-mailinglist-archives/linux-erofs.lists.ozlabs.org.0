Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9A98050
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 18:38:52 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DCzF267RzDqRC
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 02:38:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CnpdoA6S"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DCz81C0ZzDqQC
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 02:38:43 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id i30so1769649pfk.9
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=5HSx9u1kStwCMGO6efub2/3ZVk7xFOLAP7qgCt/Iscg=;
 b=CnpdoA6SvnHT0ne7LLGn9PZ1l6SovcQhcHLQg/q/tFj6GFHFpUGjCaKTdC2q9CVbpd
 NaPW+Z+5dgCVg7xAKJ9ari1DXx6xoqSJAHqEKXtTQiDtvTICCMXfU9O5Cfx73wBNUFUp
 c843NlR/D4esUfz1sgOeRm9ueBi0rR8uppXDv5bi3Q4Wa5KToPwMlB0F4OJxw/sQlO+x
 u6saMWl0YE0IHUsCYBE+3V+CzujveQejwey+kDd+n4xh6juFsXTzP4Fevw+ihqyoT8am
 7SA7Qoo6MtabER+04i+f0XEOwBhi1Uc1p2U1bjxuseelUH/kqjUdWc8yUWOEQ3Mr0ABX
 4eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5HSx9u1kStwCMGO6efub2/3ZVk7xFOLAP7qgCt/Iscg=;
 b=LNgZHxR5Pa9z/WnxDTLZXltFvEPQgH9bRFpwZVfJTT1dDIYezx561C2v/byzoP5V89
 ojBhq8DFnmQxhB+8ss+gqFCmWsXfT8WHrcrpuMTC9VoH9koXLQOAZ/H0RRZl+IZasCGx
 U/TNj4n8wHSjzjWRc+75joz9WymvUweS5hyXMqAguYl6wRs1yW8kQvAWoQeqr+LOZxT0
 xXJs8Nt9/Lmf9U57/2eVPfw0fr0BKbROn5h/Hj9htuaEVzFUR767pX/kYLFkqdWNEQ+5
 DqBwCAeO7Hjqkim80pVFcI0JFze+2a42vJMWIuiK6SFAvoy0xS+GZTkquurcMw43Rhsm
 SFTQ==
X-Gm-Message-State: APjAAAX32b9zC0nAS5Iuo2ZZyy/AtrQmlyO1QEOJrLTixtR14uwRTimu
 P/8rGxX4qRWLcwUo+l7BPxuvA6Pi
X-Google-Smtp-Source: APXvYqyn5fhvVZLUt5kZ09YTz0EnWRFhf40PzKsuzZnJ3C0sCXR3gxsg5qvuDH3nMR5H1iS22z4gSA==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr858647pjb.35.1566405518931; 
 Wed, 21 Aug 2019 09:38:38 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.130])
 by smtp.gmail.com with ESMTPSA id v14sm23489800pfm.164.2019.08.21.09.38.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 09:38:37 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: erofs debug utility.
Date: Wed, 21 Aug 2019 22:08:08 +0530
Message-Id: <20190821163808.6643-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello Maintainers,

After going through the recent mail thread between linux's filesystem folks
on erofs channel, I felt erofs needs an interactive debug utility (like xfs_db)
which can be used to examine erofs images & can also be used to inject errors OR
fuzzing for testing purpose & dumping different erofs meta data structures
for debugging.
In order to demonstrate above I wrote an experimental patch that simply dumps
the superblock of an image after mkfs completes.the full fletch utility will run
independently and be able to seek / print / modify any byte of an erofs image,
dump structures/lists/directory content of an image.

NOTE:This is an experimental patch just to demonstrate the purpose. The patch
lacks a lot of things like coding standard, and new code runs in the context
of mkfs itself.kindly ignore it.

kindly provide your feedback on this.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/io.h |  8 ++++++++
 lib/io.c           | 27 +++++++++++++++++++++++++++
 mkfs/main.c        | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index 4b574bd..e91d6ee 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -18,6 +18,7 @@
 
 int dev_open(const char *devname);
 void dev_close(void);
+int dev_read(void *buf, u64 offset, size_t len);
 int dev_write(const void *buf, u64 offset, size_t len);
 int dev_fillzero(u64 offset, size_t len, bool padding);
 int dev_fsync(void);
@@ -30,5 +31,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			 blknr_to_addr(nblocks));
 }
 
+static inline int blk_read(void *buf, erofs_blk_t blkaddr,
+			   u32 nblocks)
+{
+	return dev_read(buf, blknr_to_addr(blkaddr),
+			blknr_to_addr(nblocks));
+}
+
 #endif
 
diff --git a/lib/io.c b/lib/io.c
index 15c5a35..87d7d6c 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -109,6 +109,33 @@ u64 dev_length(void)
 	return erofs_devsz;
 }
 
+int dev_read(void *buf, u64 offset, size_t len)
+{
+	int ret;
+
+	if (cfg.c_dry_run)
+		return 0;
+
+	if (!buf) {
+		erofs_err("buf is NULL");
+		return -EINVAL;
+	}
+	if (offset >= erofs_devsz || len > erofs_devsz ||
+	    offset > erofs_devsz - len) {
+		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
+			  offset, len, erofs_devsz);
+		return -EINVAL;
+	}
+
+	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
+	if (ret != (int)len) {
+		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
+			  erofs_devname, offset, len);
+		return -errno;
+	}
+	return 0;
+}
+
 int dev_write(const void *buf, u64 offset, size_t len)
 {
 	int ret;
diff --git a/mkfs/main.c b/mkfs/main.c
index f127fe1..109486e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -182,6 +182,41 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	return 0;
 }
 
+void erofs_dump_super(char *img_path)
+{
+	struct erofs_super_block *sb;
+	char buf[EROFS_BLKSIZ];
+	unsigned int blksz;
+	int ret = 0;
+
+	if (img_path == NULL) {
+		erofs_err("image path cannot be null");
+		return;
+	}
+	ret = blk_read(buf, 0, 1);
+	if (ret) {
+		erofs_err("error reading super-block structure");
+		return;
+	}
+
+	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
+	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("not a erofs image");
+		return;
+	}
+
+	erofs_dump("magic: 0x%x\n", le32_to_cpu(sb->magic));
+	blksz = 1 << sb->blkszbits;
+	erofs_dump("block size: %d\n", blksz);
+	erofs_dump("root inode: %d\n", le32_to_cpu(sb->root_nid));
+	erofs_dump("inodes: %llu\n", le64_to_cpu(sb->inos));
+	erofs_dump("build time: %u\n", le32_to_cpu(sb->build_time));
+	erofs_dump("blocks: %u\n", le32_to_cpu(sb->blocks));
+	erofs_dump("meta block: %u\n", le32_to_cpu(sb->meta_blkaddr));
+	erofs_dump("xattr block: %u\n", le32_to_cpu(sb->xattr_blkaddr));
+	erofs_dump("requirements: 0x%x\n", le32_to_cpu(sb->requirements));
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -268,6 +303,7 @@ int main(int argc, char **argv)
 		err = -EIO;
 exit:
 	z_erofs_compress_exit();
+	erofs_dump_super("dummy");
 	dev_close();
 	erofs_exit_configure();
 
-- 
2.9.3

