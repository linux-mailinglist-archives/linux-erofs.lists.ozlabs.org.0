Return-Path: <linux-erofs+bounces-322-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD43AB7B23
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 03:49:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyY6351Qlz2yDk;
	Thu, 15 May 2025 11:48:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747273739;
	cv=none; b=lwp6Xa4+qsrxILR9Jmp9sCqYVchn3rUFb8KH8RnbUaVqj7acB1PZNWmNkLNhxa0Oxia6Qjlc81/i7nF5boTW/qlRedfLynCrJfIP6F8U0oxIHo4TQKA3c+q0ejJqDFyeFDt4j21FyNSSfjvblOefYqYv5JDnsyuCtLIfM+2W/YZRs+mIugNvwL1R+ChE4bZit5FxVoOpiBT/RUBBmxyI5NkOZunzrsWqnQqx9L1D+5YMxRhmgaZRjZvbNIg3JVAhmUJ7XV0M4QWqMVN6LHk32TIHbbbnsTExKP6BuI+ywguZIkric49C/mXcwQ0ZfVzYED4iqpujUjCXJmlWcrNlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747273739; c=relaxed/relaxed;
	bh=oOEnV/2KMJC3wgwepaDuF55brmVsBP86jOYmmGA/5KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRaosdrU1yOVLgtHkMHfbqv6j71YtuMK+JCsTvcLOSilxPWqOJq0o2PRj9Vr49dlksoG8UxUx9JD44m0//loIej+b/6RTUbPOBendg/NoeWO821Kr1Ub9OdIrs79Gj9rMtccPkuGGZU48X+HP8fh+H4t+f/xqGk37ewJPdZ10DdhwLFI0u3GejLL33cIoaYHTBUerNy0ZVZJrKGcYWJOoSxVO0YVLgxTpPw+dbbPkHFlWtq8nfh+Da8rhike+mYWlE3WzL+36o305Yci7y+wHDq2O3aYPOga0hmxozfya7CE9y1xDqpARXxuTRnrsgnzbBt2voZ0g8CUTvCMQ03XdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LXjNcn3V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LXjNcn3V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyY621zVbz2y8p
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:48:57 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-30e390ec275so437698a91.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747273735; x=1747878535; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOEnV/2KMJC3wgwepaDuF55brmVsBP86jOYmmGA/5KU=;
        b=LXjNcn3VoPvH2SNfKOkmXkolId2pbYgSN4rdussJXQuug6BZbKzb/LE4wp+cWoVtyu
         Cx9H6yt1dAYdZ3SWdsYLOR6jMzxyLxsnPqTCP492yAzNgr02DqUDSwaAUpthSQCiCChq
         +rTcRhFCmPJJGvR4hioAgRIyDr09zLq9ORnJeb7BIoYCBxaGzXbq2iwFBnOZr/330+3K
         +xXrEo4QTuqBI4H1SIkTkXAr+Tm9Ufca0nMlkFVNfamFHAiEw497+vqU5vG+5U+3V+YD
         JBYvXkL7wTkV74X4rNnD5CrVNCfC7RXXfaocZtpyKw/Tew3j2bSHSc24Y59dzat8bSiJ
         uAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747273735; x=1747878535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOEnV/2KMJC3wgwepaDuF55brmVsBP86jOYmmGA/5KU=;
        b=i7p84e+7GWeC7ClDsyWloAB0DimhopEbDETs30pXjOEpOceJgn8JxVHJcHolViMhIZ
         V8Ymv86BP4Uk5+znOOsU7TmLFQFhfK1y7Aps5j7bgU1I3jYn6CjZ0a+1vR08+6UDCZy+
         1K35BKFfsAdYaTyL88qmum/zyPVYh3OfhNrOEhcbydQDxiUcqYc1x9+IWotjl6ioAaTm
         sR8ZmPQPAZg+Tu2toAd8m0LMWoXCPtSXk6TAFxxLXKnloonPtthMQgD0gK1gTzsLRpSX
         xrU62g4AIZ8kHFNDymryiegFik2GuKSz6PtR5yQs6ZxrKLcn+ny9FXqEbOdC2S+gI85R
         rQew==
X-Gm-Message-State: AOJu0YxWDbjkfeD9RJMMN5pkKp4J35+zgMRoIhYAEncema/SOU0fDvUI
	e3bPxx12VcatAtO9przeEj8f8EX6d79j/aCOpLdGpYs0RXOO/Qwf
X-Gm-Gg: ASbGncu603dM6IefFBY7Y7KcT93ItqhQsKAQHb2Pw2V8XYBTBJDDs0LxyTtzNFnH5pH
	BS9IgpQonq5oKy8OHkRqbkTwsIE9MhUl9weVIhFdGmzMM2Q7H/cV8qTRgATaqHd07TMx2/YRJI8
	sgiMSxXp5NnL/TwZ3F21yEKLmNSt+eDx/iKNWA0njt3x1ya7tEQgDDsup/2dx2M1PmPbVTHLCZr
	tMnccvYG1wkQ83dmuuQZ1RSFFmEk0hQHGCm5X3o8+bfdq1UApYelZrF0eBzp7HuEXEfLcmRTEjQ
	TwJyFSTYWMJzpvs2ha4flbmStoQHh0gZjvIGlG6gKr0i9d4kXyjZ+KTjPQ==
X-Google-Smtp-Source: AGHT+IHDMnY/v97x5w5dxSCupgCGTWPSnEAHWOQ8uK2Hd+mELF4fFkK2eG87nVkTfnkhyBrcXM+YWA==
X-Received: by 2002:a17:90b:4a85:b0:305:2d28:e435 with SMTP id 98e67ed59e1d1-30e2e59bcf2mr8591859a91.7.1747273734936;
        Wed, 14 May 2025 18:48:54 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33460e16sm2292606a91.30.2025.05.14.18.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 18:48:54 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v2] erofs: avoid using multiple devices with different type
Date: Thu, 15 May 2025 09:48:37 +0800
Message-ID: <20250515014837.3315886-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

For multiple devices, both primary and extra devices should be the
same type. `erofs_init_device` has already guaranteed that if the
primary is a file-backed device, extra devices should also be
regular files.

However, if the primary is a block device while the extra device
is a file-backed device, `erofs_init_device` will get an ENOTBLK,
which is not treated as an error in `erofs_fc_get_tree`, and that
leads to an UAF:

  erofs_fc_get_tree
    get_tree_bdev_flags(erofs_fc_fill_super)
      erofs_read_superblock
        erofs_init_device  // sbi->dif0 is not inited yet,
                           // return -ENOTBLK
      deactivate_locked_super
        free(sbi)
    if (err is -ENOTBLK)
      sbi->dif0.file = filp_open()  // sbi UAF

So if -ENOTBLK is hitted in `erofs_init_device`, it means the
primary device must be a block device, and the extra device
is not a block device. The error can be converted to -EINVAL.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/erofs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 512877d7d855..6b998a49b61e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -165,8 +165,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
 				bdev_file_open_by_path(dif->path,
 						BLK_OPEN_READ, sb->s_type, NULL);
-		if (IS_ERR(file))
+		if (IS_ERR(file)) {
+			if (file == ERR_PTR(-ENOTBLK))
+				return -EINVAL;
 			return PTR_ERR(file);
+		}
 
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
-- 
2.43.0


