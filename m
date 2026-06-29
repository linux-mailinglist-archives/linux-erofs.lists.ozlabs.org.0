Return-Path: <linux-erofs+bounces-3779-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hBSsHItiQmrW5wkAu9opvQ
	(envelope-from <linux-erofs+bounces-3779-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 14:18:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FEC6D9F4E
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 14:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b="b61Gv/gZ";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3779-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3779-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=lst.de (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gplfs20DVz2yT0;
	Mon, 29 Jun 2026 22:18:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782735493;
	cv=none; b=aRSz8hPO+7ZphNUKNYSDc8oOKxeLywoFi6XBVxAcPbroyfLw/vSsoGd1uctdM4U+2SnYl7JIybWAiuvV6XgU1oVjarpw4epZbwr/BEDJp43nvZjgNEtv9qTK1Cbqll1vytSNf0lSH0zO3sZV7TQG/sjefupNGTJKcEQMhYtEcA6FcuFK0YHOpVVMQEUgzmbEBQL0q1WGd5h7MB4UETI1HTH3y164eQMW6lg4ZGIpI/yWMvitm+zm9AT/1PzwAOdsb4Gf7hqypBrtcxNqZeZRHrLitlNrR246fABpAL28qH5hgwpNGqlIX2dIFw8HpFrd7TEt8OjQM5zgJ94+N9UnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782735493; c=relaxed/relaxed;
	bh=h42S6vF9jz0jHC3GNT/SpM3g946pL/rq1oM/rG26wEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dri0mOBAFA+PXegl78YojNZeqMDRh2iivW4hpUmgoX+zI/T3CmZMjObZLyZavTHAjNAJdXUCvqoPFM+vgevRhL7OOqyYIfGwoUkLOOPfL/48XalUNT42Ku5z7pZXUZVTtgKWXehJOABhx+kkQoOZy5/rxcEWwJhw3L2iINbSHbpOlnzOOPyqOyzaD6LQY2nywFg6evcBgKTldKtBw8DbOze6M3gAtXZaKikMflRtVdFCPmZFbcYaTlu/yjQnyxq54EDT7d4TV1whno0Y5KElcL8pq4QZJvZKQCDkGHYflfyWb/TRiYkdY7viaLoGjCOse1C63/vCEOQpve0RtGiY2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b61Gv/gZ; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+90a5730460baaf6f6760+8345+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gplfr4vzTz2ySS
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 22:18:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h42S6vF9jz0jHC3GNT/SpM3g946pL/rq1oM/rG26wEc=; b=b61Gv/gZCJM16zv6Ydc9uKDS5t
	38JmFOyxa/9pITmkkkNJtNSqL3/ajXTzjIqAmb4BFqeBRfE5mCtV7QXjUGxvb/jHlbDIcWfaPN2Iq
	KQ+p6ENl6KXr9NEtnhvNWD3UeULlhLXG7dJGoaxAA/i52Z26BkN912Ez4XzizX1iHYLqOx4YM/Yfu
	uRQenjp8oMoTaMut683Bk8Ib5SddchLvYTFX77r1H+BskLsLwOiwfM2LwlNVerg/b/S52y3NuGEo6
	HuWhMLmC8JRZvWZnSiOuBcS/5SgoK3Y4eYY70yZTAWsINuLtWGbH/tNjjilzjBrKtaGH3D/usUK7D
	g91ZEw1Q==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weAwB-0000000EX0O-0zYW;
	Mon, 29 Jun 2026 12:18:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fuse: call fuse_send_readpages explicitly from fuse_readahead
Date: Mon, 29 Jun 2026 14:17:39 +0200
Message-ID: <20260629121750.3392300-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629121750.3392300-1-hch@lst.de>
References: <20260629121750.3392300-1-hch@lst.de>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3779-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[infradead.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,kernel.org,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,lst.de:email,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89FEC6D9F4E

From: Joanne Koong <joannelkoong@gmail.com>

Move the call to fuse_send_readpages from the iomap ->submit_read method
to the fuse readahead implementation.

fuse_read_folio() does not need to call fuse_send_readpages() because it
always does reads synchronously (the iomap->submit_read method for this
was a no-op since data->ia is always NULL for fuse_read_folio()).

This prepares for an iomap fix that will call ->submit_read after each
iomap.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..ceada75310b8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -981,19 +981,8 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 	return ret;
 }
 
-static void fuse_iomap_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
-{
-	struct fuse_fill_read_data *data = ctx->read_ctx;
-
-	if (data->ia)
-		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
-				    data->fc->async_read);
-}
-
 static const struct iomap_read_ops fuse_iomap_read_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range_async,
-	.submit_read = fuse_iomap_submit_read,
 };
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -1116,6 +1105,9 @@ static void fuse_readahead(struct readahead_control *rac)
 		return;
 
 	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
+	if (data.ia)
+		fuse_send_readpages(data.ia, data.file, data.nr_bytes,
+				    fc->async_read);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
-- 
2.53.0


