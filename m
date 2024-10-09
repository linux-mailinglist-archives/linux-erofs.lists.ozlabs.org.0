Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B93995E2B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 05:32:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNdjn5dBbz2yx7
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 14:32:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728444731;
	cv=none; b=kUMQ71jfrDVgRxXLEyj8SZAWrSJc8SVVApOiozRgwPybJa35+s+fiDS5yQ/1IQ29jch9hlsD+W+eUeH+A0qb8mR2SM2qzbjG0HRJ1zDFD24aucucADBvzDl1niljiuKjn72fKeuqj+El9N9OqmqrvFAFgl6Eu4OfndfxOyM2IKKX0+5QXhBXUhlQrwZsc/I0s8Sg/ClIQl1GkFUuK1AdyiirMfy2hiTwBtr3b+oIa5zynrTe2kNTxjJrf44HI6E2ScmeBEaMR9PAhCVbLvSjsKi+VSZJEN1NfPV5yoap/QxPnguMKadhR25pTUSnJK4f2ReMMhOmntuln9mCRB0N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728444731; c=relaxed/relaxed;
	bh=Q3VvV8dzU7fDz1bTrlR+T03pQEuaXvrJZsIVuE0YJXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cg2QaVm9ljNFCzMZCScGczP4oxQPCPeoAbg1eN/CZXFd8jTcvsUFgcGuzCdd1SI1t65WCNde63ZcyzB1tn/Vny3kYhkYOfvKMBlOxH6x9JVv6wdjNOYE5x5kEE5GXyOflAYjzUI2xZ9wevr4wSzCygNmvAtYzF2foom9KfWsg8N3KAJSDeAEiv+wU2cZUBxyCb2Mhs5BpcqOvuTyvmyc+V5ZuKD0KYlHkPGXa3dsEFe8FVuztvTW7Ewt5xMyhLUhKG12DQlAyaW8iU5rP8sHZhJr7sX8vsL8BFK+WbADpO2OLgzr99nKb1Jtj4P7lcFJkVJ08e/9a1Ifg1yF9HPeqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AIlMKogB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AIlMKogB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNdjh3cn9z2yNc
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2024 14:32:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728444720; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q3VvV8dzU7fDz1bTrlR+T03pQEuaXvrJZsIVuE0YJXE=;
	b=AIlMKogB5YYy+qgWQoS/bKfRXwLRXmim3j+qo8Fk3U7iuNgpN25bJSiqRv1ly5w2rfnMI7M7VSNE3u4e5QdtqfXopiwAFYxH3CZphLOOOKErUv55LDcV8oXNA2Zh9rwJAUt4gJlD15Bv9c4AOWNJ76U3alPi0g8GOYsaLZwIuCQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGhJfrz_1728444712)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 11:31:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Date: Wed,  9 Oct 2024 11:31:50 +0800
Message-ID: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
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

Add get_tree_bdev_flags() to specify extensible flags [2] and
GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
since it's misleading to EROFS file-backed mounts now.

[1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
[2] https://lore.kernel.org/r/ZwUkJEtwIpUA4qMz@infradead.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20241008095606.990466-1-hsiangkao@linux.alibaba.com
change since v1:
 - add get_tree_bdev_flags() suggested by Christoph.

 fs/super.c                 | 26 ++++++++++++++++++++------
 include/linux/fs_context.h |  6 ++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1db230432960..c9c7223bc2a2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1596,13 +1596,14 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
 /**
- * get_tree_bdev - Get a superblock based on a single block device
+ * get_tree_bdev_flags - Get a superblock based on a single block device
  * @fc: The filesystem context holding the parameters
  * @fill_super: Helper to initialise a new superblock
+ * @flags: GET_TREE_BDEV_* flags
  */
-int get_tree_bdev(struct fs_context *fc,
-		int (*fill_super)(struct super_block *,
-				  struct fs_context *))
+int get_tree_bdev_flags(struct fs_context *fc,
+		int (*fill_super)(struct super_block *sb,
+				  struct fs_context *fc), unsigned int flags)
 {
 	struct super_block *s;
 	int error = 0;
@@ -1613,10 +1614,10 @@ int get_tree_bdev(struct fs_context *fc,
 
 	error = lookup_bdev(fc->source, &dev);
 	if (error) {
-		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		if (!(flags & GET_TREE_BDEV_QUIET_LOOKUP))
+			errorf(fc, "%s: Can't lookup blockdev", fc->source);
 		return error;
 	}
-
 	fc->sb_flags |= SB_NOSEC;
 	s = sget_dev(fc, dev);
 	if (IS_ERR(s))
@@ -1644,6 +1645,19 @@ int get_tree_bdev(struct fs_context *fc,
 	fc->root = dget(s->s_root);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_tree_bdev_flags);
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
+	return get_tree_bdev_flags(fc, fill_super, 0);
+}
 EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..4b4bfef6f053 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -160,6 +160,12 @@ extern int get_tree_keyed(struct fs_context *fc,
 
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc);
+
+#define GET_TREE_BDEV_QUIET_LOOKUP		0x0001
+int get_tree_bdev_flags(struct fs_context *fc,
+		int (*fill_super)(struct super_block *sb,
+				  struct fs_context *fc), unsigned int flags);
+
 extern int get_tree_bdev(struct fs_context *fc,
 			       int (*fill_super)(struct super_block *sb,
 						 struct fs_context *fc));
-- 
2.43.5

