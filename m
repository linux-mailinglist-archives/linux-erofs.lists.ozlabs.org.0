Return-Path: <linux-erofs+bounces-567-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D559AFDE8D
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 05:46:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcP6G4XwKz2yhX;
	Wed,  9 Jul 2025 13:46:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752032790;
	cv=none; b=ih2G36GiWWOmJMdbrpiNco1NFqFnFmaPKwdkXnAdlD5CV1BlRyGRSBAf3ubhhmYx0kFjW9h+zUQNSjvtF81Uo4g9RxJt2PniuEBkFag20lrY7xQDoapLAUlZdTdOfvaRvaUbvLNzE9maxXm1LbfzlhCt2vqwBVBEbHAVD9/DBRRT888xJgo6GHQNy2Zq10zLL5wiKN4hufdf21NDA/nQI5mAshenP4ds1sUlzJ2XK1rCbzlFTUoBzkZCV9/WqEXp22e/fX6WcuVb4iQNkTrdChztZMAZVPxhAxIwuyJBt9zEpvMpzrVq1tGq7vyUFwGFa4fb5OQ/Y2oARX3n0+bKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752032790; c=relaxed/relaxed;
	bh=f3GpZHDuE3N1k7COKmMSW+fvkGwAnlSYuCB8czZV42Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQceELVzFusO40cGFLtGe6fYm0JHQubhWzHiJ7zVDAF8VZgEeclpV4QUILvBgP5+NrYaxR0EMnD6WMM58Iv15RFyfwhPWLtr+TqAdKaut+rbCeGU9/EddWZ2SUEafoKhPgczGf4bIaV3RwrbWdWorFQ6PsEm3wQqBCNTMrLGpBbfqiDIWyuqrk4C9zdsftg7D3vLC1LNKxz4y/CtS2zJt0MNTkJVLHGW1SKaHJFzoYapwiHIHlR+1bJvccNNa+1OKQ7Fk0LFGXXxWayaN6A6BUbXjPPmn3lyisnZ94wIpMLEvyYDxtOtrVGcy+ou5MBGAzoEZggNn5+j8Q0x5uPj3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C2IL3HIm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C2IL3HIm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcP6D4Rv3z2xCW
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 13:46:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752032782; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f3GpZHDuE3N1k7COKmMSW+fvkGwAnlSYuCB8czZV42Y=;
	b=C2IL3HImHvWZGV56Lxjg6FM1zqKLPjXlpvxeYkByjdq23t0AhBFiAjkYRRLY3RGcAFMTCAS5KWq2GTxVBO1ZrKHEASHN2eUO3yvPcZvIhaLymNJhkdRuFrOgj+9yn+CvuoZUq2vq5q5lkY4binPI6Ae3+C4q6hgyAWAo97NrUI4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiW0kHI_1752032775 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 11:46:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: use memcpy_to_folio() to replace copy_to_iter()
Date: Wed,  9 Jul 2025 11:46:13 +0800
Message-ID: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
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

Using copy_to_iter() here is overkill and even messy.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index df5cc63f2c01..fe2cd2982b4b 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -96,8 +96,6 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 	struct erofs_map_blocks *map = &io->map;
 	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
 	loff_t pos = folio_pos(folio), ofs;
-	struct iov_iter iter;
-	struct bio_vec bv;
 	int err = 0;
 
 	erofs_onlinefolio_init(folio);
@@ -122,13 +120,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				err = PTR_ERR(src);
 				break;
 			}
-			bvec_set_folio(&bv, folio, len, cur);
-			iov_iter_bvec(&iter, ITER_DEST, &bv, 1, len);
-			if (copy_to_iter(src, len, &iter) != len) {
-				erofs_put_metabuf(&buf);
-				err = -EIO;
-				break;
-			}
+			memcpy_to_folio(folio, cur, src, len);
 			erofs_put_metabuf(&buf);
 		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, cur + len);
-- 
2.43.5


