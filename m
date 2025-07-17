Return-Path: <linux-erofs+bounces-654-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1AB083BA
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 06:23:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjKYP4nH4z2yDk;
	Thu, 17 Jul 2025 14:23:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752726217;
	cv=none; b=oLMhc2aMINfg55AFtXG+0L1HYooVEOP8IXtTGi9cdeksP02IcCfbiEEXA+KwTyq4Z4t/ZPNJUsMRZsHZXijOeM86YSgHjyLDRYvft2t2wNRNbM26ETZ9QhDJEfH1OzVeI0Tsu2pewIvYok619QZz3kItBaYLVwhm7CBrjsClVXd8yHqtOxz+rBjgdLQlu8lG12B4pKWfDuVQ2BA9FOySTYteikntxy5tP/MEk12zFz8Ncr8ODiXwnqjW9aVRfnJd7ZtA1hFeJFinQRjIsXWaC5ClmGt9mx+AOQOLmZtf/LAaYGL8LNVfPYuND/jhJEw5PavZ+KzuniOKdVOSZDCROA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752726217; c=relaxed/relaxed;
	bh=rVocjUTMdqY3F7MTEp23/vxTEANqAcDzbPzEjqdDKQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8373rDN16LEFWymAMudabDNWmblQ8ywklxTK9q1CKItt5hvhesSCM8Ux3T6plHGkC9tqCX4IGb8BGHoMKubQ2oy8A3zRyvMhn63S2ywc1FFYdXMUxGUUl4+6XSu/fSxPERo70HS8MP1FYJV6EJBqqtCA7XJBprRqnPQyRv2rYBSL7fd7SYrzZD7KUh6iKQfQ2ZnBUK3l/wAre4aolgQJjPjopi0uLiW05tuu+WqEAonLl/ChfLFGCX0gn1ivAfE2HD3dgv29CWimL4tBbgNx2VnVzBfCcHapISn6ce9bpyPI2UBX2nwhZnUD/tk1fnksGcPONZhmGG1JILM858A4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P0KmioBf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P0KmioBf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjKYM4PC8z2xlL
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 14:23:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752726210; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rVocjUTMdqY3F7MTEp23/vxTEANqAcDzbPzEjqdDKQw=;
	b=P0KmioBfvNcTBYz3kzQ394TNCL9lcTvLJcMsFPT36AEqEILiAHfNd+oydtaj6W7ONyddE32SMgZ/N/swpOBTAeNuTlB5DfjpTRhsiY4fAnq23DK/eEfakgolEYwiXqsf86mX+3078cKfS09nEiqgHtNAbeIAPEZcSmvRtYuyNIc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6ptJp_1752726199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 12:23:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: remove ENOATTR definition
Date: Thu, 17 Jul 2025 12:23:17 +0800
Message-ID: <20250717042317.1218597-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

ENOATTR is not defined in Linux; use ENODATA instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 32 ++++++++++++++++----------------
 fs/erofs/xattr.h |  3 ---
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 9cf84717a92e..d61110f511e0 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -72,7 +72,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 			ret = -EFSCORRUPTED;
 			goto out_unlock;	/* xattr ondisk layout error */
 		}
-		ret = -ENOATTR;
+		ret = -ENODATA;
 		goto out_unlock;
 	}
 
@@ -266,20 +266,20 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 			(entry.e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
 
 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
-			return -ENOATTR;
+			return -ENODATA;
 
 		if (it->index != pf->prefix->base_index ||
 		    it->name.len != entry.e_name_len + pf->infix_len)
-			return -ENOATTR;
+			return -ENODATA;
 
 		if (memcmp(it->name.name, pf->prefix->infix, pf->infix_len))
-			return -ENOATTR;
+			return -ENODATA;
 
 		it->infix_len = pf->infix_len;
 	} else {
 		if (it->index != entry.e_name_index ||
 		    it->name.len != entry.e_name_len)
-			return -ENOATTR;
+			return -ENODATA;
 
 		it->infix_len = 0;
 	}
@@ -295,7 +295,7 @@ static int erofs_getxattr_foreach(struct erofs_xattr_iter *it)
 				entry.e_name_len - processed);
 		if (memcmp(it->name.name + it->infix_len + processed,
 			   it->kaddr, slice))
-			return -ENOATTR;
+			return -ENODATA;
 		it->pos += slice;
 	}
 
@@ -323,7 +323,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 			  sizeof(u32) * vi->xattr_shared_count;
 	if (xattr_header_sz >= vi->xattr_isize) {
 		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
-		return -ENOATTR;
+		return -ENODATA;
 	}
 
 	remaining = vi->xattr_isize - xattr_header_sz;
@@ -347,7 +347,7 @@ static int erofs_xattr_iter_inline(struct erofs_xattr_iter *it,
 			ret = erofs_getxattr_foreach(it);
 		else
 			ret = erofs_listxattr_foreach(it);
-		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
+		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 
 		it->pos = next_pos;
@@ -362,7 +362,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	struct super_block *const sb = it->sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	unsigned int i;
-	int ret = -ENOATTR;
+	int ret = -ENODATA;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		it->pos = erofs_pos(sb, sbi->xattr_blkaddr) +
@@ -375,7 +375,7 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 			ret = erofs_getxattr_foreach(it);
 		else
 			ret = erofs_listxattr_foreach(it);
-		if ((getxattr && ret != -ENOATTR) || (!getxattr && ret))
+		if ((getxattr && ret != -ENODATA) || (!getxattr && ret))
 			break;
 	}
 	return ret;
@@ -403,7 +403,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 				EROFS_XATTR_FILTER_SEED + index);
 		hashbit &= EROFS_XATTR_FILTER_BITS - 1;
 		if (vi->xattr_name_filter & (1U << hashbit))
-			return -ENOATTR;
+			return -ENODATA;
 	}
 
 	it.index = index;
@@ -419,7 +419,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	it.buffer_ofs = 0;
 
 	ret = erofs_xattr_iter_inline(&it, inode, true);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		ret = erofs_xattr_iter_shared(&it, inode, true);
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
@@ -432,7 +432,7 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct inode *inode = d_inode(dentry);
 
 	ret = erofs_init_inode_xattrs(inode);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		return 0;
 	if (ret)
 		return ret;
@@ -446,9 +446,9 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	it.buffer_ofs = 0;
 
 	ret = erofs_xattr_iter_inline(&it, inode, false);
-	if (!ret || ret == -ENOATTR)
+	if (!ret || ret == -ENODATA)
 		ret = erofs_xattr_iter_shared(&it, inode, false);
-	if (ret == -ENOATTR)
+	if (ret == -ENODATA)
 		ret = 0;
 	erofs_put_metabuf(&it.buf);
 	return ret ? ret : it.buffer_ofs;
@@ -539,7 +539,7 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 		rc = erofs_getxattr(inode, prefix, "", value, rc);
 	}
 
-	if (rc == -ENOATTR)
+	if (rc == -ENODATA)
 		acl = NULL;
 	else if (rc < 0)
 		acl = ERR_PTR(rc);
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index b246cd0e135e..6317caa8413e 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -10,9 +10,6 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/xattr.h>
 
-/* Attribute not found */
-#define ENOATTR         ENODATA
-
 #ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
-- 
2.43.5


