Return-Path: <linux-erofs+bounces-1522-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC6CCFD4A
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Dec 2025 13:41:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXnFl2GzGz2yFW;
	Fri, 19 Dec 2025 23:40:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766148059;
	cv=none; b=TDm2tD/BjjBKO8AaBedSv53hODloHEJd6Go1caqBqN1nvppif5NrwlksEZE4iXrDHjOHVsY5AWVs/w3+VFAMrdP+qsGPPVo0wMUlN68m+i0LzFtPSB30s+yNAqgRYZYKU7IA1g6to+XRYd/syUYt7Bm6KWhQtVvM9S8+jbpuy7hvScF8JEL5o2OyTgDKTI9Ob8Wo5uNPQHYI0txgqwGyipCT4nWeCp/GJv7YyH02TG7Earyyr8N/oYfMKUQiuZYAO4COQEtXufzcpGBDbrKy0rQftj8ZK8jBIhQ+zCUTpTxJmsG7+o8d3HK6RPTgthzBGNgtKejbUBZZOHZzCclhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766148059; c=relaxed/relaxed;
	bh=jMDcKQ9i6N+1e+bXvO2dHhPmBoF8oPQlpRZ6OtKYHpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=b21hF96AFytxFQIsQXtChRLrAFPii/jyCOSPiVANH3Dem0wJUtMFzECA6yojCszKiswD3+1DjTGad4EU7JfRbeOW2PiieUaCImjG4s+NBZyTvv2iJu6+r8m+JlDnZVxrwMX0LHaMrgANuwEFQ/gtmtZBUmopT4Ix3edYEBvQqLEWguGR+MDfeSSIdwI9RQ9pFR8QErYoxa5wMuBMhOKa0eBfE9KrYeMA/J2hc8Qv0g+1D01B97Xoj5DvTEX3YMWJ8SOw1MQm2zdNnUrvl/pC+sfsE/4dYN6fa1sRkajoCEjrF7dSXWyzuYNC0yGKiVERsZ6aPReG0rfDPTiLgXufkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=uP1LZs4W; dkim-atps=neutral; spf=pass (client-ip=203.254.224.25; helo=mailout2.samsung.com; envelope-from=junbeom.yeom@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=uP1LZs4W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=203.254.224.25; helo=mailout2.samsung.com; envelope-from=junbeom.yeom@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXnFh5J9Yz2xfK
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 23:40:55 +1100 (AEDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251219124045epoutp02be5069f04d00701abde73a7c3aff6014~Cnko2PNG00121701217epoutp02q
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 12:40:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251219124045epoutp02be5069f04d00701abde73a7c3aff6014~Cnko2PNG00121701217epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766148045;
	bh=jMDcKQ9i6N+1e+bXvO2dHhPmBoF8oPQlpRZ6OtKYHpE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uP1LZs4WnnbhlA8C+a3q3yqbvuNDWe3HBAxjgxZsLCatucoI8EkJLVQy8pVf3Y0ww
	 9LfIiGnqk7WjPuKmA3akBWiLbCgbd065UR3s1g7uVxO/bx6MuVv/e6G5ctwWhR42eV
	 mS1o9hpyuoVtCY1FhxY2B/njbDyo02Ism3v3Ch44=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20251219124044epcas1p476be6abc6c9af383dbc8890a9d13b57e~CnkoYAh-I0384603846epcas1p4q;
	Fri, 19 Dec 2025 12:40:44 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.115]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dXnFS5DRVz3hhT7; Fri, 19 Dec
	2025 12:40:44 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d~Cnknu9BCT2398323983epcas1p3R;
	Fri, 19 Dec 2025 12:40:44 +0000 (GMT)
Received: from junbeom.yeom (unknown [10.253.99.78]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251219124044epsmtip13b608729c8bb9b8f4cdab1cef393a8b7~CnknsFj5O2626826268epsmtip14;
	Fri, 19 Dec 2025 12:40:44 +0000 (GMT)
From: Junbeom Yeom <junbeom.yeom@samsung.com>
To: xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Junbeom Yeom
	<junbeom.yeom@samsung.com>, stable@vger.kernel.org, Jaewook Kim
	<jw5454.kim@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH v2] erofs: fix unexpected EIO under memory pressure
Date: Fri, 19 Dec 2025 21:40:31 +0900
Message-Id: <20251219124031.2731710-1-junbeom.yeom@samsung.com>
X-Mailer: git-send-email 2.34.1
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
X-CMS-MailID: 20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d
References: <CGME20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d@epcas1p3.samsung.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

erofs readahead could fail with ENOMEM under the memory pressure because
it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
for a regular read. And if readahead fails (with non-uptodate folios),
the original request will then fall back to synchronous read, and
`.read_folio()` should return appropriate errnos.

However, in scenarios where readahead and read operations compete,
read operation could return an unintended EIO because of an incorrect
error propagation.

To resolve this, this patch modifies the behavior so that, when the
PCL is for read(which means pcl.besteffort is true), it attempts actual
decompression instead of propagating the privios error except initial EIO.

- Page size: 4K
- The original size of FileA: 16K
- Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
[page0, page1] [page2, page3]
[PCL0]---------[PCL1]

- functions declaration:
  . pread(fd, buf, count, offset)
  . readahead(fd, offset, count)
- Thread A tries to read the last 4K
- Thread B tries to do readahead 8K from 4K
- RA, besteffort == false
- R, besteffort == true

        <process A>                   <process B>

pread(FileA, buf, 4K, 12K)
  do readahead(page3) // failed with ENOMEM
  wait_lock(page3)
    if (!uptodate(page3))
      goto do_read
                               readahead(FileA, 4K, 8K)
                               // Here create PCL-chain like below:
                               // [null, page1] [page2, null]
                               //   [PCL0:RA]-----[PCL1:RA]
...
  do read(page3)        // found [PCL1:RA] and add page3 into it,
                        // and then, change PCL1 from RA to R
...
                               // Now, PCL-chain is as below:
                               // [null, page1] [page2, page3]
                               //   [PCL0:RA]-----[PCL1:R]

                                 // try to decompress PCL-chain...
                                 z_erofs_decompress_queue
                                   err = 0;

                                   // failed with ENOMEM, so page 1
                                   // only for RA will not be uptodated.
                                   // it's okay.
                                   err = decompress([PCL0:RA], err)

                                   // However, ENOMEM propagated to next
                                   // PCL, even though PCL is not only
                                   // for RA but also for R. As a result,
                                   // it just failed with ENOMEM without
                                   // trying any decompression, so page2
                                   // and page3 will not be uptodated.
                ** BUG HERE ** --> err = decompress([PCL1:R], err)

                                   return err as ENOMEM
...
    wait_lock(page3)
      if (!uptodate(page3))
        return EIO      <-- Return an unexpected EIO!
...

Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
Cc: stable@vger.kernel.org
Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
---
v2:
 - If disk I/Os are successful, handle to decompress each pcluster.

 fs/erofs/zdata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 27b1f44d10ce..70e1597dec8a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1262,7 +1262,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 	return err;
 }
 
-static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
@@ -1270,7 +1270,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	const struct z_erofs_decompressor *alg =
 				z_erofs_decomp[pcl->algorithmformat];
 	bool try_free = true;
-	int i, j, jtop, err2;
+	int i, j, jtop, err2, err = eio ? -EIO : 0;
 	struct page *page;
 	bool overlapped;
 	const char *reason;
@@ -1413,12 +1413,12 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		.pcl = io->head,
 	};
 	struct z_erofs_pcluster *next;
-	int err = io->eio ? -EIO : 0;
+	int err = 0;
 
 	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
 		DBG_BUGON(!be.pcl);
 		next = READ_ONCE(be.pcl->next);
-		err = z_erofs_decompress_pcluster(&be, err) ?: err;
+		err = z_erofs_decompress_pcluster(&be, io->eio) ?: err;
 	}
 	return err;
 }
-- 
2.34.1


