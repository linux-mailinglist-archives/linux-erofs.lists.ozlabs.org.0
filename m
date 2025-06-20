Return-Path: <linux-erofs+bounces-474-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28DAE11C7
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Jun 2025 05:26:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNjYy2hYSz2yPS;
	Fri, 20 Jun 2025 13:26:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750389990;
	cv=none; b=blChEl87Jv/xBByykUxsXqsz9NikLc4rbgbv0a1GIO0yLJCWjs0wspe5DTHQV7B5I1RvB3sNdNkWTq6SgAuNzPAwyVMVfcXgSdlHqumJPkDbhv9YH9dfvo88MJYM5rcYfjWMIO+LBhd67zF/Sm9tsQfNg3uTEgcSOqpKigx7laumAPiafTZrW3lxvQ5NAHGq0jb6u/D3ishm2z77YyeTyp7rIOL562AQM59hnCFmOwRxN5QqzU/nWjcZmF/uHu2wFCxHZjd6HY0Q6rdMtoWq+EKBczyNP6bRTeL9rg3vCgkDO+wqtXQriRBPKRnaBI8DtnH+b3UFAF1vqQMQYgm6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750389990; c=relaxed/relaxed;
	bh=qPj3z0Vvl1ZFjhDKth/DQTTE7GLuV9uqo/F51iV/vKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDp4ORu3Ot3PY+jCde8hLJJ5mXuczsMc+x3KAEa9pPDERQmryRlLQHu79gyadgwTkC0usR64JI5a5gbL5H/czA0GO/SxsUY+a8odMRermT2npa0c3oeZgIAtTjKNafLQ2IOPtKym6GaxcvH92OAHwn1x8FnkGN0vvtq0sS/gM6jQwuQSPd7uGI/UuZCLLZZ6nTNsH0xuaCJBUa52AaIBY1j7vTS+wjPiLqQqbUayx5/mWyTcDh72xA58JxZLVfYBWOmlM6MfeuZE4CiUAFY5ISUN2VO2DfLQd82aOjL1glW0qyqGnfcKcuI/GKSJoxZ0y5+RVzagcBfwrCVU6iO5wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SjKaE0qw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SjKaE0qw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNjYw48d7z2yF1
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Jun 2025 13:26:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750389982; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qPj3z0Vvl1ZFjhDKth/DQTTE7GLuV9uqo/F51iV/vKw=;
	b=SjKaE0qwuJBJlwuM1Z77Dl1Qrm7t18GSc4hmXnmE39vAkUKKg8VBQxLdIymErPdf2J0Jy5fsnky8gJKm0EcbwcwhqSontFzit8F11Mv616iyZZtVG2qyepcpdxZHp72+m1se9GOE2aedZyVexn+ndrjguU/4Oyea35fzrvxOEHA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeJCk4z_1750389977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 11:26:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: consolidate erofs_rebuild_get_dentry()
Date: Fri, 20 Jun 2025 11:26:16 +0800
Message-ID: <20250620032616.385805-1-hsiangkao@linux.alibaba.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - Avoid `memcmps`, which could cause potential out-of-range read risks;

 - Replace `strlen()` and `memchr()` with `strchr()`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/rebuild.c | 71 +++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index d428573..6ae5ddf 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -71,18 +71,27 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	return d;
 }
 
+struct erofs_dentry *erofs_d_lookup(struct erofs_inode *dir, const char *name)
+{
+	struct erofs_dentry *d;
+
+	list_for_each_entry(d, &dir->i_subdirs, d_child)
+		if (!strcmp(d->name, name))
+			return d;
+	return NULL;
+}
+
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq, bool to_head)
 {
 	struct erofs_dentry *d = NULL;
-	unsigned int len = strlen(path);
 	char *s = path;
 
 	*whout = false;
 	*opq = false;
 
-	while (s < path + len) {
-		char *slash = memchr(s, '/', path + len - s);
+	while (1) {
+		char *slash = strchr(s, '/');
 
 		if (slash) {
 			if (s == slash) {
@@ -90,60 +99,54 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 				continue;
 			}
 			*slash = '\0';
+		} else if (*s == '\0') {
+			break;
 		}
 
-		if (!memcmp(s, ".", 2)) {
-			/* null */
-		} else if (!memcmp(s, "..", 3)) {
-			pwd = pwd->i_parent;
+		if (__erofs_unlikely(is_dot_dotdot(s))) {
+			if (s[1] == '.') {
+				pwd = pwd->i_parent;
+			}
 		} else {
-			struct erofs_inode *inode = NULL;
-
 			if (aufs && !slash) {
-				if (!memcmp(s, AUFS_WH_DIROPQ, sizeof(AUFS_WH_DIROPQ))) {
+				if (!strcmp(s, AUFS_WH_DIROPQ)) {
 					*opq = true;
 					break;
 				}
-				if (!memcmp(s, AUFS_WH_PFX, sizeof(AUFS_WH_PFX) - 1)) {
+				if (!strcmp(s, AUFS_WH_PFX)) {
 					s += sizeof(AUFS_WH_PFX) - 1;
 					*whout = true;
 				}
 			}
 
-			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
-				if (!strcmp(d->name, s)) {
-					if (d->type != EROFS_FT_DIR && slash)
-						return ERR_PTR(-EIO);
-					inode = d->inode;
-					break;
-				}
-			}
-
-			if (inode) {
-				if (to_head) {
+			d = erofs_d_lookup(pwd, s);
+			if (d) {
+				if (d->type != EROFS_FT_DIR) {
+					if (slash)
+						return ERR_PTR(-ENOTDIR);
+				} else if (to_head) {
 					list_del(&d->d_child);
 					list_add(&d->d_child, &pwd->i_subdirs);
 				}
-				pwd = inode;
-			} else if (!slash) {
-				d = erofs_d_alloc(pwd, s);
+				pwd = d->inode;
+			} else if (slash) {
+				d = erofs_rebuild_mkdir(pwd, s);
 				if (IS_ERR(d))
 					return d;
-				d->type = EROFS_FT_UNKNOWN;
-				d->inode = pwd;
 			} else {
-				d = erofs_rebuild_mkdir(pwd, s);
+				d = erofs_d_alloc(pwd, s);
 				if (IS_ERR(d))
 					return d;
-				pwd = d->inode;
+				d->type = EROFS_FT_UNKNOWN;
+				d->inode = pwd;
 			}
+			pwd = d->inode;
 		}
-		if (slash) {
-			*slash = '/';
-			s = slash + 1;
-		} else {
+
+		if (!slash)
 			break;
-		}
+		*slash = '/';
+		s = slash + 1;
 	}
 	return d;
 }
-- 
2.43.5


