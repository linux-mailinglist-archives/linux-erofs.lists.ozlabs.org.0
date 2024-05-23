Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 8471C8CDBC4
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 23:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1716498124;
	bh=bWgje+W+4iPJ/gcyjBf/WjqMUfPsTuxvtzT/TU33XFw=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FT9bA6+VRrPv+3jbB1co+kStOzn8DRtg02tR/6L6rzop9GTF2kQnVq8q+jdutsnvN
	 gNsd6/0jh+ebHCt1Yd4KF2nDIa4bnP5hHU3Z2rSrPxf1ScEQQCVgbg0xEnRiodruVc
	 Sl4I9t6IpH2K0YPy6vk7KDWjdP0oXiqSl7sEcRnq2dpptGyplVDJrKI0jdCdTfLhiE
	 OkZkqHjqoFTSnMOUxCJ3MAOlXmtcc+BhKwkNLLVX35fTh2KVHarjpIoMxZiRC725U7
	 71O70HVTyHJQggFcBSWFVhDXm1N01e3KW/Xg2UrHKi1/ayQ2COhDwotFO2ysCEHsZn
	 Rsbxj0rl2ve1g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlgbJ0g2jz87TS
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 07:02:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=eRNoy23S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3ua5pzgckc44vzsds3wy66y3w.u64305cf-w96xa30aba.6h3sta.69y@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vlgb16K8Kz3vYd
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 07:01:48 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-df4d82f868bso5664739276.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2024 14:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498106; x=1717102906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWgje+W+4iPJ/gcyjBf/WjqMUfPsTuxvtzT/TU33XFw=;
        b=J8zwhzaaLELHkRFk2goANiWPgkclQzWVCvnbdoI14GqWsmpf3THlQoeuA/WjrJEB2g
         gAcQJ4PsCf7AX8e2KotnM4wbzgVbGAKRyAbRlTHAlauly/s8TWI5u92mrvnoRTlKW5Xx
         Ut3WIK4aSkn/Zs3TY6iO/PBAd+u1Mjb5YVBnte8FpSINclDz3IV1V2bfpqK3XWJuFsGG
         w8Gm/B/koj/vSYrHKy23aQQHlh4gNTZqu6megtWV/1j5uYjvfzzEBh6FMX6azLt72DDT
         UVmljGohCE42VT4X9rK3ynZgI6EeNkvrc3ebPuZGCzVqo9njxwhbZevPY0i2WVQ2COL1
         Zv5w==
X-Gm-Message-State: AOJu0Ywy9E0WiZ0B49WWlINHaDKSz+tTLJ1nzZ+kZFzpu396nO/agf4W
	z5ZYE/T8AgMaaZw2CrDRDMcAVynBmjOrB0Gvk4gNRoPAiImQ1fKMoouDJZIdG8h6yL+yeAxDKB8
	9bSk3RUlHbNUZk4qP/wMy0uXK9Pdqr6giatk16c5gPHeZ2589GfyRK6rR/HO/+hps42+Z6blNFG
	Lsp3mhlxeI6Cjh2RPItI7brkAOq3ndBuHNiIwc7Iz6L1YR/g==
X-Google-Smtp-Source: AGHT+IEXzTA28OnOYJMSHgQCu73jtvt06c2S3r0jpkORoknU9B9lq/Kbk/QStKkCaw7atz+uf1uRtYoIGnl0
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:a2ff:32db:ca12:f9f5])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1007:b0:dee:663a:340d with SMTP
 id 3f1490d57ef6-df772212d93mr94247276.11.1716498105688; Thu, 23 May 2024
 14:01:45 -0700 (PDT)
Date: Thu, 23 May 2024 14:01:31 -0700
In-Reply-To: <20240523210131.3126753-1-dhavale@google.com>
Mime-Version: 1.0
References: <20240523210131.3126753-1-dhavale@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523210131.3126753-3-dhavale@google.com>
Subject: [PATCH 2/2] erofs-utils: lib: improve freeing hashmap in erofs_blob_exit()
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, junbeom.yeom@samsung.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Depending on size of the filesystem being built there can be huge number
of elements in the hashmap. Currently we call hashmap_iter_first() in
while loop to iterate and free the elements. However technically
correct, this is inefficient in 2 aspects.

- As we are iterating the elements for removal, we do not need overhead of
rehashing.
- Second part which contributes hugely to the performance is using
hashmap_iter_first() as it starts scanning from index 0 throwing away
the previous successful scan. For sparsely populated hashmap this becomes
O(n^2) in worst case.

Lets fix this by disabling hashmap shrink which avoids rehashing
and use hashmap_iter_next() which is now guaranteed to iterate over
all the elements while removing while avoiding the performance pitfalls
of using hashmap_iter_first().

Test with random data shows performance improvement as:

fs_size  Before   After
1G 	 23s 	  7s
2G 	 81s      15s
4G	 272s     31s
8G 	 1252s	  61s

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/blobchunk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 645bcc1..8082aa4 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -548,11 +548,17 @@ void erofs_blob_exit(void)
 	if (blobfile)
 		fclose(blobfile);
 
-	while ((e = hashmap_iter_first(&blob_hashmap, &iter))) {
+	/* Disable hashmap shrink, effectively disabling rehash.
+	 * This way we can iterate over entire hashmap efficiently
+	 * and safely by using hashmap_iter_next() */
+	hashmap_disable_shrink(&blob_hashmap);
+	e = hashmap_iter_first(&blob_hashmap, &iter);
+	while (e) {
 		bc = container_of((struct hashmap_entry *)e,
 				  struct erofs_blobchunk, ent);
 		DBG_BUGON(hashmap_remove(&blob_hashmap, e) != e);
 		free(bc);
+		e = hashmap_iter_next(&iter);
 	}
 	DBG_BUGON(hashmap_free(&blob_hashmap));
 
-- 
2.45.1.288.g0e0cd299f1-goog

