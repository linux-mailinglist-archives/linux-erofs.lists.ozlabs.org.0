Return-Path: <linux-erofs+bounces-615-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C8B045F5
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 18:56:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgpNp5L4Dz3btP;
	Tue, 15 Jul 2025 02:55:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752512154;
	cv=none; b=ou3VBDbogKqb/NQoqaaStdFx1L231U4zB5Dj8HbCYOR1dm2Rh4AgoU36NMKKWfoiIQbXm9KYzmxQO/qmDpl6GvMoU/L+j/SUXSxcelS+AhjD3hagaiAYAYV/WZZQ6Ua4CoZ6LmRKEHpdS3M1MA+WQe1i6ng2j8SqySDTtSwzV+MqRtQmqhF9R1WVVNfjdsmzpDqlE4WcDs8TqQr3gP7MgqOS9NwkDjFIHq2907vF281ZqY9nxDd9UGtlQTC+yH/I3cTZzv3uIxJuDbThDlOgbUC1P9g+keNlHll5DqWtgRerqsn3X+Xds1umHUb6DJ4fDBsCy9F6OnIJxqcFoKf/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752512154; c=relaxed/relaxed;
	bh=wpIkjlJGnmzx2jmcpPUcPQOOhbUFTOXtYYwoy7T/ebE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSpSbRVt0lj7i7NPIZLuJ0BTgOTmcBrtRcx/Uvdt1cHU95WjfuM0EKdyc8UDo+/P2Jyh4fy4qf9BUzfi4Jk6BZGnFFaCOs8h7mR44UbPMJXbXxSTkXSbmutAWzk6cy74uGe2cLJPAFQjv92J89odPAjmg44HpDmrX5Lq9N/FUwYCYWhftDef3wBf0cbPylOZCBl5dJiNbzm8VseeGgclbwpiOiT8gj1ZIqzfUChdSb+lHdQY0oW3Ih8QWnlhGdF1EJUHdP67NBNaQyQdJahtjxSXdsU/aup9FGRxiHbQNwuf+ES3gev/q9eYufxerFv+WzXBu85lsNwuh87YhOG3kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OHrvMyk8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OHrvMyk8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgpNn1Pjyz3bmY
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 02:55:51 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2769998b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752512148; x=1753116948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpIkjlJGnmzx2jmcpPUcPQOOhbUFTOXtYYwoy7T/ebE=;
        b=OHrvMyk8wHT4YH+kOeldQuL4Bs/bsx3ftdbrq37oVc+ka2uvXMY1hIW0J8XeiNDZUi
         AzFYKL5X5QuJDDnr4u8XQSSPlyt9nfxBLd2sgDW82mjDYk1AN5rKEvzL8HwtYrZhB2gt
         kZMcZLP/qkoOKB32JQrXgFwpjseemMccb+sdAf4k1NpYXRGR1e/s/3K0JOWzjnYbXXol
         /8tvW8nK97vBXsZx2ks/brlijew2QEUB6muE/5K1SrQeuS9DPVFHgPx5TUJXnXVTHHnj
         /lGYIIaMBEZrVkSHunT4gsDFWxc5YBjKGIse+ow7xOhfT3zKS85fNOJmZ7iN81UigLVQ
         F03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512148; x=1753116948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpIkjlJGnmzx2jmcpPUcPQOOhbUFTOXtYYwoy7T/ebE=;
        b=Sw8jbjZAgyobYqZwpjqYX2FnJTe3BcCiax9DB9S1t4acdctaZf5TtoQqDtgWF6ZyMi
         jbqrOYeU8Gg1tdd1SU4vax0Fu140+aB+fAaZwrKs7js+x9LyAyZhuSkC+E7KjTzLY9Eb
         FsXEYYARQVSvUmQ8jq7oOT2em22pGX4lpr/KwjQ0/T/fc8FzC152uHSs2yjrNK+3i0D9
         BObbk9VzrT3mJkGxLA3N96VKnq85S8rPFojTYj2jXxEgemQ5zHJf//3go0vBQqw+Yuyx
         H16eJMzbGpjzZXmMXtt7onWKzC9PNaNhgqzw2CLOK67xC082XpdF7ufRC4WWbwZ7ncR9
         eWqQ==
X-Gm-Message-State: AOJu0YywQ3IzAAceUyVeCfCJUrI2nO5EKgvl3aPCwmKDGj9XngJ2sdZx
	Y84HG/xxuqyAxTaPtbO4CHmEnp0uEPkW+kwwDwEQk4PocfrqFlTlacvPZR6odKmwb7Q=
X-Gm-Gg: ASbGncuP/cZsb3qqAz6aRPw5yO7Bxeak3+sjpwbacYRRfZosY/xKeUaliPbmkj3CU/B
	jHX9XN2azh+I6ajrGSK511eAu4n4XLKxsAxbJ47lpnexULWzDW3mwaJe6IET44a28aIt5uJsb6k
	yW5qhWYWpQJWXhNT2B1JxZdsAZQ61zaba/HQSTjVC596QvUfCIbnmv7mPMvPqyYqbGcbkYDlx4q
	ScmBOoUoarEuZC1l6oMxnlx0wIJrUXnrM+jOobxrANWkxuWJNdadW7BPiMyMpxQtOkpELiL8kWo
	/AEU8Chcav2racxbHtssSqgTQ8C+ud9iHTz10JT4ClY0YQCcO+tNPjM8h/RGTaPs1HyuKwgji22
	ziTSNYa9O09lrVN6e5Y5rUPIPzfwb
X-Google-Smtp-Source: AGHT+IFcP06yQwgIL+XwlGUqDoLwDwGyBx7lG8kNm1LG11J3ohzKQ+65F4p56n4cJI5qjZ6cKNQgsQ==
X-Received: by 2002:a05:6a00:1748:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-74ee216074cmr20564566b3a.12.1752512147827;
        Mon, 14 Jul 2025 09:55:47 -0700 (PDT)
Received: from ZYF-PC.localdomain ([112.64.104.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52d38asm10424005a12.9.2025.07.14.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:55:47 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH v2 2/2] erofs-utils: lib: fix memory leak in z_erofs_compress_exit
Date: Tue, 15 Jul 2025 00:55:42 +0800
Message-ID: <20250714165542.17023-1-stopire@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <234da676-1ba3-4824-9fd4-cd9b41de48b5@linux.alibaba.com>
References: <234da676-1ba3-4824-9fd4-cd9b41de48b5@linux.alibaba.com>
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

Currently, `z_erofs_compress_exit` does not free `zmgr` if compression
is disabled, causing a memory leak. Fix it.

Fixes: a110eea6d80a ("erofs-utils: mkfs: avoid erroring out if `zmgr` is uninitialized")
Signed-off-by: Yifan Zhao <stopire@gmail.com>
---
change since v1:
- free `zmgr` in `z_erofs_compress_exit` rather than allocating it in `z_erofs_compress_init` conditionally.

 lib/compress.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index a57bb6a..3c87a28 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2130,16 +2130,15 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 {
 	int i, ret;
 
-	/* If `zmgr` is uninitialized, return directly. */
-	if (!sbi->zmgr)
-		return 0;
-
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
 		ret = erofs_compressor_exit(&sbi->zmgr->ccfg[i].handle);
 		if (ret)
 			return ret;
 	}
 
+	if (sbi->zmgr)
+		free(sbi->zmgr);
+
 	if (z_erofs_mt_enabled) {
 #ifdef EROFS_MT_ENABLED
 		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
-- 
2.43.0


