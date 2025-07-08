Return-Path: <linux-erofs+bounces-552-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9FDAFC961
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 13:19:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbzCv2MRTz3bft;
	Tue,  8 Jul 2025 21:19:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751973595;
	cv=none; b=Kf0YzrFjSMpgAEtlm7R504dFuNKhQHGSIaaDQoVJ5coVGX+MO9Xzp/MWQnAuYFzX2hdnT47thHHstjCUt9wp/N9EGjdOIGO9uPDL6JbIbETg3LTm0XDttMQTX62qn+RWy7zmuofaxuBw6ETRID2YJh3vmJ6bODxO46i267wu8PJGfwrzuIeKQRp9ntZuKNriO2bTrOCvHmFOF9AB44lumVLM5GCsh6GIMct9ndKACHWz8N1mzmBmSHP3z81tmRZL75u4V1DdSx4hfQLCVvGie+kEggZgTONhTmI8+K1d0y6x49BeXFNr1pvtAdqPK8o2L/IThZFgI7fSg4Wc14y98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751973595; c=relaxed/relaxed;
	bh=z1I0K/gEWMOkrJn5a1GvJcxxd9tZkzHfoGrYp6Jzjtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFlM/PgcgWNA/JOek+hE4e9WN3PhpUN0aLDzgFohjK7im9Ok2AU3NLhoB1+l8+NYiSf+z2k68otZvNx4ATc4eOYeMIbToQ5qtl62hQTDvKFrmHUd6zhGv3Tup6y0GgULH6K4NRI50rVdzvx9l0rH7Ld7MuR4hlGKkJOpAUjKnbLWxKBdwWSY1T4GgGbKEMa1i7Ydds82DWK1dICEKI20ShLikW2xdka65vzNXBJGn+xpVTLkPjPRczxhSq4XX7FXyl/+YcE10xpGR+uOwnxrLRVD2WWu5GlANxqZkxVPa/aWiUBCCwYD3YfmZTUdik0gj7EDGbEd/HU6GC2d/eQmWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ukEs4Pud; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ukEs4Pud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbzCt3x6wz3bcW
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 21:19:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 41C9BA53C10;
	Tue,  8 Jul 2025 11:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C9C4CEED;
	Tue,  8 Jul 2025 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751973590;
	bh=1ZpiPWuba+MuyFl8CusarEXRp/3PVfOFUf7cDpRirOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ukEs4PudvgW5/lSg561WtTW6pCAAS5xR5dyaceX0xHeRk5D28hJIljeDnYYby8M7k
	 z2WA7t2OfhkGuFok1aCEbvIbNsIayMurgiYjbK0E8JpQKU4tTqYZWfTutaYYvzl9LS
	 W8sAbArHYapVzg2cBucjAQ7AesyIUEof2mdDj6N8F6oL6BZlJ075KGLr7Pb4QmHVja
	 PYmxnGTdCiR+f4+jBUUTK5CPyNUDV+mAGEumafHcRt8LOHM0aU5LNFGotvO+iAJore
	 AmE16a8FuhcpNq4qmQp+w8tn8IQi8lPZLMMROlAua39wCfvKujgPb853xyIuYjQpQv
	 AU4SlYpgXIIkg==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix to add missing tracepoint in erofs_read_folio()
Date: Tue,  8 Jul 2025 19:19:42 +0800
Message-ID: <20250708111942.3120926-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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

Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
converts to use iomap interface, it removed trace_erofs_readpage()
tracepoint in the meantime, let's add it back.

Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 534ac359976e..221e0ff1ed0d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -351,6 +351,8 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	trace_erofs_read_folio(folio, true);
+
 	return iomap_read_folio(folio, &erofs_iomap_ops);
 }
 
-- 
2.49.0


