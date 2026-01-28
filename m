Return-Path: <linux-erofs+bounces-2234-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFhtBJcXemkq2gEAu9opvQ
	(envelope-from <linux-erofs+bounces-2234-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 15:05:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1CA2760
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 15:05:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1PDL6npNz2xlK;
	Thu, 29 Jan 2026 01:05:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769609106;
	cv=none; b=BvM5PZo0KuEyWBEJD7kAChZ8pHT7BFuibmY+xBsV0BhpRW3sbk1n/Fr8mNNRSn3ll/HyNNDNynPMpDG9JRcdVEf+J6PbfngKUQezz9Fpsqih6c/+KOZpZ+PDrdu+BL6jjnEm3GsANJEoQ9Gvrzo9tzrI494vhBNOPixx678r8vxW3J9pQh8UbQuGocPTk1sd1NZVydh5ZWnLg+uHsFQ95VoEi3tHSrr3jlolcHg0XqOEw94yIEn/fxW6aC0JdzLKhfAKBr5UN5l66lk/CIrsbSYbLY1brO5xPS1U4GgU05yrT0p00WEwKHZKKcWxBe2W8k7cX473XMjalcF0DSnLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769609106; c=relaxed/relaxed;
	bh=kXKOD/xgSXxZoa8bZ3p44g7V6hlanhsk+ei2kBRi79Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izeUP7UNUvfr9MH9bVsd4QrmzGpGsVZx8cptkCCzvtIHZmuwAxHunY1p0jvdjiNuJZBZNB4NIefJGm0XDXNRseD5W8iAbJZkE7NouxRSUNrOT5Frsz2JVp4MKnqkHFJizNSwQ4O7/2D0W1Yo7j40z10Sc5g5ZDdjXcvx2quh1bGnm8s1lOsegbNzGah7mlBd3+wY/V6PGAovx+2o9WRiwfHetAoqHYYU9W/140fsUIDjBSnV2rjadkR50HtUCdsZWdahKQSOmRKZdbrLv75+4t/o+2U/Wr9aIb7XR27YqZCiM38e3aoFrshG6DP04PTCJpa4LO59c1exhjgJE1BmPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=obvX9IMO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=obvX9IMO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1PDF6G40z2xjK
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jan 2026 01:04:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769609093; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kXKOD/xgSXxZoa8bZ3p44g7V6hlanhsk+ei2kBRi79Y=;
	b=obvX9IMOqOxJXjXVtN4aBo87hhZokXJxS2hCv01pFyoKrSxmKTjX8woZ48q77sd8HkEAI6KjcV/KFe4PZssVO1Ie1q/H3xQCorNTXI/s00GXK4mkHLiL7fdmyNsndZk7R7WCzKHQ1fB48QhuaRYgyXDaZsBRDSqdpEinXiieQMo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy3hRYw_1769609087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 22:04:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH v2] erofs: mark inodes without acls in erofs_read_inode()
Date: Wed, 28 Jan 2026 22:04:46 +0800
Message-ID: <20260128140446.2993210-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260128035408.2172802-1-hsiangkao@linux.alibaba.com>
References: <20260128035408.2172802-1-hsiangkao@linux.alibaba.com>
Precedence: list
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2234-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 82D1CA2760
X-Rspamd-Action: no action

Similar to commit 91ef18b567da ("ext4: mark inodes without acls in
__ext4_iget()"), the ACL state won't be read when the file owner
performs a lookup, and the RCU fast path for lookups won't work
because the ACL state remains unknown.

If there are no extended attributes, or if the xattr filter
indicates that no ACL xattr is present, call cache_no_acl() directly.

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - use `le32_to_cpu` for `ih->h_name_filter`.

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
+		if ((le32_to_cpu(ih->h_name_filter) & bitmask) == bitmask)
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


