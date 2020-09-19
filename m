Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D490E270B70
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 09:28:45 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Btj4C0wZdzDqtr
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 17:28:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HyIkM/XN; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9yiLhbU; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Btj3y3vfFzDqty
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 17:28:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600500507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=s5QBdWf0Be/EzSaYQm1AD046Zbo4g6mUJcMIOSDZ87c=;
 b=HyIkM/XNIxF8oQ+vfWcZGTvMH5/vErf4q2RNkWEiP3dt9b8OZE7+5eSlarEEmSPQ63/otB
 Kn5nXy5hN98Qe/EksV+8PeYRIwK3DtQpQjS40xy5LKbgtW43XzvfznvYhejx0gd0SW8gho
 isfdSGxft8XCT1qTJhXVW+UNIKmSIWo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600500508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=s5QBdWf0Be/EzSaYQm1AD046Zbo4g6mUJcMIOSDZ87c=;
 b=W9yiLhbUbfJQJqK29fWlHJC5W0ilfkDUExoC0/tpl0jlsjKloAIXfcoM0a4K3VgubIlu8r
 Ny+55eyp39uW0wrZCK+I+MRWEIrjeHvo+N8ddj+ug5JBDLZoSQHpmZACoOIz5axGqbIfxH
 D8KJvIru/swTki2H74Om0tPrU3HYGDk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-uO-4o40RNCS2gY8r_5p1lg-1; Sat, 19 Sep 2020 03:28:26 -0400
X-MC-Unique: uO-4o40RNCS2gY8r_5p1lg-1
Received: by mail-pf1-f200.google.com with SMTP id q16so5060814pfj.7
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 00:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s5QBdWf0Be/EzSaYQm1AD046Zbo4g6mUJcMIOSDZ87c=;
 b=tY2oZnCwELn4rpMObWQch5C0to7ngqmmOXxfoddUnvphcHbTnDGR6NamwBBs0/7LQM
 XHlHjJ92J30ta6Q60NYbukwb4T/Q7ZoZ3Y6M1XWwlATNvwh4ZHHUImOH61YTLorit3A5
 LQWRe6JjHTw5a7Wi9Zt3mPdQh4l0SVXTtme1R6pr2ju+5AY2Ot1FcEa/jhYCu5vUfB2L
 55Fpzf4d0aMCKirtMaQHABu0W7FsFv+aMrzz+8Ru8W/f/E/MNxieUO5MUY+cksszsbq5
 wB0EU0Y4EhYxKmT2K0njC7dPwnoulRtcxDdx4O/Ty6/iun5OPruEV5BnaHMEreQUC3/U
 Iy8A==
X-Gm-Message-State: AOAM533JysZUmpa8mhiEyxirQdTmACAkLJYwn8tUk7mwmX0LvS+K+4dg
 XfmsSnnXnQx6UogXwNmd+deDAlW72hB9PnfHPwAeBVI6Ewg8k66MPIep+w1yNPqwKQvC0KyFKQu
 5SnyO0Iik2RDYs8tDj22CrY8h
X-Received: by 2002:a17:902:b586:b029:d1:bb0f:2644 with SMTP id
 a6-20020a170902b586b02900d1bb0f2644mr32502958pls.34.1600500504785; 
 Sat, 19 Sep 2020 00:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZYnm3xckGHKZChvOgswDfMVTG0fk8MOC46B/+w0qe2CXhzMvyQVAnykW4gqBnbQZw+2FQCQ==
X-Received: by 2002:a17:902:b586:b029:d1:bb0f:2644 with SMTP id
 a6-20020a170902b586b02900d1bb0f2644mr32502940pls.34.1600500504523; 
 Sat, 19 Sep 2020 00:28:24 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s3sm5407381pfe.116.2020.09.19.00.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 00:28:24 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/3] erofs: add REQ_RAHEAD flag to readahead requests
Date: Sat, 19 Sep 2020 15:27:30 +0800
Message-Id: <20200919072730.24989-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200919072730.24989-1-hsiangkao@redhat.com>
References: <20200919072730.24989-1-hsiangkao@redhat.com>
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

Let's add REQ_RAHEAD flag so it'd be easier to identify
readahead I/O requests in blktrace.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
change since v1:
 since "erofs: add REQ_RAHEAD flag to readahead requests" is dropped,
 lifting up related code to this patch and rebase for now.

 fs/erofs/data.c  |  2 +-
 fs/erofs/zdata.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 459ecb42cbd3..347be146884c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -224,7 +224,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		bio_set_dev(bio, sb->s_bdev);
 		bio->bi_iter.bi_sector = (sector_t)blknr <<
 			LOG_SECTORS_PER_BLOCK;
-		bio->bi_opf = REQ_OP_READ;
+		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bee6ce783c64..50912a5420b4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -135,6 +135,7 @@ struct z_erofs_decompress_frontend {
 	struct z_erofs_collector clt;
 	struct erofs_map_blocks map;
 
+	bool readahead;
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -1148,7 +1149,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 }
 
 static void z_erofs_submit_queue(struct super_block *sb,
-				 z_erofs_next_pcluster_t owned_head,
+				 struct z_erofs_decompress_frontend *f,
 				 struct list_head *pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg)
@@ -1157,6 +1158,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
+	z_erofs_next_pcluster_t owned_head = f->clt.owned_head;
 	/* since bio will be NULL, no need to initialize last_index */
 	pgoff_t last_index;
 	unsigned int nr_bios = 0;
@@ -1212,6 +1214,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 					LOG_SECTORS_PER_BLOCK;
 				bio->bi_private = bi_private;
 				bio->bi_opf = REQ_OP_READ;
+				if (f->readahead)
+					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
 
@@ -1243,14 +1247,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
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
@@ -1281,7 +1285,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1307,6 +1311,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
+	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	while ((page = readahead_page(rac))) {
@@ -1340,7 +1345,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, sync);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
-- 
2.18.1

