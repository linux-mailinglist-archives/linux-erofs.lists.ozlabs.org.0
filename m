Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3426FF5E
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Sep 2020 15:59:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtFnk4Bw2zDqv2
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Sep 2020 23:59:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cH3+NyT0; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YGIKWPJO; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtFhy0PZVzDq9k
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 23:55:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ytkKnz8VBXNqJL2t26ngvolOmdh+YZX9OChbdG+k8tw=;
 b=cH3+NyT0D2k15MES2njnuvWGkCTMbaROgmK19WIuT88xt0aEAYtr1XMIQ4ZhY/L8w83nOu
 5YSsgMADoyzY3lXy9lMUKRDBRGSDbP9lZI/acsocXNhJlScXHgRCqRy8DXNS6IV+HyC71L
 T3mFxJWEkhjgfxp683ujJucK934BzrI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ytkKnz8VBXNqJL2t26ngvolOmdh+YZX9OChbdG+k8tw=;
 b=YGIKWPJO7rbd4ZcRtsGdVkYIWck0Tpuz5kfA+jRAIh/DPTN1IDJ2N3cYer4wDeTrH6XJ2K
 eiHewh6uFEPM81X6OFryeCAbAC7YtwiR8xEje+NvjtYjVB/Px7JD8tPjGGk1YCbp/MIesR
 FfABhBfrhfI+g5JprQJLSoOEebLMcVg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-83C4D8OuPgmOvdxcmpYElg-1; Fri, 18 Sep 2020 09:55:22 -0400
X-MC-Unique: 83C4D8OuPgmOvdxcmpYElg-1
Received: by mail-pj1-f70.google.com with SMTP id fs5so3156378pjb.7
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ytkKnz8VBXNqJL2t26ngvolOmdh+YZX9OChbdG+k8tw=;
 b=W/BzjACFyEhpvjQlfqOYteSHDZPTo96MR10l3QNZ0MlHGOvbkOAH0/e0aUCsB3fmKF
 5+IcvN09j6N2CJ7rTplkD8/O75dI+t4jE8PMtoEOmKz52DxTipQasJSfbcDtozQzKq/a
 eCRtnPsvJIYvy59Mw8EovERLnlujSZk9W4EJcZd6ajqtPsLTrD/Hcw/D4Ynab40hKuv5
 Z2XphxAcTaJLNbZ3mKW9lBP3XoTuccJjQw8TxvLs4+RVM7oLBMfb9i4W9oWyGEXsGRSa
 ZUkVR70pHa1G9zb+r54fcSKohsGMC+ghuOtFDRV01640mhm1TW20JrcbLu+U8J0edT+2
 i4hw==
X-Gm-Message-State: AOAM533T7JPv2YQSSEv6Uc5K14dnc8aq+9lqGIltc8xZcXwWfLNnhK/J
 OSpytGOtccOSifsnb1j/r6r/1DLDtobY+wOjncw12gXu4S1Jp0kT/57BPVBrwHrJUD6PZiaYfwB
 wmSeZ1bdoo+Pbfkh9qEVP2tJl
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id
 k22-20020a056a001356b029013ed13da084mr31754321pfu.27.1600437321166; 
 Fri, 18 Sep 2020 06:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGbH+jdpiMZmorFwyMSN8G/zeHh3ycd6m1lP9N9eXAmrX30yk1MiHWjJ8zQi4WsZWau5pZMQ==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id
 k22-20020a056a001356b029013ed13da084mr31754291pfu.27.1600437320844; 
 Fri, 18 Sep 2020 06:55:20 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:55:20 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] erofs: specify accurate nr_iovecs for compressed bios
Date: Fri, 18 Sep 2020 21:54:35 +0800
Message-Id: <20200918135436.17689-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200918135436.17689-1-hsiangkao@redhat.com>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use more accurate compressed page count
instead of BIO_MAX_PAGES unconditionally.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d483e9fee41c..bb20f73f10e0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -135,6 +135,8 @@ struct z_erofs_decompress_frontend {
 	struct z_erofs_collector clt;
 	struct erofs_map_blocks map;
 
+	unsigned int compressedblock_total;
+
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -622,6 +624,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
 				 cache_strategy, pagepool);
+	fe->compressedblock_total += BIT(clt->pcl->clusterbits);
 
 hitted:
 	/*
@@ -1151,7 +1154,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 }
 
 static void z_erofs_submit_queue(struct super_block *sb,
-				 z_erofs_next_pcluster_t owned_head,
+				 struct z_erofs_decompress_frontend *f,
 				 struct list_head *pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg)
@@ -1160,10 +1163,12 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
+	z_erofs_next_pcluster_t owned_head = f->clt.owned_head;
 	/* since bio will be NULL, no need to initialize last_index */
 	pgoff_t last_index;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
+	int cblks = f->compressedblock_total;
 
 	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
@@ -1207,8 +1212,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			}
 
 			if (!bio) {
-				bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
-
+				bio = bio_alloc(GFP_NOIO,
+						min(cblks, BIO_MAX_PAGES));
 				bio->bi_end_io = z_erofs_decompressqueue_endio;
 				bio_set_dev(bio, sb->s_bdev);
 				bio->bi_iter.bi_sector = (sector_t)cur <<
@@ -1221,6 +1226,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 				goto submit_bio_retry;
 
+			--cblks;
 			last_index = cur;
 			bypass = false;
 		} while (++cur < end);
@@ -1234,6 +1240,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	if (bio)
 		submit_bio(bio);
 
+	DBG_BUGON(cblks);
+
 	/*
 	 * although background is preferred, no one is pending for submission.
 	 * don't issue workqueue for decompression but drop it directly instead.
@@ -1246,14 +1254,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
 }
 
 static void z_erofs_runqueue(struct super_block *sb,
-			     struct z_erofs_collector *clt,
+			     struct z_erofs_decompress_frontend *f,
 			     struct list_head *pagepool, bool force_fg)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
-	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+	if (f->clt.owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(sb, clt->owned_head, pagepool, io, &force_fg);
+	z_erofs_submit_queue(sb, f, pagepool, io, &force_fg);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1284,7 +1292,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1343,7 +1351,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, sync);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
-- 
2.18.1

