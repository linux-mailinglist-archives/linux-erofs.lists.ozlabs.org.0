Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3126FF5F
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Sep 2020 15:59:50 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtFnw3DCqzDqth
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Sep 2020 23:59:48 +1000 (AEST)
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
 header.s=mimecast20190719 header.b=Kr1zAw0W; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/jjOBaZ; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtFj51DgTzDqD7
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 23:55:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=9E4MFof7nUo0/wMiUkKWQUNotogwZFFdR4mKeWQqr64=;
 b=Kr1zAw0WfKoRUpuHGtUag26fkmlhe4zkSp+0aap0G15zCzKyrqXAwWbnJursG1/Ni5QrRY
 nKtHYr3kDEDOYWWHRPOroHlaJlrGq7iz9KcjQl6tInKhIKDkegnj3red5ihWIDphXOKe0n
 rYO+KlBuiP/TzOAlLNFQOSLXNrontYI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=9E4MFof7nUo0/wMiUkKWQUNotogwZFFdR4mKeWQqr64=;
 b=f/jjOBaZIE7jduT2NrHxY5hST6WVQog6BhhUcQTJfM6CaN9hfvxywOusy9wVsa2iZOEwc7
 MZGsOKLOEnez0MTroMJ1oBpfyeIiDWv9axVaGJGH9heGN+jA0oY4ZeEJ/lBC45+eyMUNtS
 YQnsOT78ONA2vFwWFKzEXlpmCP02WYg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-wRaE908UMXiWfgEwoGrlLg-1; Fri, 18 Sep 2020 09:55:27 -0400
X-MC-Unique: wRaE908UMXiWfgEwoGrlLg-1
Received: by mail-pj1-f69.google.com with SMTP id a8so3161781pjk.5
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 06:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9E4MFof7nUo0/wMiUkKWQUNotogwZFFdR4mKeWQqr64=;
 b=GzGemoQUa64CCjKr1TxlTCRXLPHFlXRlG03j38RY+Xyh6uf1Xhrnv2CZXLihLAo6o0
 KnYSAH9vLCsM4c8fRRWUaZPX0MOUiPrUJnHB61C5AQFrBl76GwmPh6xAnoLKwo/WNmX9
 Dd71187/VpOb4EjukHA/bBPfaenBIa5lRmaY2Sz6Qe4L9p8bIH0PHfP2X/u0fwXPzOTB
 WzjfK/CRio4VN1vU5+737LykrlITIS8Mh2GBSFm5DXZy7DtQaOat+COUI5ppS2H0q9f1
 uizthHS0Y4Hg28UxYubmPFrjSpZpxBDk6OWm0U2ZSI7L0U1u/+wUXCq+RgylXdlIJv46
 +rTg==
X-Gm-Message-State: AOAM5314K65t0wZ3xiBKaofYKasiQ+0DJ19ExnNBESnkUZV7AyDIzgan
 Mi0rQ8TpFnXVVn9jJNUy3kQysQClWv6PfTrE5kZAIXjri6E/MB1g1BFfJth5AfbwDZQfcY8NBQi
 coZbGXiHdmHpTrGlr1D4fFC1G
X-Received: by 2002:a17:902:b7c8:b029:d0:cbe1:e7b2 with SMTP id
 v8-20020a170902b7c8b02900d0cbe1e7b2mr33465974plz.35.1600437325771; 
 Fri, 18 Sep 2020 06:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUrSr6Izh1DQEjayoRt2kONSYDRKoE2mHgL/SDltaFgDhXhbjERmcBZq8/FbtrYG6WbwnCPQ==
X-Received: by 2002:a17:902:b7c8:b029:d0:cbe1:e7b2 with SMTP id
 v8-20020a170902b7c8b02900d0cbe1e7b2mr33465962plz.35.1600437325518; 
 Fri, 18 Sep 2020 06:55:25 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:55:25 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] erofs: add REQ_RAHEAD flag to readahead requests
Date: Fri, 18 Sep 2020 21:54:36 +0800
Message-Id: <20200918135436.17689-4-hsiangkao@redhat.com>
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

Let's add REQ_RAHEAD flag so it'd be easier to identify
readahead I/O requests in blktrace.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/data.c  | 2 +-
 fs/erofs/zdata.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index bb20f73f10e0..23940edf16ce 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -136,6 +136,7 @@ struct z_erofs_decompress_frontend {
 	struct erofs_map_blocks map;
 
 	unsigned int compressedblock_total;
+	bool readahead;
 
 	/* used for applying cache strategy on the fly */
 	bool backmost;
@@ -1220,6 +1221,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 					LOG_SECTORS_PER_BLOCK;
 				bio->bi_private = bi_private;
 				bio->bi_opf = REQ_OP_READ;
+				if (f->readahead)
+					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
 
@@ -1318,6 +1321,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
+	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	while ((page = readahead_page(rac))) {
-- 
2.18.1

