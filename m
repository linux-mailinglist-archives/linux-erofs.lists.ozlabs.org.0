Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB69E699406
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 13:13:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHYkX0sJqz3chp
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 23:13:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nYBLFtzb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=error27@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nYBLFtzb;
	dkim-atps=neutral
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHYkS0vhSz3ccs
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Feb 2023 23:13:18 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id he33so4577313ejc.11
        for <linux-erofs@lists.ozlabs.org>; Thu, 16 Feb 2023 04:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRkj7un9T+kRR6jY9Frcp8Bss2eFDRGfWPpzJWFTUHo=;
        b=nYBLFtzbctA/qAwwY2F+iCtNHWPBZKH8BR+YuC4lXBJt4KyloMY1k8YeUQo7EImMfA
         a5vVMOZN9I+2Q2et/bnX0/uGZiiKtSHntDpWazgkS2813TgLa7hpa1nJItykC0iBV/Jk
         eSJJN1Fe9tLMnkxkXTdw5icN03MW0IBzDr5wE2MFcGV9UFCt6ADKh3nZt/R5NSkLV17U
         HXkEjzeua8KJBNEDxdmK677yUzYFicZvGEze05EkNyB6byJAszdz8Hy+PXJE+FcaQaLC
         uc8jUOomLhscE9nKmG77efaj9e7cbfD6ESOLpJsr0klacrZWLI0OZKnAijkOJ0ok0v1I
         fcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRkj7un9T+kRR6jY9Frcp8Bss2eFDRGfWPpzJWFTUHo=;
        b=dTBBm6ffjaNcdEImnK0wXpxZN937dPqZdmAzjZ+v5ilJuTz/qZUDJPtY3lvYCDcAaM
         blYV/gTyW4J/+tN65kHrktF90E3NoRGjh3/VISx3I+WQixgRGXPWCzJWYrt2L35SZtJT
         4sKy4riYvFddg5uBSpCkqtPcIo4pj5Lp85dbV6CSPAs5vfBfsXIdXWg3Wj9d5PCkU2mt
         /qPmpD3bPvtyiT1k00gT8TQEbgZ9qC4Wb60hadbhd6w8DP+rGU8rl0WcF847+/4wek9h
         M3F0XF2kO4IlgcPLYJlGn0joKuuzYC4QjWURG3IZfPqavwkxJqR2bTRT4wLTJ4imjyZN
         HF+w==
X-Gm-Message-State: AO0yUKWUYLR28z0ZPcc71K1M6lEK3FbrdIOg7hA+sIhsvvxm9OSfiMNS
	nC9elwmp4HZQgTK8geNuNxc=
X-Google-Smtp-Source: AK7set+DOdwYRSWUU1TmLaX2hFth3dK9MKZ235xzhGSxb0RjCBgl9+a1HoD78oIbB0+/WGrwCjW6gw==
X-Received: by 2002:a17:906:e09a:b0:891:a330:c890 with SMTP id gh26-20020a170906e09a00b00891a330c890mr7041028ejb.0.1676549590509;
        Thu, 16 Feb 2023 04:13:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020a1709062c4c00b008b149e496e5sm720949ejh.163.2023.02.16.04.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:13:10 -0800 (PST)
Date: Thu, 16 Feb 2023 15:13:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH] erofs: fix an error code in z_erofs_init_zip_subsystem()
Message-ID: <Y+4d0FRsUq8jPoOu@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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
Cc: kernel-janitors@vger.kernel.org, linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Return -ENOMEM if alloc_workqueue() fails.  Don't return success.

Fixes: d8a650adf429 ("erofs: add per-cpu threads for decompression as an option")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 fs/erofs/zdata.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8ea3f5fe985e..3247d2422bea 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -475,8 +475,10 @@ int __init z_erofs_init_zip_subsystem(void)
 
 	z_erofs_workqueue = alloc_workqueue("erofs_worker",
 			WQ_UNBOUND | WQ_HIGHPRI, num_possible_cpus());
-	if (!z_erofs_workqueue)
+	if (!z_erofs_workqueue) {
+		err = -ENOMEM;
 		goto out_error_workqueue_init;
+	}
 
 	err = erofs_init_percpu_workers();
 	if (err)
-- 
2.39.1

