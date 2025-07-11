Return-Path: <linux-erofs+bounces-589-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65887B02187
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 18:18:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdxjC2LKgz30Vs;
	Sat, 12 Jul 2025 02:18:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752250719;
	cv=none; b=n7IEEuhsw/1FqQ4jUAeC4jBbOnJggdEqrBDoW5EPyzXSMC5UYeAf4hNvPtoJ/S5MYO1n3h3Afb9kOzjbYiET+YyajMuh4Dz9kgvaPc7Zyl4B2oZLyytQv1ALPGxrzEjsOWZMyIMqtZoqaY2njicEInxlcVf8y9FdJ7tk6mhiqAGEsOXuYQw02uaEYoQ37UOpJdYfodnQdrWrYwDNC7sVi89aFN50iFfUe8UPri0AngFClNyZj0rVOJwnbcXDYbnOVB+KmDbXAlTXG0NobzJYWeODK3mV/DWeR1ua9tvWplMXmCHIrBIFU6u/LZNbcFFRdu2yPyZKuSgC/DHB37LvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752250719; c=relaxed/relaxed;
	bh=j2zeGjG6xTu0O75uVtCPqDsKqC82Km44a88j8xkjE2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcDAxSAp7oc+DMYSLg2gnufMt769VSTRf9raJIXpHxB90inpZSYK7qiy+InNfU9Wl3OnAyhN6UUepFVf8GzD0SIKmqbA3L3xF+KEWSQxtS/F5qLRM3q9iIC9VT8LRcaNaFHtqVO7N7+vk03seCZ1UMcXSGqnSFNLpiZjNmvCQ9OOvClFhjjdhTcJ671BrUGmEBrE2LciCuokIojVsl8Nbj4scQhsuHLzSP3+Q8I0sSLK9DbWECgHM10hv1RtPetvA9CoKcbHPMALcNbH4DGYZhoscaas+JXO3wrjm0wIWP7nWr8S9ze0yy6W3jQoQAGaBUNbWLVu9IjixF0bJcwk/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H4nT04Nx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H4nT04Nx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdxjB5Glpz2xfB
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 02:18:38 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2620329b3a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250717; x=1752855517; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2zeGjG6xTu0O75uVtCPqDsKqC82Km44a88j8xkjE2o=;
        b=H4nT04NxS98jwKf0uR/Re1NCYJUF3YVkHiTOPaXRHVc34GhppxVAdoaKTYwHGZzBhv
         dvJpG7pp5T3EvnJ8jGL6SkvNlx7UZGTFJjTUzZz8x/+sxIScgg+sNwMqg2lUiXvlWQzt
         RckGK3qvOl5ulJs9CPMUIqtPqJbldAYoIoqoK99OQj1QPz1Ay2r+z2VCGA9TRYHJ0i7S
         Br4ioiLp9o+O4r3KPyPKDhDyPwpqlbBhHcIP8CTyCqTKgcdHn5veNmRxSswY6ilgLEKY
         RVWslPR+07T21aeRH2A1F/pVmz3p7nZfY5m/tyKhuD/Xs/97j8PPu2n4IWWs9Zi0w2nF
         s1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250717; x=1752855517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2zeGjG6xTu0O75uVtCPqDsKqC82Km44a88j8xkjE2o=;
        b=A/AhwzF0ZZu/QEOYPozkjd05yH+cAmBa+pBNg41Z8dgG+rV8NsKId/n6zNPIMQDAtZ
         eVfVOyzcBNLaZgcaB23ZMgrykUxa4Gwp2ZZLEv6be8K9cWtGE3LimIVBAeaLj4T9N9YH
         0+D+khgNhjOE0qTWmxQN/nqr5Bg5pKwZPJpmOztfXJW+lxfReo0bEYzwS+tGa19+LiHA
         RM/elmnLf6F3fvVXAcIyI5xIQQDMRnObd5WtsSrxzKRhvIl6x9W5iBwDDI1CfhHi2Bd7
         /OrGmhWHYtT230ZBPCGCFz7n3qBrfHRE9Q8HeIMmpZwOW0o/LiM5fbZkSrF4bmXPKNsU
         i5dw==
X-Gm-Message-State: AOJu0Yx4HSOGJgit+nQRqzPpcfe4qmQW2a+whucMaJh8cNvq/WvfxIXV
	i97+WE+gQnser3d4IxgHuGFiwG/LgbNfh22q/MfrHcW+Ek0VpEecsLcJDHkxpofir6E=
X-Gm-Gg: ASbGncsdfCBYIZ7bvmprXhO6dr/q+1BwtRyUzj3cyGH6dTVr0Gl3wiWP/MQcMrJPsY5
	4QbJVY9NnA3XCsHJMUMjymexfOrNJybMghpPQMq7prDPHS4dKo4zBS458C54hymzgDn3IHrYi/O
	fbReTQ/5QTz/zYQHn3xCSegRlU4ivF3NCdBWXJ2TlKFTp26JeboNIW4BeAEX/afH3KklaR4rOWe
	2/0fzfZLA9ixqdW+BlNztYRsnzqJ4V/l0xwc2M4J3TB9qg9mNHhDw4A4n9K/Xg02/UBBW7COZ/e
	U+aaiRo+JZ1JwXEsZ44Vk06VNvYBM3x+lKQRsG5ClA/t+K/83G1omfNlqzkRjga3NSIHIGBP7sM
	Go49emdTBdd085WZLvShPEAXiYJTk
X-Google-Smtp-Source: AGHT+IGneUSOp8C/uxJHlM59/k/j+qSBcGqD/CgYSS1R/N0jb+n7QbrZkEGILz80sU44H29zUecMyA==
X-Received: by 2002:a05:6a00:4fc3:b0:740:9c57:3907 with SMTP id d2e1a72fcca58-74ee2e57b4fmr5145192b3a.19.1752250716476;
        Fri, 11 Jul 2025 09:18:36 -0700 (PDT)
Received: from ZYF-PC.localdomain ([112.64.104.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e075e2sm5865280b3a.52.2025.07.11.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:36 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH 2/2] erofs-utils: lib: add guard clause for z_erofs_compress_init
Date: Sat, 12 Jul 2025 00:16:15 +0800
Message-ID: <20250711161615.44832-3-stopire@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711161615.44832-1-stopire@gmail.com>
References: <20250711161615.44832-1-stopire@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, `z_erofs_compress_init` allocates heap memory for `zmgr` even
when compression is disabled, causing a memory leak. Let's add a guard
clause to skip this allocation.

Fixes: a110eea6d80a ("erofs-utils: mkfs: avoid erroring out if `zmgr` is uninitialized")
Signed-off-by: Yifan Zhao <stopire@gmail.com>
---
 lib/compress.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/compress.c b/lib/compress.c
index bf47121..09b943f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2027,6 +2027,11 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
 
+	/* compression not enabled */
+	if (!cfg.c_compr_opts[0].alg) {
+		return 0;
+	}
+
 	if (!sbi->zmgr) {
 		sbi->zmgr = calloc(1, sizeof(*sbi->zmgr));
 		if (!sbi->zmgr)
-- 
2.43.0


