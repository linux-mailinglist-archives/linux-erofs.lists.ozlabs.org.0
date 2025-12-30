Return-Path: <linux-erofs+bounces-1647-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505ECE8904
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 03:31:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgHC15XVsz2yDk;
	Tue, 30 Dec 2025 13:31:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767061869;
	cv=none; b=D4e51zIDTIpBh4ypOA9iQs8fIwGB/1QIhFDL7owSqwWXRZQzo2dph4f2XYubgrVivz6By6K0O2Os5S7mKM9AlWFPTdY91GWaHAjahj9ySx5LDLdEhydoGwsRZ33YFks5GWHdc+6CL86tooqZNl/qNpj4k5FmTqZz+0S9X80HFhgF7leOIgZKLYLZXTV8InSBrTpGEIT/rvRnCNLPtDO0jo6S1Tmm+wpuLzTUUop0Tv9PkTIcP5/k5KcekLecgIqbZrocHM/CiHlaNTbL8SDBnvE/xT8ux9ITsqvV1I7WOF4nfLI01PLXmVrTDKrLYjVczrYCmGgo3lCNfYfMyfkuag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767061869; c=relaxed/relaxed;
	bh=jffYoQ/hbMXywNMgqFPKngokhp/eErJsRHR1Kywn7AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQRgK2yoG+/nRPj1q8pQtERPdlbJZ+7dpMaPp0MzmqvOgxvMsFH0dWdlKy8D5G0ivStNjQVUtaoqXQKSKEH6bw5UmWxQtTPrEo6WeoSVBOOkTDsmLf/9cooqqSSfcSrvx5wAUStrHBMEt+0JoL2c9MXPA1RrOkX7vhD243GfMJqYQ8ZwronKbzqEQZEuJnNyjKWCZFiL3a2KRXybzQdDPG8XiMwLUX1R/EGp9R/Xu+qW/JkD83f5HxuKn2tnrVCJgWhCbforl/Zpk9NJdInnKxB5k9Ka5s8b5Ods+g40DFpfWxzx2s4xOGF3beNRDXKL5zHy7wMu5aB63p/1RkfEGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p9+O6yrX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p9+O6yrX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgHBz1zjRz2yD4
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 13:31:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767061860; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jffYoQ/hbMXywNMgqFPKngokhp/eErJsRHR1Kywn7AA=;
	b=p9+O6yrXPZq9sa6THG6u/vSx3goA9mcwP5gYyFcHYT3AgwN5az3MkZbq0DqbpGQ85ZXP9pbeGlYDJsMtQUfQMq+tuCAnOw0iPKzIj2SbQmut9xeznSMBhAXvf7QtdDPkuEGJWBA6ywiA0Au4Q5/B/S5m4tvArn8n53H+nkBJbMU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvyTNWw_1767061854 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 10:30:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Sasha Levin <sashal@kernel.org>
Cc: linux-erofs@lists.ozlabs.org,
	Junbeom Yeom <junbeom.yeom@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.18.y v2] erofs: fix unexpected EIO under memory pressure
Date: Tue, 30 Dec 2025 10:30:53 +0800
Message-ID: <20251230023053.3682970-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229185432.1616355-2-sashal@kernel.org>
References: <20251229185432.1616355-2-sashal@kernel.org>
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

From: Junbeom Yeom <junbeom.yeom@samsung.com>

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
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Greg and Sasha,

Let's just merge this directly.
No need to backport commit 831faabed812 ("erofs: improve decompression error reporting")
for now.

Thanks,
Gao Xiang

 fs/erofs/zdata.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc80cfe482f7..683703aee5ef 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1262,17 +1262,17 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 	return err;
 }
 
-static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decomp =
 				z_erofs_decomp[pcl->algorithmformat];
-	int i, j, jtop, err2;
+	bool try_free = true;
+	int i, j, jtop, err2, err = eio ? -EIO : 0;
 	struct page *page;
 	bool overlapped;
-	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1400,12 +1400,12 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
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
2.43.5


