Return-Path: <linux-erofs+bounces-1518-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B940BCCEC62
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Dec 2025 08:18:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXf5n1DBVz2yFW;
	Fri, 19 Dec 2025 18:18:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766128717;
	cv=none; b=BTJq56O6fC1MpZPT9eBIdN8elDVD+QcgyQT79wAtaUY1B2MA3a+uhlx9Li5swQpiF3sag9iaxjPzOAEkjo+xRRxWmn1y6CDq7k5UDIAHg98Z4IIPrk9HuGpgKkV/2j/pgbOFuiBDKIrtfWVOw/Pzxe5sZp7rSajzuFu7gghHKBTxTP9pXetIKKNa2gXyriqxKO4Qe0kJKT6MI7HkMYJCk/nzaReBMws6L4H/ZuviMSy9CvTFy2ttlWJeVdxtqHau6rFJWgquJUPpZDXP7GjaaBvWdtE/JTi5RHEgPmk6KockkNtiy7D0S29J0itrUXa4PGbU/MrVwYjQnXXqEuA2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766128717; c=relaxed/relaxed;
	bh=UtCVg1Sk3vENqrZPryuqewEpnykLjYm5HB63m+fb6zY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KjoFVE6DbZI2GCA/XPGFNi2aMKTYaZCizIpzifLP9651QI2iIOLPR7EVJ4Mog7TzE3/x+ILu2b2w57OGn6sElIQsxZJqE2N6J3EXAZCBz/kDMm4B44ELn2lWKTfsiG2LuW4CiYD46bAAC+3muVca7Nr2tgrGRuL7JEKGAeUd4hec29T4LR9FY1KMlPy2Irj4fv/FJz7TgeKH/FK/U2ltc1okziwQml1TaCIyoCiv2snEgAxHdtgqJ0H/UAz4mybaeBR0vVF297y3UfLvzxRwejI03vG5ZXi2806p5IINVnuZik0s3PD9z0M2ri3Y+snpCoA94N4WrdBGmoJJfCZ0fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=jCcjDrt7; dkim-atps=neutral; spf=pass (client-ip=203.254.224.25; helo=mailout2.samsung.com; envelope-from=junbeom.yeom@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=jCcjDrt7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=203.254.224.25; helo=mailout2.samsung.com; envelope-from=junbeom.yeom@samsung.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 394 seconds by postgrey-1.37 at boromir; Fri, 19 Dec 2025 18:18:34 AEDT
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXf5k3mYrz2xqG
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 18:18:32 +1100 (AEDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251219071141epoutp02a2cc42e5459d67bbdab936d7b9fd3d42~CjFVM2iUu3218432184epoutp02G
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 07:11:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251219071141epoutp02a2cc42e5459d67bbdab936d7b9fd3d42~CjFVM2iUu3218432184epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766128301;
	bh=UtCVg1Sk3vENqrZPryuqewEpnykLjYm5HB63m+fb6zY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jCcjDrt7LeelML8xluF1a7BnBpUHZct1KO8CF4+POIZRnPfVb69F7HQ/+U5HcQwJl
	 EjNm1xF4jrg8f2h87FiqUW/ISXHYi4CWr0hDxTGfgUx4KXgz/v/VXjW/lPlTmlhI/I
	 pjfqLBp5q35hruOMtZt1bsp20NeBEtT9kCplpfhI=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20251219071141epcas1p3a4d92a2bfce352ef539b8ab5c12826b5~CjFU7xSXb0562705627epcas1p3n;
	Fri, 19 Dec 2025 07:11:41 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.118]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dXdxn2dP0z6B9mK; Fri, 19 Dec
	2025 07:11:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251219071140epcas1p35856372483a973806c5445fa3d2d260b~CjFT-2bdf0562705627epcas1p3k;
	Fri, 19 Dec 2025 07:11:40 +0000 (GMT)
Received: from junbeom.yeom (unknown [10.253.99.78]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251219071140epsmtip2d11eadd7ab78bdd4184cd1da2ac5eae8~CjFT9W_Dm2747727477epsmtip2L;
	Fri, 19 Dec 2025 07:11:40 +0000 (GMT)
From: Junbeom Yeom <junbeom.yeom@samsung.com>
To: xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Junbeom Yeom
	<junbeom.yeom@samsung.com>, stable@vger.kernel.org, Jaewook Kim
	<jw5454.kim@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] erofs: fix unexpected EIO under memory pressure
Date: Fri, 19 Dec 2025 16:10:34 +0900
Message-Id: <20251219071034.2399153-1-junbeom.yeom@samsung.com>
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
X-CMS-MailID: 20251219071140epcas1p35856372483a973806c5445fa3d2d260b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251219071140epcas1p35856372483a973806c5445fa3d2d260b
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
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
 fs/erofs/zdata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 27b1f44d10ce..86bf6e087d34 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1414,11 +1414,15 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	};
 	struct z_erofs_pcluster *next;
 	int err = io->eio ? -EIO : 0;
+	int io_err = err;
 
 	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
+		int propagate_err;
+
 		DBG_BUGON(!be.pcl);
 		next = READ_ONCE(be.pcl->next);
-		err = z_erofs_decompress_pcluster(&be, err) ?: err;
+		propagate_err = READ_ONCE(be.pcl->besteffort) ? io_err : err;
+		err = z_erofs_decompress_pcluster(&be, propagate_err) ?: err;
 	}
 	return err;
 }
-- 
2.34.1


