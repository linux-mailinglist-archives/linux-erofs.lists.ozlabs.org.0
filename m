Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BC9944E1
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 11:56:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBHd6F0Pz3bgV
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 20:56:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728381388;
	cv=none; b=iZekpb/28pBPRkW/LkZVdHl9rmqdE2CD3mtFXtZkD4YDvVuEgU4DFYJIfueXJRmFEkUBmr3gn71rWtHAv09CQwFl5w24r8xf8A08Syw/p57Kf9MEpLnGU8R9AdjXErXEZUoVbPoKIn3cHGpOe4qikxiIA9HxThVHSgsL0csV92J+gM6h2gLCYfytUcWM/0PHshkyTgdN1SZR46jOyEBr6UGLkbNWJ7KazcQJautBPMQ+EDLBr33DRsPTy9/hZWb/sElVCB3UVWqoR8jQCRomehxRo6qpTS0lCJhxKCsA/OVzGF5LkUJGVN7vAeL89KuxEls6V0nGsbHDSeLxbN+rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728381388; c=relaxed/relaxed;
	bh=R40RoxvI5Y2ML/F8sE+GUL5WsI1GRLpUALW+tN6AodQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1NVkNUUf41yrdIdadbsZZsbiwFR2MXCei6SltI16UQz+VxFEB85tYZYF3xbUwfVycKRoGoSr4GVsz/8wYs9dJFGaim25Zsu2wT6llDjiZOEswCGzNzjSbbhmWiOmcMZ3UftxpfCMte3NYYGnUo/u1lJcNzuAkc7GETXLDlEmC6nveyS+A0FtL6n77K0+yKp3A2iCQ/JpDG/YYw/L/J9NjrlQi+x44jG51owg9wsRNFIjRFBtheJdxHLeGj5nmJReNoA7RYlct08hyhBZracABDxNyBgDlPrvPvMT7mK6zVTK4NOoUDIKbw09ciaoiYfyKrvPGRmTxVVgofUE2Zdtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fxhacmP0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fxhacmP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBHX2x3Xz2yN3
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 20:56:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728381375; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R40RoxvI5Y2ML/F8sE+GUL5WsI1GRLpUALW+tN6AodQ=;
	b=fxhacmP0XCsR3VU2xJxNlOJPOtusKKbeSdFCAw/bKo0YxryfVmyeX06IYvmxjsGp0usOwO8Vky1/91kpS5mHov20rAtBtO+0x1nLgVTMAbUWn24oFD6MoxUTIPxh5RA5VjhKLkJ+e4jeiGzKDlBiM6ULAQEKDBXZcoLIwTeXEVg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGdZ8q3_1728381368)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:56:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Date: Tue,  8 Oct 2024 17:56:05 +0800
Message-ID: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Allison reported [1], currently get_tree_bdev() will store
"Can't lookup blockdev" error message.  Although it makes sense for
pure bdev-based fses, this message may mislead users who try to use
EROFS file-backed mounts since get_tree_nodev() is used as a fallback
then.

Add get_tree_bdev_by_dev() to specify a device number explicitly
instead of the hardcoded fc->source as mentioned in [2], there are
other benefits like:
  - Filesystems can have other ways to get a bdev-based sb
    in addition to the current hard-coded source path;

  - Pseudo-filesystems can utilize this method to generate a
    filesystem from given device numbers too.

  - Like get_tree_nodev(), it doesn't strictly tie to fc->source
    either.

[1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
[2] https://lore.kernel.org/r/b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/super.c                 | 41 ++++++++++++++++++++++++++------------
 include/linux/fs_context.h |  3 +++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1db230432960..8cc8350b9ba6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1596,26 +1596,17 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
 /**
- * get_tree_bdev - Get a superblock based on a single block device
+ * get_tree_bdev_by_dev - Get a bdev-based superblock with a given device number
  * @fc: The filesystem context holding the parameters
  * @fill_super: Helper to initialise a new superblock
+ * @dev: The device number indicating the target block device
  */
-int get_tree_bdev(struct fs_context *fc,
+int get_tree_bdev_by_dev(struct fs_context *fc,
 		int (*fill_super)(struct super_block *,
-				  struct fs_context *))
+				  struct fs_context *), dev_t dev)
 {
 	struct super_block *s;
 	int error = 0;
-	dev_t dev;
-
-	if (!fc->source)
-		return invalf(fc, "No source specified");
-
-	error = lookup_bdev(fc->source, &dev);
-	if (error) {
-		errorf(fc, "%s: Can't lookup blockdev", fc->source);
-		return error;
-	}
 
 	fc->sb_flags |= SB_NOSEC;
 	s = sget_dev(fc, dev);
@@ -1644,6 +1635,30 @@ int get_tree_bdev(struct fs_context *fc,
 	fc->root = dget(s->s_root);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_tree_bdev_by_dev);
+
+/**
+ * get_tree_bdev - Get a superblock based on a single block device
+ * @fc: The filesystem context holding the parameters
+ * @fill_super: Helper to initialise a new superblock
+ */
+int get_tree_bdev(struct fs_context *fc,
+		int (*fill_super)(struct super_block *,
+				  struct fs_context *))
+{
+	int error;
+	dev_t dev;
+
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+
+	error = lookup_bdev(fc->source, &dev);
+	if (error) {
+		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		return error;
+	}
+	return get_tree_bdev_by_dev(fc, fill_super, dev);
+}
 EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..54f23589ad5b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -160,6 +160,9 @@ extern int get_tree_keyed(struct fs_context *fc,
 
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc);
+int get_tree_bdev_by_dev(struct fs_context *fc,
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc), dev_t dev);
 extern int get_tree_bdev(struct fs_context *fc,
 			       int (*fill_super)(struct super_block *sb,
 						 struct fs_context *fc));
-- 
2.43.5

