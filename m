Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84E70EE3B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 08:40:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QR1lF1zkbz3f4w
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 16:40:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Blwwm5Mx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Blwwm5Mx;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QR1l94Gh3z3c9V
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 16:40:05 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2553f2706bfso649716a91.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910402; x=1687502402;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn7OMSsYSCX/rc9bjAKI2reLL+5RLLeTJ6anC4INbJ0=;
        b=Blwwm5MxBGo/l24/gdA8zXS9W/9IYhXx34COU9v3rz8YFOVDy2GHAXNVZcNMzpSnIK
         Mv272aeEWdy1CQnzZq5279bTNcxPbDD7p4vzgxuS8yectKxfFvkGhGTT3kSTG8IrLjrK
         4fsl2Nzo070iVYcV/5Mjga7zFtuVO9F+nI9bHPFoCKststHCwHycrcjphZm2Tw4zXSaT
         vYHPlJ1Ab77O6sRhciRy7X6TBmixbxj5TKEpdil8L4LfgdslllMPXhM/iU4v/iBOqjeg
         28Jz3qeU354e8vdzhp4k8zq80LVv8t1O8XqMTMV1XfVGlx5wquzllD824PHLsBKYYxa8
         2YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910402; x=1687502402;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zn7OMSsYSCX/rc9bjAKI2reLL+5RLLeTJ6anC4INbJ0=;
        b=L0v2oXvNBhpwdq4yKtLGEygKOu9eDLKmOFyZmF77cuovi6yI0Mi/XNjV3QpgBgMPzN
         mR5m1LcQqvpmGyt+Ul0Nrc264OEL1jRxxOEe8LhnC3QnKAz3HsAu26tZzt2BsWIC7Qdq
         xlpW7kuKR42Kusd5OGWdEjs+wRR6xJ6kmeOo/VvhBcWf7Nx+G8Te80U7bKgTIEV84Bm6
         E4UPi0viJVir8Q6wOrq4UuwrNuss87LnoFsZ65A4n9+bm7F1/gkeiMgpZHY/SN2gdY1n
         O0WHXtRit0RvoqYIeQt9ysxzcAYWmMgtvGrVSFk139Rz6eV8A5Vz6hRW2Ql8g2dnR631
         LD9w==
X-Gm-Message-State: AC+VfDzr2vZd3AS4Gke6hgtiR9pO2axsewkT4j1V4X8odLz5oxEu6XRq
	iZVoRXHwBpfPOCe1bSBupJ4=
X-Google-Smtp-Source: ACHHUZ54QbswgzWqbpMWpc5kcmKJu0sCpoDIcGaCEWvL6mfDinJ4GzW4yBfgfVCjieyPrS/gupcpTA==
X-Received: by 2002:a17:90a:1b2b:b0:24e:2759:8dbe with SMTP id q40-20020a17090a1b2b00b0024e27598dbemr18040657pjq.7.1684910402282;
        Tue, 23 May 2023 23:40:02 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 4-20020a630904000000b00534514bc08bsm6947515pgj.64.2023.05.23.23.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:40:01 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: remove the member readahead from struct z_erofs_decompress_frontend
Date: Wed, 24 May 2023 14:39:44 +0800
Message-Id: <20230524063944.1655-1-zbestahu@gmail.com>
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
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: readahead -> ra in z_erofs_runqueue()

 fs/erofs/zdata.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..5cd971bcf95e 100644
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
@@ -1799,13 +1798,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     struct page **pagepool, bool force_fg)
+			     struct page **pagepool, bool force_fg, bool ra)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, pagepool, io, &force_fg);
+	z_erofs_submit_queue(f, pagepool, io, &force_fg, ra);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1903,8 +1902,8 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, 0));
+	z_erofs_runqueue(&f, &pagepool, z_erofs_is_sync_decompress(sbi, 0),
+			 false);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1922,7 +1921,6 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
 
-	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
@@ -1953,7 +1951,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
+			 z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&pagepool);
 }
-- 
2.17.1

