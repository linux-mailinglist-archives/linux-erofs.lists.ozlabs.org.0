Return-Path: <linux-erofs+bounces-3347-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPkuEIsu52mf5AEAu9opvQ
	(envelope-from <linux-erofs+bounces-3347-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 10:00:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B68437E89
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 10:00:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0FBv2DXyz2yFl;
	Tue, 21 Apr 2026 18:00:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776758407;
	cv=none; b=GYsCShge6lTEXqHOT+H8kgEswwQ2GPzVkRQhofgOZL532B8dFqQ9ok1MnQgdnmVA5IqJIypQxe48KXjp+vzYbAa312oL8gGJozJ887jUanNwV90Jn2WAn6yaRxqun7jCiXLKd0cqxjRc7uNqzIDNYBARhX4Xi63XrKlISdOz143OVq09xn/9KKixsvTo8Rdq9rd6X5UN64ZWlifXcGiVZktBvv2YwcfMRB8hbN//0bEQ0Jze4hLX9FjQ0VCTxdDCvQyZ3o9bv4RIa5LZrhvfHtLyBH1fuE3eOwsvuuzqQN6/9RQelMwSQrXHoi0WjVF9dylI0IqrC0aGoo8Bcq/s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776758407; c=relaxed/relaxed;
	bh=82ZYEAF+o6EDmn/JvVmly1vmB9MK6Et3xx685ms0Z+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXlaXeMdnPiRtmqZXlvOX8SoS8TmqWPXbjYMA8khFhAwuWZu5S2bqOOuXtMIC2EdVss+SPwpuJsOoEJJhT/y/XjXvIRPzEW6fQ8NPLYJZxCZAchKNtf9H2H1KvjolyaFuttTGz2o2CWLo2LRg4LDylujCZ8ThAo1C7YuZ9W3Q+BEXwUW83UAv6vVfhC1bF3hyfHTOWQtqTzYbi7J4F4T+hCgFC+b9bRsdB3mXKCgldn4gXrSVLxCicEg4+xDFSi8Xvdz2Uou23HwCsFu13N/uT85XGyxfxYyNxsZO7KYN/5pezesqPiiHPg/Ige9Vv+M5zGr8wc9FT1lQEjZsTLDJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cnQZzc8F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cnQZzc8F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0FBs0FwFz2ySW
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 18:00:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776758399; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=82ZYEAF+o6EDmn/JvVmly1vmB9MK6Et3xx685ms0Z+s=;
	b=cnQZzc8FVqvU/tzadw3y0UpBKmwx9drp82qTaO/SMNYe+cRm3AzHgTx34Q3D//QC7qOQUEdxeVXoG0vBNoabPud9s+ISxfxwVfFIpzp0gx6KP0hBuxHXfzIB7MPCUcDJwP25mxJ/qKN+qNdT1dGjeo6zXrbhFzXldTWPQ7yI0yA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X1SAx76_1776758393;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1SAx76_1776758393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Apr 2026 15:59:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] erofs: fix the out-of-bounds nameoff handling for trailing dirents
Date: Tue, 21 Apr 2026 15:59:52 +0800
Message-ID: <20260421075952.975069-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
References: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-3347-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,gmail.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,outlook.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,sashiko.dev:url,alibaba.com:email]
X-Rspamd-Queue-Id: E6B68437E89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we already have boundary-checks for nameoffs, but the trailing
dirents are special since the namelens are calculated with strnlen()
with unchecked nameoffs.

If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
maxsize - nameoff can underflow, causing strnlen() to read past the
directory block.

nameoff0 should also be verified to be a multiple of
`sizeof(struct erofs_dirent)` as well [1].

[1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com

Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
Cc: stable@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v4:
 - switch to `if (!nameoff || nameoff >= bsz || (nameoff % sizeof(*de)))`
   as suggested by Chao.

 fs/erofs/dir.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..4aa52a5f204a 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		const char *de_name = (char *)dentry_blk + nameoff;
 		unsigned int de_namelen;
 
-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		/* non-trailing dirent in the directory block? */
+		if (de + 1 < end)
 			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		else if (maxsize <= nameoff)
+			goto err_bogus;
+		else
+			de_namelen = strnlen(de_name, maxsize - nameoff);
 
-		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		/* a corrupted entry is found (including negative namelen) */
+		if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
+		    nameoff + de_namelen > maxsize)
+			goto err_bogus;
 
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
@@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		ctx->pos += sizeof(struct erofs_dirent);
 	}
 	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 static int erofs_readdir(struct file *f, struct dir_context *ctx)
@@ -88,7 +90,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		}
 
 		nameoff = le16_to_cpu(de->nameoff);
-		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {
+		if (!nameoff || nameoff >= bsz || (nameoff % sizeof(*de))) {
 			erofs_err(sb, "invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
-- 
2.43.5


