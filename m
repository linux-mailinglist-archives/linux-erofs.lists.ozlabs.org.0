Return-Path: <linux-erofs+bounces-1837-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3CD17CB9
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jan 2026 10:55:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dr4Nk6DMDz2xWJ;
	Tue, 13 Jan 2026 20:55:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768298102;
	cv=none; b=SONFyZqiSDjD9m6E/JmIBjlk1n7ffv5eHyeg5tQ14Z6sgcxguazCovpT7BVSQk3mdzTLthdzBCcJbnISFD+KZ52VkEgyfXRXNrurddmCcg5333iqTw0A5v2/yX98n2jheoeLMIf9vkoRZ4aG+vmrWAMNhXkMv/j1rpmsYgbOXOqJQZaiBMRRn8bdgeZB1ClhU2u9Q6VJ7n3Ajkcp+bHlkh77inWIPHQfPKGn46Ud1B6L/5xDVRbm8FuIwItkK7oEI6DEczCHx665BwyZpz7x8IoOHUSNxO+y4WJjorgwPzu6vqi7zDEK9zm64IDJXHfgFOvozm8vVvtRWM09XSlwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768298102; c=relaxed/relaxed;
	bh=SGhe7Th5ldhGMce2qdrOf8GmktXc9aejfOzgKyBbdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBOkMwevASEtGEByL5x7Z+VO8EGJHgjWzt7yq4eNLi0EIK8VWcDgvwp97wAmdV1ndP30Fx8xkt0Yl81w27LWkvuvY9qFOd7C7eFaK+oXbe4dtiq4whEY2fRJPOJuNI0nI2Hdvrr8GTQEH4MBTLhwbKK1lxq2BVpic5uzQJLRV35JkPTIJcluQv8wFHHlQE8wGnX6GPxXp71pZcEbzaViFwn8aPB/33+v43cFFNqNkpS0V4wT3LCzAma4UUrjFLvqvIcv+MVKiC06biBF8CPTT7EKuy6mkBUhcwGoDrh2XMJAXKhsQfMrOwOUgZfNZ+xG2fw8Mb8eJ5AnVUZGBE3AVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VnznkP9f; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VnznkP9f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dr4Nh5SChz2xKx
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 20:54:58 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768298093; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SGhe7Th5ldhGMce2qdrOf8GmktXc9aejfOzgKyBbdxg=;
	b=VnznkP9fcSdn8ryJJuU5aUV7Ok77lsnc9qNefIiSSZBBvZCMPbFSUkEiE08KZlwmghs98lpBRqhYueXrpLRyJaNew3kvzxGMPAsLQBMqTHG3sGfVBzuud4FkCmbDJZcdqW3FDofrwJp8aw/A5eYO5pee5FcA+YwhAzc4SBp9njQ=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx-PM94_1768298088 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Jan 2026 17:54:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: ignore xattr_types[0] when matching xattr prefixes
Date: Tue, 13 Jan 2026 17:54:46 +0800
Message-ID: <20260113095446.1011168-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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

It's not the preferred prefix to target xattr names, at least.

Fixes: 2faeebb47c68 ("erofs-utils: lib: introduce prefix-aware erofs_setxattr()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 764aee3..37ce55b 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -213,7 +213,8 @@ bool erofs_xattr_prefix_matches(const char *key, unsigned int *index,
 
 	*index = 0;
 	*len = 0;
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+	for (p = xattr_types + 1;
+	     p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
 			*index = p - xattr_types;
@@ -506,10 +507,9 @@ int erofs_setxattr(struct erofs_inode *inode, int index,
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_xattritem *item;
-	struct erofs_xattr_prefix *prefix = NULL;
+	const struct erofs_xattr_prefix *prefix = NULL;
 	struct ea_type_node *tnode;
 	unsigned int len[2];
-	int prefix_len;
 	char *kvbuf;
 
 	if (index & EROFS_XATTR_LONG_PREFIX) {
@@ -526,16 +526,16 @@ int erofs_setxattr(struct erofs_inode *inode, int index,
 	if (!prefix)
 		return -EINVAL;
 
-	prefix_len = prefix->prefix_len;
-	len[0] = prefix_len + strlen(name);
+	len[0] = prefix->prefix_len + strlen(name);
 	len[1] = size;
 
 	kvbuf = malloc(EROFS_XATTR_KVSIZE(len));
 	if (!kvbuf)
 		return -ENOMEM;
 
-	memcpy(kvbuf, prefix->prefix, prefix_len);
-	memcpy(kvbuf + prefix_len, name, EROFS_XATTR_KSIZE(len) - prefix_len);
+	memcpy(kvbuf, prefix->prefix, prefix->prefix_len);
+	memcpy(kvbuf + prefix->prefix_len, name,
+	       EROFS_XATTR_KSIZE(len) - prefix->prefix_len);
 	memcpy(kvbuf + EROFS_XATTR_KSIZE(len), value, size);
 
 	item = get_xattritem(sbi, kvbuf, len);
-- 
2.43.0


