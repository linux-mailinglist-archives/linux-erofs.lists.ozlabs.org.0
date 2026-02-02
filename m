Return-Path: <linux-erofs+bounces-2247-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO1UL5AVgGkz2gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2247-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Feb 2026 04:10:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E5C7F7D
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Feb 2026 04:10:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4BS83m8Hz309y;
	Mon, 02 Feb 2026 14:10:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770001800;
	cv=none; b=gqRPkWfxrUgE7SITDyGoY+dxZSL+S8M62s66U8qDh8NUzdrrvkyc/prWtDZ3GZah1Z5EAXCzF7XW+6uykk1vwx/6rZzoyGdy4l02sS3xRbJNY0TG5g4pdh8E2Xj5TvkJ9OknjRsOlgMfszr7IGMoQqmKDCrts6UegJGfhTjUg+zPN4ptn0kMGKFuRC8dtQPt5Te2SCwJG/9ZHf+vEcJN5uOK8KBtfNHlXqxy96klBrwN6QvpcjK4hRoyor9StF2H563hUbtIXAJT/rK7UbrLPUTa30gYRVpkU/R0SbUJAZByNdY0jk4LSe8+IfR3HqG58fxXWGRSTBei4nGkQoInUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770001800; c=relaxed/relaxed;
	bh=iu2YtxTaLi2FjHAaBCEL14zATKdSAWbY2pM9NLCsNHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQdXq5rP/wiglIKzcrqpvPP4tMu0VcOOejJb8UcXQMID+qWNYTCAnJZYufV5oTtd2lqVE7kplkC4r2pXkdA5jHc5/Etsx6twBW6L1s/Yy6yF6cR373LlzCTk/1+0dnkCCtH78ubZUyFsOB8S6NPhgbWIqbE1INMJpsxJSjqRccbZJB+ZBIwPmmMHoZGituVRDeAsYsqPPuzhy9fYszpbBI59qjX+GrfO9DczkupSoct/Co00PFoyyX3t41Hd5z7Z/GU8T6z8NqdIYUty/ShLLfjaMgq+ECEkIYq7kb8i2jSmIjCTA8DcQHCWuSzwMQ1A5p8lzwm4Xz/IYQ8Q4zZ0Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LVZ8Yz6I; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LVZ8Yz6I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4BRv4fPZz2xd6
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Feb 2026 14:09:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770001767; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iu2YtxTaLi2FjHAaBCEL14zATKdSAWbY2pM9NLCsNHs=;
	b=LVZ8Yz6Isu1GnsDkgm4H/WLzvkvUK7HkucG8Oznh9TOZxd9OHC56BHvE2rCyNC2sw2ez16ctkflbX+cY8A76vB1fGP0Y163QtJCMiu/GpoUHxin8BCU35mzX5ifCUbRSzrWLcivdI7tN95JcGHskwsy/RL67pbJQnd+D4DIviW4=
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0WyIUhNW_1770001751 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 11:09:14 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] erofs: avoid some unnecessary #ifdefs
Date: Mon,  2 Feb 2026 11:09:09 +0800
Message-Id: <20260202030909.128365-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2247-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[mengferry@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: B36E5C7F7D
X-Rspamd-Action: no action

They can either be removed or replaced with IS_ENABLED().

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/data.c  | 20 ++++++++------------
 fs/erofs/super.c | 13 ++++---------
 fs/erofs/sysfs.c |  5 ++---
 3 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3a4eb0dececd..a2c796db4510 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -365,12 +365,10 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len)
 {
 	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
-#ifdef CONFIG_EROFS_FS_ZIP
+		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+			return -EOPNOTSUPP;
 		return iomap_fiemap(inode, fieinfo, start, len,
 				    &z_erofs_iomap_report_ops);
-#else
-		return -EOPNOTSUPP;
-#endif
 	}
 	return iomap_fiemap(inode, fieinfo, start, len, &erofs_iomap_ops);
 }
@@ -428,10 +426,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (!iov_iter_count(to))
 		return 0;
 
-#ifdef CONFIG_FS_DAX
-	if (IS_DAX(inode))
+	if (IS_ENABLED(CONFIG_FS_DAX) && IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
-#endif
+
 	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
 		struct erofs_iomap_iter_ctx iter_ctx = {
 			.realinode = inode,
@@ -491,12 +488,11 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file->f_mapping->host;
 	const struct iomap_ops *ops = &erofs_iomap_ops;
 
-	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
-#ifdef CONFIG_EROFS_FS_ZIP
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
+		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+			return generic_file_llseek(file, offset, whence);
 		ops = &z_erofs_iomap_report_ops;
-#else
-		return generic_file_llseek(file, offset, whence);
-#endif
+	}
 
 	if (whence == SEEK_HOLE)
 		offset = iomap_seek_hole(inode, offset, ops);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e52c2b528f86..7827e61424b7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -381,12 +381,10 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 	sbi->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
-#ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(&sbi->opt, XATTR_USER);
-#endif
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(&sbi->opt, POSIX_ACL);
-#endif
+	if (IS_ENABLED(CONFIG_EROFS_FS_XATTR))
+		set_opt(&sbi->opt, XATTR_USER);
+	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL))
+		set_opt(&sbi->opt, POSIX_ACL);
 }
 
 enum {
@@ -1125,11 +1123,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 
 static void erofs_evict_inode(struct inode *inode)
 {
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(inode))
 		dax_break_layout_final(inode);
-#endif
-
 	erofs_ishare_free_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 3a9a5fa000ae..6734483a440f 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -168,11 +168,10 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return ret;
 		if (t != (unsigned int)t)
 			return -ERANGE;
-#ifdef CONFIG_EROFS_FS_ZIP
-		if (!strcmp(a->attr.name, "sync_decompress") &&
+		if (IS_ENABLED(CONFIG_EROFS_FS_ZIP) &&
+		    !strcmp(a->attr.name, "sync_decompress") &&
 		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
 			return -EINVAL;
-#endif
 		*(unsigned int *)ptr = t;
 		return len;
 	case attr_pointer_bool:
-- 
2.43.5


