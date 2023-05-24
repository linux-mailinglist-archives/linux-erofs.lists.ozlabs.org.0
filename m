Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674170EDAB
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 08:12:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QR17W2b4Cz3fHT
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 16:12:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=oW6UQkDp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=oW6UQkDp;
	dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QR17G1klLz3fH7
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 16:12:25 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae4e49727eso5994695ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684908742; x=1687500742;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOVKLuGqVN69XgbPeaETaxXfZXKBDKqsHEKUgXSsZg8=;
        b=oW6UQkDp7sDQt+D9l37f5agGwNIoBn05xl8aBcROKDTTkbeupLIOOhkXsaqe5bCppM
         IOC6TqZWsR8IYm/lTX8R1Rl8F3QgDLXHS/wQZP/z6+2QpBZyGNWSIFJyv2UkH71+Kq0b
         6X+CfhQ1RdhAIPUT4uXvA47gDP8czM76Q2UruSHZRDVoDcn5qpBFBERjBT3Qc5+HLfzU
         TyxMhWf4DNUW5OnadUI0QGrnCYyVAd1OgjF2BUmugeY4G5uDmYRzVDBI6BsKb+P/jemw
         vcSxDntVQP96ourPZXH24F4tvA+NNG3Cte7ZVOe4rhtrv3hiYxC9B7L1h2E0Ly9ol3vL
         aT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684908742; x=1687500742;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOVKLuGqVN69XgbPeaETaxXfZXKBDKqsHEKUgXSsZg8=;
        b=NGUjfMtqOcsOSip14hwLw8veLWZ8hG7wz20+/tfvkbm6ZUKRRs5N3DvP6MAnWfLLC+
         pswu8ZJHqTBlGIsm0Ko4HtiC7lGd75d0ormb6v+9mtcqPOe1qY4PA8itdsc5hTDxxFae
         HoHXxOe65uchsMvNXhbGb/kYSiGw/OGZnETrJ8yaGKQ8M/0PTXO/suar0ca6jkGpiX7y
         W+CM/zYk27ufDpjXZdNuvhM9NhP8b3wXCmxnlNcW5921xFozjeQslEnOrQZ0vZ9uMyx1
         hQWkSpdmDudH8LwM/+KodmzDnw9QWRUL1gxxCjPu5T3ZyJeeh6C3eAPAnZLdNGhvmRfr
         +l4g==
X-Gm-Message-State: AC+VfDxQJK5oo2DDzdoZbqN0W1TA4IGa4mJkZyEq9BkiNQNPoT5amX5w
	ORki8aMJuX2xfdw2FQRbHkI=
X-Google-Smtp-Source: ACHHUZ45NNZvSMLWmEYRleXqZUCQ87n55rxUV0oABz4atHoPuFDfB+ExOHK1PaB5qJD/ISht+WdnaA==
X-Received: by 2002:a17:902:d50e:b0:1aa:dd14:da98 with SMTP id b14-20020a170902d50e00b001aadd14da98mr18352516plg.50.1684908742277;
        Tue, 23 May 2023 23:12:22 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001a9873495f2sm7772980plb.233.2023.05.23.23.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:12:21 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove the member readahead from struct z_erofs_decompress_frontend
Date: Wed, 24 May 2023 14:11:52 +0800
Message-Id: <20230524061152.30155-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The struct member is only used to add REQ_RAHEAD during I/O submission.
So it is cleaner to pass it as a parameter than keep it in the struct.

Also, rename function z_erofs_get_sync_decompress_policy() to
z_erofs_is_sync_decompress() for better clarity and conciseness.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..4522a3be2ce9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -550,7 +550,6 @@ struct z_erofs_decompress_frontend {
 	z_erofs_next_pcluster_t owned_head;
 	enum z_erofs_pclustermode mode;
 
-	bool readahead;
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -1106,7 +1105,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	return err;
 }
 
-static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
+static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 				       unsigned int readahead_pages)
 {
 	/* auto: enable for read_folio, disable for readahead */
@@ -1672,7 +1671,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				 struct page **pagepool,
 				 struct z_erofs_decompressqueue *fgq,
-				 bool *force_fg)
+				 bool *force_fg, bool readahead)
 {
 	struct super_block *sb = f->inode->i_sb;
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
@@ -1763,7 +1762,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					(sb->s_blocksize_bits - 9);
 				bio->bi_private = q[JQ_SUBMIT];
-				if (f->readahead)
+				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
@@ -1799,13 +1798,14 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     struct page **pagepool, bool force_fg)
+			     struct page **pagepool, bool force_fg,
+			     bool readahead)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, pagepool, io, &force_fg);
+	z_erofs_submit_queue(f, pagepool, io, &force_fg, readahead);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1903,8 +1903,8 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, 0));
+	z_erofs_runqueue(&f, &pagepool, z_erofs_is_sync_decompress(sbi, 0),
+			 false);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1922,7 +1922,6 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
 
-	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
@@ -1953,7 +1952,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
+			 z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&pagepool);
 }
-- 
2.17.1

