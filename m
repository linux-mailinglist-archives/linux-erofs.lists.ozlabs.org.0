Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC22745882
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 11:36:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=FcBuycsr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvgmX1N3Cz30hG
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 19:36:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=FcBuycsr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvgmN0fjTz30dw
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Jul 2023 19:36:33 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2633b669f5fso2153244a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Jul 2023 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688376990; x=1690968990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwXpzXyEiS9rk9DaOvlDRMsqNit14HTHyLUnHMpguBM=;
        b=FcBuycsrkce+LR3guSd9pmtHyhYa68cDf8YsrGUDapURNJp80p4+nlnyyiAMZC16gV
         SORDXHNt+Z0/kWZzeJlFoNNYsvppP3h+CzU/1u7CgdNdJAdv6vOvhea8w8krBE9CNYl5
         lw9aJeJKihRVlx50kWRPM4cKskULXAtTt8d1V440VSiD0KTE4JtCZIv1da8MnIbtwcJ7
         NggBVXhvTQKqL+fZ4gWeb7ViiS87fll8siOO5nz+7fdf9EjTRvJO7LILg7/SnmBEZbM6
         c3yUDuK5fAmWRXq3tWcZjrSltCz+DI0LFPmzq+ouS/fnRN+CQV94I39uIBbkQEOLop1a
         f4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376990; x=1690968990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwXpzXyEiS9rk9DaOvlDRMsqNit14HTHyLUnHMpguBM=;
        b=UmJuq/e2WPsfrDBi7P6a2Mri3+NUEXNxnCxI97IwpZjf38/nx7SLlkKuuX0a6IalRK
         LjBVNupwGJnca9UXqTiky3otFJi6OWw958507OQP7zWlqdKoZ9bBKxrn3NArl5PH/41z
         EmBcRN8A2yvP5QhUBgn91ArUgKfokmpFCSesC5t3V8FMcslC4DI6Msmrf3BJTkxZSBtm
         YxNGBMaLi44PODj/iNrGKURviFz9CO4O5xZ+niYLgJ6SPc1GMcH1AMSFvkQRqQ/lJGTv
         zKi+zCeRf6ZZCFUxlnqq0OC8E2QWK6Rhn2LY3F3ACVxBoAlNrD9cV99z1hnbmjZxCnpj
         XpnA==
X-Gm-Message-State: ABy/qLbRMv/LpnE6z2nGTlo0GE8EbNS3FYQkcMMmsIvVq5SIP+ivTSTU
	hupgyKlVW13np4SBR/RSYuYNNnefY71X75Xj
X-Google-Smtp-Source: APBJJlHcSWn6SbbCSm9tTZUAJxbp5Tonf4bPW89KwmnfO19MFCFdF8HaKZOQhH67EDdVrjsU1xcxuw==
X-Received: by 2002:a17:90a:c696:b0:261:1141:b70d with SMTP id n22-20020a17090ac69600b002611141b70dmr8423536pjt.45.1688376989928;
        Mon, 03 Jul 2023 02:36:29 -0700 (PDT)
Received: from localhost.localdomain (awork111158.netvigator.com. [203.198.94.158])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090aea9700b0025dc5749b4csm14040103pjz.21.2023.07.03.02.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:36:29 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: update my email address in AUTHORS
Date: Mon,  3 Jul 2023 17:35:31 +0800
Message-Id: <20230703093531.22832-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Update the invalid email address.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 AUTHORS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/AUTHORS b/AUTHORS
index 6b41df8..bc67a65 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -1,7 +1,7 @@
 EROFS USERSPACE UTILITIES
 M: Li Guifu <bluce.lee@aliyun.com>
 M: Gao Xiang <xiang@kernel.org>
-M: Huang Jianan <huangjianan@oppo.com>
+M: Huang Jianan <jnhuang95@gmail.com>
 R: Chao Yu <chao@kernel.org>
 R: Miao Xie <miaoxie@huawei.com>
 R: Fang Wei <fangwei1@huawei.com>
-- 
2.34.1

