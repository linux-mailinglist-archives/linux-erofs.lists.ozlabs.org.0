Return-Path: <linux-erofs+bounces-143-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC7A7C95D
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Apr 2025 15:40:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVGmp3p7tz2ySY;
	Sun,  6 Apr 2025 00:39:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743860394;
	cv=none; b=SOxyx37qWWZ1RXbDOY0XbJdKBXF0v2jMmpASpjcyyjvoZHngfKdWUBfpi39U4FcWN9QKzBMD43LJ6hkyxlsffO4POHcq0z7p2aUrE0n1D3JhtgIUq4DlyfhmaPnsrHNtect6KKUZvLedW7l1Y4SxZWQc9lczaW6bN6+hHe2ZhCfZKS9xYz1nn01UZY0ueyf/JRT536g7YlYv9IehOM0BhqhG7CwCt8sGVSdSEEyXn1gxGRJNW1l4kTJf/8d6FDKgzOKaQZ5zcwWScz2UkORrBPJBI9nZx4D004pNI5xW0NCNb5s2ZenJo6gmIx1DZ9VpQCJz+S61sUJIOO6EU7fVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743860394; c=relaxed/relaxed;
	bh=gVLYILLjez9DB4oFkmkmyWymFEdgZJoo6701vCBMGuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUhJsBNLPtN88jM22xs5NW2Kze0V8yoQcKkzPxrgUxqQ2VE99qnD7ooDOhX25h3xBuMEdejYYxwT6VvsO1t7JqlQ4TzZCpW7UNhGOS3J7n2jN1VZUVwuj9xKJPBZtYfsAM41OnM/V3CONDKBRHt0nLTApgv6FWtgkD0sx96IKpi0htjO+cn72XMnbJ/LXfTWN8mxTEEusrQBANT4Htua4UBGzq0W8S6modn8+dsMoY1pBN1t3yUf9URQ41iucwOiWWR2iivDMqRiL2cooEQ/NgplNf2JlSNRnNbnXrLTcKkuOe7Ai7IJgk7A2cn6pHSXPpwjZg6JG/5+CS/fIODxbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ejsJBV1p; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ejsJBV1p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVGml3GJ0z2yGY
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Apr 2025 00:39:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743860386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gVLYILLjez9DB4oFkmkmyWymFEdgZJoo6701vCBMGuo=;
	b=ejsJBV1pQ6kadz5WcI9Q+dDVOBAuxOTKos1NJtF7ALEPbQNQoG7nuVPkXyygUCBlr0VTI9yVS3hzDd/CrMqXBEommYDKtSvatxdG0i7iVdncdhybylqcOfCf0Kxr3FDiJs4S8YijULK6uu8Aapkpzxa0c0VDAvnoV2xY4rXVB70=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WVGxfh3_1743860383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Apr 2025 21:39:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: lib: use atomic operations for `vi->flags`
Date: Sat,  5 Apr 2025 21:39:37 +0800
Message-ID: <20250405133937.2665477-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250405133937.2665477-1-hsiangkao@linux.alibaba.com>
References: <20250405133937.2665477-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Since `vi->flags` can be accessed by multiple threads.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/atomic.h   | 5 +++++
 include/erofs/internal.h | 9 ++++++---
 lib/xattr.c              | 6 ++----
 lib/zmap.c               | 4 ++--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
index f28687e..142590b 100644
--- a/include/erofs/atomic.h
+++ b/include/erofs/atomic.h
@@ -22,6 +22,11 @@ __n;})
 	__atomic_store(ptr, &__n, __ATOMIC_RELAXED); \
 } while(0)
 
+#define erofs_atomic_set_bit(bit, ptr) do { \
+	typeof(*ptr) __n = (1 << bit);    \
+	__atomic_or_fetch(ptr, __n, __ATOMIC_ACQ_REL); \
+} while(0)
+
 #define erofs_atomic_test_and_set(ptr) \
 	__atomic_test_and_set(ptr, __ATOMIC_RELAXED)
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2f71557..90bee07 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -176,8 +176,11 @@ EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
-#define EROFS_I_EA_INITED	(1 << 0)
-#define EROFS_I_Z_INITED	(1 << 1)
+#define EROFS_I_EA_INITED_BIT	0
+#define EROFS_I_Z_INITED_BIT	1
+
+#define EROFS_I_EA_INITED	(1 << EROFS_I_EA_INITED_BIT)
+#define EROFS_I_Z_INITED	(1 << EROFS_I_Z_INITED_BIT)
 
 struct erofs_diskbuf;
 
@@ -191,7 +194,7 @@ struct erofs_inode {
 
 	union {
 		/* (erofsfuse) runtime flags */
-		unsigned int flags;
+		erofs_atomic_t flags;
 
 		/* (mkfs.erofs) next pointer for directory dumping */
 		struct erofs_inode *next_dirwrite;
diff --git a/lib/xattr.c b/lib/xattr.c
index 976df14..68a96cc 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1056,7 +1056,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	int ret = 0;
 
 	/* the most case is that xattrs of this inode are initialized. */
-	if (vi->flags & EROFS_I_EA_INITED)
+	if (erofs_atomic_read(&vi->flags) & EROFS_I_EA_INITED)
 		return ret;
 
 	/*
@@ -1117,9 +1117,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
 		it.ofs += sizeof(__le32);
 	}
-
-	vi->flags |= EROFS_I_EA_INITED;
-
+	erofs_atomic_set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
 	return ret;
 }
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 70ff898..2a9baba 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -557,7 +557,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	struct erofs_sb_info *sbi = vi->sbi;
 	int err, headnr;
 
-	if (vi->flags & EROFS_I_Z_INITED)
+	if (erofs_atomic_read(&vi->flags) & EROFS_I_Z_INITED)
 		return 0;
 
 	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
@@ -624,7 +624,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 			return err;
 	}
 out:
-	vi->flags |= EROFS_I_Z_INITED;
+	erofs_atomic_set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	return 0;
 }
 
-- 
2.43.5


