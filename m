Return-Path: <linux-erofs+bounces-3734-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mqvrOu8rOmoX3QcAu9opvQ
	(envelope-from <linux-erofs+bounces-3734-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 08:47:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDC6B4A11
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 08:47:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=xMyCMmjD;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3734-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3734-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkwbd04W2z2y71;
	Tue, 23 Jun 2026 16:47:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782197228;
	cv=none; b=dpPES/9r05mYNLKMD14yROruSLVGAFrTaGEe2m5vxXmpZg9jEHPPEszDaOtA9E2lvd/6CZ2+oz94TbHYmafQee2bVIwTThiXa5A6H5Sir65lmGouBaNtuFj0dctN49mUrFJmk8aJZgDALzvytgKjGQ3xmOc4Mgi4f+EIAgA0j6mRKLiMX4iMtcRsAOwhsJQeGW1MO/yKWISTWDWhGJCxcuh7Bt6GuLBkbMdfU9V6RAiKUUiYO7FJS+7s+KiaHoHsd2IMh3LQgnMLakIyPl7MZ9rhzTNnH5gml2gAMS6vhofIzeNgDh2OTv6yFQ0KDSGafxBeL8ylcIldyIHRVUllKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782197228; c=relaxed/relaxed;
	bh=Xn117A7+a9k6cNgDkcElF85GgSiQTqeeBA9R5N3yXgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMuBjwMWdJlBzaND8JxEahGO+uRzAurwJsqyICZkwM/O0lkbq0PRM4UNwVGTSPzdYMNdsUsWgI2nwoocbzS/fNHmNOGdAfVhniRVqgU2ZuTj4CeP8ooCuHOLTCL3dTJHoTxwikQpl0hf8l/IIvziO5mbWyAhrCTfwQ/+aasMQL/KBf2tnv86ePyX4K4d/QFfciXGBtm7ihjIXhsYSX8DYUuSAD/SOBKC1ZLT1bnJjJoWwGBjKG6N8RTtL2+tIgIaEba9uuh9nJAOhzQ3+OIqowb60JAktXouY6O9k0xTuT6tV2n8rPo0NIOVZuVMWxvraj2Yll+BrvAd/BvrTwII3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xMyCMmjD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkwbb0GnLz2xl6
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 16:47:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782197222; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Xn117A7+a9k6cNgDkcElF85GgSiQTqeeBA9R5N3yXgE=;
	b=xMyCMmjDLQ5P14f41q6UNBwOEZ3smkzBkhZAl+IFiLflClp9uL3nV9gS2VxZPajOMOPQRjqp0q6j/S2+byizOBdMghp3wHgEpTRQJcJwpgEx0d2af5SA5SbxjPJIHPFsuOiessG1E/jAnVjtnCdeCMSwtB+kVrjKZgzCIJM+qew=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X5T4-1G_1782197216;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5T4-1G_1782197216 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 14:47:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Bastian Schmitz <bastian.schmitz@vorwerk.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 1/2] erofs-utils: lib: don't abort on compression fallback
Date: Tue, 23 Jun 2026 14:46:55 +0800
Message-ID: <20260623064655.3252148-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260623025334.1049210-1-zhaoyifan28@huawei.com>
References: <20260623025334.1049210-1-zhaoyifan28@huawei.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3734-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vorwerk.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12EDC6B4A11

From: Yifan Zhao <zhaoyifan28@huawei.com>

File-level compression fallback is control flow, not a real error.
Return an erofs-specific status code for it instead of overloading
-ENOSPC, which can also report real space failures.

Keep the global compression context reusable for that fallback while
preserving the fatal state for real errors.

Fixes: a729584ef975 ("erofs-utils: mkfs: avoid hanging if fragment is on and tmpdir is full")
Reported-by: Bastian Schmitz <bastian.schmitz@vorwerk.de>
Closes: https://github.com/erofs/erofs-utils/issues/50
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/err.h |  3 +++
 lib/compress.c      | 10 +++++++---
 lib/inode.c         |  6 +++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/erofs/err.h b/include/erofs/err.h
index 7dacc917a4c1..bf5a4e1cf9b7 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -53,6 +53,9 @@ static inline void * ERR_CAST(const void *ptr)
 	return (void *) ptr;
 }
 
+/* EROFS-specific error codes */
+#define EROFS_RETCODE_FALLBACK		MAX_ERRNO
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/compress.c b/lib/compress.c
index ea07409defef..0f448e400a2d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1375,7 +1375,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	    legacymetasize >= inode->i_size) {
 		z_erofs_dedupe_ext_commit(true);
 		z_erofs_dedupe_commit(true);
-		ret = -ENOSPC;
+		ret = EROFS_RETCODE_FALLBACK;
 		goto err_free_meta;
 	}
 	z_erofs_dedupe_ext_commit(false);
@@ -2031,7 +2031,11 @@ err_free_idata:
 out:
 #ifdef EROFS_MT_ENABLED
 	pthread_mutex_lock(&ictx->mutex);
-	ictx->seg_num = ret < 0 ? INT_MAX : 0;
+	if (ret < 0 && ret != EROFS_RETCODE_FALLBACK)
+		/* mark as failed to avoid further processing */
+		ictx->seg_num = INT_MAX;
+	else
+		ictx->seg_num = 0;
 	pthread_cond_signal(&ictx->cond);
 	pthread_mutex_unlock(&ictx->mutex);
 #endif
@@ -2044,7 +2048,7 @@ int erofs_begin_compress_dir(struct erofs_importer *im,
 {
 	if (!im->params->compress_dir ||
 	    inode->i_size < Z_EROFS_LEGACY_MAP_HEADER_SIZE)
-		return -ENOSPC;
+		return EROFS_RETCODE_FALLBACK;
 
 	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	erofs_sb_set_fragments(inode->sbi);
diff --git a/lib/inode.c b/lib/inode.c
index c225faa121e7..4c2d094bac7e 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1507,7 +1507,7 @@ static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 
 	if (ctx->ictx) {
 		ret = erofs_write_compressed_file(ctx->ictx);
-		if (ret != -ENOSPC)
+		if (ret != EROFS_RETCODE_FALLBACK)
 			goto out;
 		if (lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
 			ret = -errno;
@@ -1594,7 +1594,7 @@ static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
 		inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
 		ret = erofs_begin_compress_dir(ctx->im, inode);
-		if (ret && ret != -ENOSPC)
+		if (ret && ret != EROFS_RETCODE_FALLBACK)
 			return ret;
 	} else {
 		DBG_BUGON(inode->datalayout != EROFS_INODE_FLAT_PLAIN);
@@ -2391,7 +2391,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		ret = erofs_write_compressed_file(ictx);
 		if (!ret)
 			goto out;
-		if (ret != -ENOSPC)
+		if (ret != EROFS_RETCODE_FALLBACK)
 			 return ERR_PTR(ret);
 
 		ret = lseek(fd, 0, SEEK_SET);
-- 
2.43.5


