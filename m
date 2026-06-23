Return-Path: <linux-erofs+bounces-3728-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BC+ZJYz1OWq3zQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3728-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 04:55:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C46B3A32
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 04:55:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=HyMHKb5F;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3728-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3728-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkqRq1QDTz2yQL;
	Tue, 23 Jun 2026 12:55:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782183303;
	cv=none; b=i6N4PNwjwtdaE0pOgT+IeeAsO8KmiF2dd7cMf4gvPB3JCK2erDse3gsJ84AX5oFo3Y9F/CFNxNXnZ1bXQp923/qW9wDWliXFy6pNltjiTQ2luIO0ZEat7A5qEmXEczlveijKciY8oHIb+T5Vk2VVlnRQMKGf+/EjEF5UEinPTXrhftZ7FeDdx8JN6Jr3oM85tcLo4VW3BchHwnwzjtl3Ydmh0oEtPatjpEBYP/oNFiqeMtPNNsWC+10YXWe6aGYzseNSHijBX6PrMh42NRrpQEoUBQmygblHeS36BYI/BOkg2kd6wmRi1Cb8h9HZCdzmF/9RxALWiLEBda+n6JpORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782183303; c=relaxed/relaxed;
	bh=H18mJTSt/8blx9nYL42Bd4g9rKePCeB7+Z+rF95t/xQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mig44HmUBsKOssw21tl0bwZSIgp/B1/YYIspTKh/mNsA6UqaCLXWS26/F6Bj3yCmQ0zhu6mGlEkFd9qjpndlArUJHPB6ns6xP+dsO1k+2g5PIck7F7tc3MzCacIaIc1fllhYHaQ/iM+pfYcJ6A5De5iVfjTe+yCed6dQzbGFTLwuipzliKHjczb7eX0KYxeiXvJcGR/arwyuNm7TY4ACuOjySmf5KoSmvW8mrZr6oDtMptCm+Mc4LEqPfTyC6j+HPb5OL1C+/gwkT6wr4fZTsiSjBmzfIxVmM3ArpKddFei9yo1Npit9LXVueYDf/7Gg3LLtXqrfl96XDB5h4X6K+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HyMHKb5F; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkqRm3l3Xz2xwP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 12:54:59 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=H18mJTSt/8blx9nYL42Bd4g9rKePCeB7+Z+rF95t/xQ=;
	b=HyMHKb5FJTbIS9/veS3l8w5e3yIa5Tfw4svU0X/SGpcLJwa+tF5nBQKwc8iFDikbd+neYnTCL
	0sXS/ruJR2iQQlu+d7zi+VHCzNwlf30Y5Y0WXMwXbbECotVEiFcJUlB4QZPNX4SCWAnzbYepDxe
	46HIH9e5cJaFyWlvCc9ztD0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gkqGK1mk0zKm57;
	Tue, 23 Jun 2026 10:46:49 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id BADB340573;
	Tue, 23 Jun 2026 10:54:53 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Jun
 2026 10:54:53 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v2 1/2] erofs-utils: lib: don't abort on compression fallback
Date: Tue, 23 Jun 2026 10:53:33 +0800
Message-ID: <20260623025334.1049210-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3728-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,vorwerk.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 187C46B3A32

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
---
 include/erofs/err.h |  1 +
 lib/compress.c      | 10 +++++++---
 lib/inode.c         |  6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/erofs/err.h b/include/erofs/err.h
index 7dacc91..ef882c9 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -29,6 +29,7 @@ static inline const char *erofs_strerror(int err)
 }
 
 #define MAX_ERRNO (4095)
+#define EROFS_ERRNO_COMPR_FALLBACK	(MAX_ERRNO + 1)
 #define IS_ERR_VALUE(x)                                                        \
 	((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
 
diff --git a/lib/compress.c b/lib/compress.c
index ea07409..edc29ed 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1375,7 +1375,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	    legacymetasize >= inode->i_size) {
 		z_erofs_dedupe_ext_commit(true);
 		z_erofs_dedupe_commit(true);
-		ret = -ENOSPC;
+		ret = -EROFS_ERRNO_COMPR_FALLBACK;
 		goto err_free_meta;
 	}
 	z_erofs_dedupe_ext_commit(false);
@@ -2031,7 +2031,11 @@ err_free_idata:
 out:
 #ifdef EROFS_MT_ENABLED
 	pthread_mutex_lock(&ictx->mutex);
-	ictx->seg_num = ret < 0 ? INT_MAX : 0;
+	if (ret < 0 && ret != -EROFS_ERRNO_COMPR_FALLBACK)
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
+		return -EROFS_ERRNO_COMPR_FALLBACK;
 
 	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	erofs_sb_set_fragments(inode->sbi);
diff --git a/lib/inode.c b/lib/inode.c
index c225faa..9f3d7e6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1507,7 +1507,7 @@ static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 
 	if (ctx->ictx) {
 		ret = erofs_write_compressed_file(ctx->ictx);
-		if (ret != -ENOSPC)
+		if (ret != -EROFS_ERRNO_COMPR_FALLBACK)
 			goto out;
 		if (lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
 			ret = -errno;
@@ -1594,7 +1594,7 @@ static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
 		inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
 		ret = erofs_begin_compress_dir(ctx->im, inode);
-		if (ret && ret != -ENOSPC)
+		if (ret && ret != -EROFS_ERRNO_COMPR_FALLBACK)
 			return ret;
 	} else {
 		DBG_BUGON(inode->datalayout != EROFS_INODE_FLAT_PLAIN);
@@ -2391,7 +2391,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		ret = erofs_write_compressed_file(ictx);
 		if (!ret)
 			goto out;
-		if (ret != -ENOSPC)
+		if (ret != -EROFS_ERRNO_COMPR_FALLBACK)
 			 return ERR_PTR(ret);
 
 		ret = lseek(fd, 0, SEEK_SET);
-- 
2.47.3


