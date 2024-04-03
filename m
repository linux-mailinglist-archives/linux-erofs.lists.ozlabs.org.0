Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5683F897CC8
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 01:57:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712188671;
	bh=0mcsDjNylWyuv4Nhacz1I77t7TX/D70Z7uILDGBoM7c=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BTTrb7VyLAXl4gyk3wFStH5EVPAKHEWr9f+EMzIYNPLuamLol8/FfHraNF5QY17jo
	 fCDGxSIt7MV5nnRW616H46VDz4A3f44HPj5YxkBO5BMbEfq0dobGP64l7ZAPo8G/D2
	 gSbAmY6c/3YErmbkneq0Y1Ug+khQN0TBEgVUMCUstk+HcMe5XbPXntFVorGkWdHQg6
	 tjDU5p9raeKKv50wqtj30o7QNAi/AU8Lzb/cIPe62ZTvPp8TdFREB/2I4b/g6HyS+6
	 0CofcDZIvvcp+SDPq1TzraT8wfw/8qQ3Q4Y/4hfX5H7BsMpRPdkSxO7FmV73NPOomc
	 xdUMF3KsKDKzA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V91sC0ZQmz3dkm
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 10:57:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=blURlzo/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=38uwnzgckczsaexsxibdlldib.zljifkru-bolcpifpqp.lwixyp.lod@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V91s10BZwz2yt0
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Apr 2024 10:57:40 +1100 (AEDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-61510f72bb3so7785217b3.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 03 Apr 2024 16:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712188658; x=1712793458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mcsDjNylWyuv4Nhacz1I77t7TX/D70Z7uILDGBoM7c=;
        b=fEcYzVoeWEKGJVZ/50bFAsMFN48UCFkYpQWWq7cbI+qLxEx0qzX9ilq/RxRylECSvy
         nfXYDi7n2soL0T+AcNZ6PiMOHzLldDpCHbu5Y1oerz7lj4EabGKZNtvFFz7h1FqDeBmm
         dRQZPZKxyqkvI4FHtW3oWe10tqCeGukWaED2dDkg/5RzEXedzgksIuBMeFlQE41p0Gyu
         zRTmsppEur7OAyuMBLhecRIJW9JVA1kkHfADYEL9jUHVgBTIN7JXScpTn9FWVIVvSKeM
         nXzaYnrAMlR/9TtPAZEjJ4G8dhI5OfC5H6RWf1LtyDccb97rPcPb1mQhN2UQcGePBA+e
         zlgg==
X-Gm-Message-State: AOJu0YyfyXP0Da7P3DBc/ocOBHUOdlKPVRp5eFZUmsN1UTWM7aRCI5Md
	lYKROaRYtlECIPEA6FhhvaPO3ok3zkRD2eRgkLHjJITLEoq0Woj01S0aGqfporDpPanUrTh7E+x
	7guIdCW8iBaB0fblpt7j2WlcG6rILfGgBkKvJr/XzoI516aqGcnHLhra9HHx41/9h77Mukmlnra
	03iuxCCu+gIYvOjj2z0gOuEEEU6uGo65dTZKp/mEsXqEs5Kw==
X-Google-Smtp-Source: AGHT+IHfZqaR+beKY8kxOJyI2qezCxSyOCHGIEkd/83hStCq23ZO+XHL7RSRl/AmVrfQJ3bMGbelGJPRkwh2
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:70db:9f14:826f:fa92])
 (user=dhavale job=sendgmr) by 2002:a81:848e:0:b0:611:5ed0:228e with SMTP id
 u136-20020a81848e000000b006115ed0228emr272157ywf.4.1712188658350; Wed, 03 Apr
 2024 16:57:38 -0700 (PDT)
Date: Wed,  3 Apr 2024 16:57:24 -0700
In-Reply-To: <20240403235724.1919539-1-dhavale@google.com>
Mime-Version: 1.0
References: <20240403235724.1919539-1-dhavale@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403235724.1919539-2-dhavale@google.com>
Subject: [PATCH 1/1] erofs-utils: lib: treat data blocks filled with 0s as a hole
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add optimization to treat data blocks filled with 0s as a hole.
Even though diskspace savings are comparable to chunk based or dedupe,
having no block assigned saves us redundant disk IOs during read.

This patch detects if the block is filled with zeros and marks
chunk as erofs_holechunk so there is no physical block assigned.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/blobchunk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 641e3d4..8535058 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -232,6 +232,21 @@ static void erofs_update_minextblks(struct erofs_sb_info *sbi,
 		*minextblks = lb;
 }
 
+static bool erofs_is_buf_zeros(void *buf, unsigned long len)
+{
+	int i, words;
+	const unsigned long *words_buf = buf;
+	words = len / sizeof(unsigned long);
+
+	DBG_BUGON(len % sizeof(unsigned long));
+
+	for (i = 0; i < words; i++) {
+		if (words_buf[i])
+			return false;
+	}
+	return true;
+}
+
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff)
 {
@@ -323,7 +338,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			ret = -EIO;
 			goto err;
 		}
-
+		if (len == chunksize && erofs_is_buf_zeros(chunkdata, len)) {
+			/* if data is all zeros, treat this block as hole */
+			*(void **)idx++ = &erofs_holechunk;
+			erofs_update_minextblks(sbi, interval_start, pos,
+						&minextblks);
+			interval_start = pos + len;
+			lastch = NULL;
+			continue;
+		}
 		chunk = erofs_blob_getchunk(sbi, chunkdata, len);
 		if (IS_ERR(chunk)) {
 			ret = PTR_ERR(chunk);
-- 
2.44.0.478.gd926399ef9-goog

