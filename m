Return-Path: <linux-erofs+bounces-2225-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLfeHHWIeWkQxgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2225-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 04:54:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F99CE23
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 04:54:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f17gh6027z2xT6;
	Wed, 28 Jan 2026 14:54:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769572464;
	cv=none; b=XSx0UWcNfC+AOyvhRvRJNkhRnPhj0dvE6SfW/25MC6BPyde0j+ErGTn9+XRzsxGtBSzZeMJnsZ7p6kG3cMSI18auurMIozhvLx7biff4Vh3ScWynXzWB/eoCd5YUG36eo5s6J6k880irgagZAmrwTP+IIFHE407Sb35MAB7QqjqKsvMntV6RQA7JANIH7brPMwY1EOM+a7EQlElUnMFybelLO4KY7qeRFHLy+5PdOesp0NW/hymwwiWtdh18TUUeLs9pJ72M+H2VplfDdVhLhxrtB99iniaKC0PNK27H2UHaf+Ztl6CGiUsemSUnAUelLBZ7V686OqqFNscyVjZgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769572464; c=relaxed/relaxed;
	bh=Ys/bT7Q8nc4Iwjya0jTbe2+fND7tobnZr6Lk8bNOB9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXiIn21dEPiJu09BaqUuJslFt25M3ojWz9T78eO674NBtBHjT/BQz/xXWd9MHTJSGdi+7AVN2Qoo7Ct2330hnPNm6Yh2tAJgiZ6CIVj0tdy5mxwd1o5tREyEZ0iCH+Vql9JJTJ/GKtVDy7LDTOFwsSLil06CZleoySTuNNp8sUy9rzPVGG4ydl2U6gFF70MwLjnJoPC7Jd8AM9tYmouE2SSp5TGAx3UhtgS7VrITzOFUSjF81ICQZ8O4HYFbeJOz0wUQJWw5pzgUM2pjHxVMoyvCBlo3+/Be5n1TDprtp76uH+93Uc0uVcVWC+bdoA747ViYmsMBcKzGCYkpn/o9+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pAQ635Yw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pAQ635Yw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f17gf2dnYz2xHt
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 14:54:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769572455; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ys/bT7Q8nc4Iwjya0jTbe2+fND7tobnZr6Lk8bNOB9M=;
	b=pAQ635Yw+GJBjFObuQQAQ2XVtUBEda+ig9D37Qt/rkGGx2pq1UOinFHHBo71XXJQakl2XKzFtqOYSnlfRYERjLtQMIm4cBkjCfs5bPS8zPDMQ/6sgGGHwies1OvntB090aMec2dEIUldMm2jM+Mc2idZABRWLphYcH9uBT6r1oE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy20I4Y_1769572449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 11:54:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: mark inodes without acls in erofs_read_inode()
Date: Wed, 28 Jan 2026 11:54:08 +0800
Message-ID: <20260128035408.2172802-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2225-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: 701F99CE23
X-Rspamd-Action: no action

Similar to commit 91ef18b567da ("ext4: mark inodes without acls in
__ext4_iget()"), the ACL state won't be read when the file owner
performs a lookup, and the RCU fast path for lookups won't work
because the ACL state remains unknown.

If there are no extended attributes, or if the xattr filter
indicates that no ACL xattr is present, call cache_no_acl() directly.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c |  5 +++++
 fs/erofs/xattr.c | 20 ++++++++++++++++++++
 fs/erofs/xattr.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bce98c845a18..2e02d4b466ce 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -137,6 +137,11 @@ static int erofs_read_inode(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto err_out;
 	}
+
+	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL) &&
+	    erofs_inode_has_noacl(inode, ptr, ofs))
+		cache_no_acl(inode);
+
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFDIR:
 		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 512b998bdfff..14d22adc1476 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -574,4 +574,24 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	kfree(value);
 	return acl;
 }
+
+bool erofs_inode_has_noacl(struct inode *inode, void *kaddr, unsigned int ofs)
+{
+	static const unsigned int bitmask =
+		BIT(21) |	/* system.posix_acl_default */
+		BIT(30);	/* system.posix_acl_access */
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	const struct erofs_xattr_ibody_header *ih = kaddr + ofs;
+
+	if (EROFS_I(inode)->xattr_isize < sizeof(*ih))
+		return true;
+
+	if (erofs_sb_has_xattr_filter(sbi) && !sbi->xattr_filter_reserved &&
+	    !check_add_overflow(ofs, sizeof(*ih), &ofs) &&
+	    ofs <= i_blocksize(inode)) {
+		if ((ih->h_name_filter & bitmask) == bitmask)
+			return true;
+	}
+	return false;
+}
 #endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 36f2667afc2d..a3ceefa1554d 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -30,4 +30,5 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+bool erofs_inode_has_noacl(struct inode *inode, void *kaddr, unsigned int ofs);
 #endif
-- 
2.43.5


