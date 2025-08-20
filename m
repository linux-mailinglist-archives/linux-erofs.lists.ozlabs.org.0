Return-Path: <linux-erofs+bounces-844-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA6B2D4E3
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 09:31:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6J6Y4hHgz2yGM;
	Wed, 20 Aug 2025 17:31:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755675093;
	cv=none; b=eNr+1x8b7QCi/iaBXlJpl1KNCzD7gP+z8/ZxyE32rhlJvMTTnraS6zdfsofTe1I47ej61i3jgbSQqAljjWnH4SaRKbjZlo7JSElQJMeHHwVmd9J5nkhVud8kuN0YMOthDVTwnnIA/cNpe+PC1WvGB2CUap1oTt1BXf5bvi47trGCEKoE09v4Kgg3B9brghmKogirYaK1ZK462KLOPxs/cJPURZi6rldUXtNdOTjzojvjfJllTb+1Z43qcYRyhG2rCgNGiyesoEP0VA1ACBIKWwogSKjEb+co2bMwAjUqmd7UAtuYi5OmAh8royuWwOWwcCejvJlMztSWoO6LIKFIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755675093; c=relaxed/relaxed;
	bh=G49drQZdTU0puaF6dCVleGw/jtNyINS74sYAHHfNNJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MC/mEQg1FPeBZ9sbRM9wde7COym+wSnIJSsL7xW5FaYL8g98SpThmKvMwLqLCb16CvYdZvo9CMbpS5+cM555VrwIjLaiG2PD92mzpa8S7RIrfuWFs8cxjAkGUdd/NY4y4ihAj373mCsST8o0gt4VSJ/lb7WMG9snnfh+vrbcIsSN7jIw2tNPL9uDJsl3ndfJPLlAYrZhbfuUAGizDQe5m0F4VMU6GXEGARS+V8W0kvIteoaao9OeCYlNLVc3/dJopD7beFu7KOW/M/vuNRkDOV33N5j9PDzNc3NXvTRMqvzt14WjS53+cVDlOPy3TDqz2ML1LIaOrBijVIbwW7BeaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=XygHI0Xt; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=XygHI0Xt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6J6X2rChz2xcC
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 17:31:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1755675093; x=1787211093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G49drQZdTU0puaF6dCVleGw/jtNyINS74sYAHHfNNJs=;
  b=XygHI0Xttev555oyOGEeymyXXOVHa7S1d8ZDBTrfE0EvZ1twtVoKPzUp
   XAmQek0Xs5AudlCFMg73RxvJkoIsjyxdtGuyBeZCbbeuckNFqO+lE2zLO
   qB3ZVm36ugfsB559jS806+bmKtMpm0SceukT+qCf4pHXn29JDlqSA004s
   suQqyZAE7OGcBOVcQv6g6AfehA19lyalHbLpOWzB2Rh6/RjBT1tlwuLHC
   zh9FpCDFyKqv9TBdrwWo7X2XJO3ezqkCioGB0QBOSDCr/R643MIH5hCoz
   RYPMxtyUEiRViqozvrBQHLMxl1Llb+ou3Lo+ds9phdGkxnd+uZlXcD8+7
   g==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 16:31:26 +0900
X-IronPort-AV: E=Sophos;i="6.17,302,1747666800"; 
   d="scan'208";a="21767362"
Received: from unknown (HELO cscsh-5109200313..) ([IPv6:2403:700:0:20a2::1e0f])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 20 Aug 2025 16:31:26 +0900
From: Friendy Su <friendy.su@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev
Date: Wed, 20 Aug 2025 15:23:52 +0800
Message-Id: <20250820072352.4151620-1-friendy.su@sony.com>
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Set proper 'dsunit' to let file body align on huge page on blobdev,

where 'dsunit' * 'blocksize' = huge page size (2M).

When do mmap() a file mounted with dax=always, aligning on huge page
makes kernel map huge page(2M) per page fault exception, compared with
mapping normal page(4K) per page fault.

This greatly improves mmap() performance by reducing times of page
fault being triggered.

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 lib/blobchunk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index bbc69cf..e47afb5 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -309,6 +309,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
 	interval_start = 0;
 
+	/* Align file on 'dsunit' */
+	if (sbi->bmgr->dsunit > 1) {
+		off_t off = lseek(blobfile, 0, SEEK_CUR);
+
+		erofs_dbg("Try to round up 0x%llx to align on %d blocks (dsunit)",
+				off, sbi->bmgr->dsunit);
+		off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
+		if (lseek(blobfile, off, SEEK_SET) != off) {
+			ret = -errno;
+			erofs_err("lseek to blobdev 0x%llx error", off);
+			goto err;
+		}
+		erofs_dbg("Aligned on 0x%llx", off);
+	}
+
 	for (pos = 0; pos < inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
-- 
2.34.1


