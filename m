Return-Path: <linux-erofs+bounces-3786-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t/YRGogvQ2rXTwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3786-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F46DFE7E
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=mc1faq8R;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3786-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3786-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73r23Wmz2yYd;
	Tue, 30 Jun 2026 12:52:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787960;
	cv=none; b=SkF9WkVl3Ijf5qGqlMRiV8UZS4733XeF6eXWKzK/S6Pz8g4EHOczoCwXkCkWa22ZMedF5EZln492ZPV2/exbHNQc21Uj6ykaZ8iZhbCq0njpxT8f6kkG1m2giKRWt/t1rbsX8+CfQvBUoq7XGrLcakHfNKY/U0stlEV3+0s0TsUCfqZV+4wA23eVmxoxZ+ppsCRZcoRGHvx5j+SUWPFgzNqIvgLTFWOHszdiIz/QscfkB+Ui6xQEA9QgrAbNTv9LfcgfVUqC6xnG2pOkWQkLqBLmkW9xb6HmuOeQbKf4FrqCpQnijYb39wHHk9uLU5ggseeqQ7OBxCp7O1eSfYv6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787960; c=relaxed/relaxed;
	bh=0GVlVlyYBYknUObrhkzI3a3+u4l7oQ9wo50I7h/RcLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFwtwD7/kPm1p2t4ofGK4o2NyiTDcAG87s/0TNPR4BX6DO0vnHj9xR9XzqqwDlgo66X9z16sQLRaHTlmEoMt8MFyvcTQgDe+Bo4hvuCV0R0Bl1cpYb1fBPiQcpdF/cJbVcQynVs5+fA8nqKhMg7idEVz5vsn1kvmMYirjAvbrHdMd6gjNqipsLabKXwm/z8HugtBbzWpbHbJG6IEROXmLhNTbESovyA5o40hu1lGrFEIsWg8hfqBhLsTzcb6Fi0IHTFfdnRLPdrH2GvI2FPXtQwZrIBo/ozuaMznhiWqqB5OCkyJTPTVapty5KMYQvKZ0/uUdn6fk0UkY/bPcUPY/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mc1faq8R; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73m6MPbz2xHK
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787950; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0GVlVlyYBYknUObrhkzI3a3+u4l7oQ9wo50I7h/RcLs=;
	b=mc1faq8RhvaLoRdti/EevLtr56yxhY0lSoN9VKRbk7B6peXyEFRCDTSyUtwyU8HGfyvSth2LpA+/YgTssFn4od7gsjzbM5E2GH+53c89cR3knf6RKcKWk8PcbqaIsgO9lR1WxdRe4INPXEFfeoeMwoWWDtZmm6j6j2hucv5cg1c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2nz_1782787945;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2nz_1782787945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/7] erofs-utils: lib: fix `ictx` leak in the failure path
Date: Tue, 30 Jun 2026 10:52:18 +0800
Message-ID: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3786-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 797F46DFE7E

Coverity-id: 647272
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index e57de425be28..f7ad5a1c6c87 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1881,8 +1881,7 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 			if (!erofs_sb_has_48bit(sbi)) {
 				erofs_err("Unaligned compressed extents must be used with the 48bit encoded extent layout",
 					  ictx->max_compressed_extent_size);
-				free(ictx);
-				return ERR_PTR(-EINVAL);
+				goto err_out;
 			}
 			ictx->data_unaligned = true;
 		} else {
@@ -1894,7 +1893,7 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 		if (ictx->max_compressed_extent_size < erofs_blksiz(sbi)) {
 			erofs_err("Maximum compressed extent size (%u) must be at least the block size (%u)",
 				  ictx->max_compressed_extent_size, erofs_blksiz(sbi));
-			return ERR_PTR(-EINVAL);
+			goto err_out;
 		}
 	} else {
 		ictx->max_compressed_extent_size =
@@ -1910,6 +1909,9 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	ictx->fragemitted = false;
 	ictx->dedupe = false;
 	return ictx;
+err_out:
+	free(ictx);
+	return ERR_PTR(-EINVAL);
 }
 
 void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
-- 
2.43.5


