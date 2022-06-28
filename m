Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A756555BDEF
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 05:57:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LX9m44Rkqz3brR
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 13:57:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MI80vUMu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MI80vUMu;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LX9lx52ksz30Bl
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 13:57:32 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id go6so11388000pjb.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Jun 2022 20:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lx7hQi3E847Av3Jfg3EdzD9LWVmZxxIyGjVxKoiAyOM=;
        b=MI80vUMu/GC/9G+7tCe2V1vtgE/d+lc7adAYRgwslRRmGZJ//snawOKWJ5yr7BfZA1
         q38+ecD/YvvDInBh3K0qCGps4fM44Js9iKqXNI48PuMA6ssvqs9/pfymj32fs75hL45i
         iCVzzee0IDZ2IMQry7/KmsZzSLyRP1Cf6PYlsN/n58Kf2/4xcf2uW8mooMH0g28SmS0H
         hRs0cD52rZmDaw/PYmC8dWu5z0Np73WP/kIzlF2d3xkr/8G0au+hdfHZrzjTahKiovJL
         obML8jFhN0A6h4LK3lQzVnb3TCWVn2lV9iiMoPicTlUXwAeDZixJDVguidVwOr5ptnYr
         dC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lx7hQi3E847Av3Jfg3EdzD9LWVmZxxIyGjVxKoiAyOM=;
        b=h4ZlDF+GcT9dTgoZU5R2bCK2t4VpG1LTRE2d4+Crot2Xgnl9a0r15ZQHcIV387iWZd
         hcOT9CMDULx3YD3VrWufmT8D8ZjFXPRcElIqPOHT84P0NcSe6qhCk8CaKFQarvBfDFkM
         Nlseq2NK/+ZZUZlw+ZrDpJteinEM27C8GveXH4l+lRIBcWIPLxTT2odpROcTJJxVNM5j
         tfLqvDDY79i9Xv49OUuyYoDQ5AsO+Z1DI+8fky9eRFolNVr8hndZaZSc8yev4HVUDT+C
         CD7DdLs0bYUyq2oQ+QIab8tIGzhGiIjK0LrpqvxYLv4Q8al1e/8QApeLAvUcN6IDcT3A
         78Bw==
X-Gm-Message-State: AJIora9iJzYsDoiUYpc8twiLIRnOYBQoZZqO4gKbGTync9UgWFX2x//P
	kcx/AGEsI1EKJvfP5qMa4Yf0xq1d48w=
X-Google-Smtp-Source: AGRyM1ux1JhG/9HhP+uu1Tdjmhbaz9F2bczDBgozsEkT2Wu/khykL1h+c68zbPRt3lBQlh1zuwzS7Q==
X-Received: by 2002:a17:902:e883:b0:16a:2cd1:e2ec with SMTP id w3-20020a170902e88300b0016a2cd1e2ecmr1583335plg.11.1656388650734;
        Mon, 27 Jun 2022 20:57:30 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090a3e4100b001ecb5602944sm10332762pjm.28.2022.06.27.20.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:57:29 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: add ztailpacking feature to feature_lists[]
Date: Tue, 28 Jun 2022 11:56:07 +0800
Message-Id: <20220628035607.30448-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Complete the dump for ztailpacking feature.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 dump/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dump/main.c b/dump/main.c
index 49ff2b7..40e850a 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -95,6 +95,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
+	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
-- 
2.17.1

