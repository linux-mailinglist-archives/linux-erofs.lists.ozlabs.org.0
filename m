Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3206813F4
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 15:59:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P5BCT2DPzz3cFm
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 01:59:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ju3Xm72J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::d2e; helo=mail-io1-xd2e.google.com; envelope-from=sjg@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ju3Xm72J;
	dkim-atps=neutral
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P5BCJ3M98z2xBF
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 01:58:49 +1100 (AEDT)
Received: by mail-io1-xd2e.google.com with SMTP id b4so2890685ioj.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Jan 2023 06:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5KEmv2oVzAqywxC9/2SH7vy4mYDl98FWLr256iQF9k=;
        b=ju3Xm72Jvq/BJbBp/zX6dAx5rstYq1MPeo46MBWxqX1ph4EKpwLZBFvDRHYULd93fT
         pnX0XK/+XkwMmoe3gdswEa4zp/n1QhqJ/O87ektn61yEP0JwS15Y4qmRY9dpLi1UcEY+
         r4roioYOqVnfURR5bBAqk/1ENX1uIDxOrTSRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5KEmv2oVzAqywxC9/2SH7vy4mYDl98FWLr256iQF9k=;
        b=TiSbLrVuqA4Vu57NFtjz0GBsilNXfLBBch+SMX8KTeZKAyxjYwVE1vvqQnl62Oqvp1
         JxDCvIuNHB4i4/u4voI4t3dO8iM9dm7Co5U6By5xC33d6TyUU1MsmAB3qyGgpU3ueZKb
         do/9xvn2mePNZVsSbADPcj5lEhio1KTeafj3BPOhbENXMkLlSTWc0SyvaPgIN3wFku4L
         UiOMFO98YhqnmHkHQhgxlxWhlJyQyNqA3JQaukjA10TqC1kwsAwJr3vvf9ldVlUFHYdf
         Os+y8M/45ctLNHYvBbzkvA37N7gLFFZboPdtw1KfVq3nxmpsBASNiMNwP9vAlOr9n3Hf
         cGqQ==
X-Gm-Message-State: AO0yUKXvqQJpyNnS82FARxcLX8l2PBsmSjzkwrFDok+c1Nw1UtvFzfDb
	wlwC9s8Bde3nj4pvbOE1jfZUtQ==
X-Google-Smtp-Source: AK7set8XaDZ/lnWmaWkJkJLzEhDMWtSQ3UGQ1VwvfNsUjIgjwXzxxiwSc7sG0CuYBiumiIeZYy15dw==
X-Received: by 2002:a5e:9506:0:b0:716:9f7a:e783 with SMTP id r6-20020a5e9506000000b007169f7ae783mr7074980ioj.0.1675090724214;
        Mon, 30 Jan 2023 06:58:44 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id g18-20020a926b12000000b0030bfdb6ef60sm4008830ilc.58.2023.01.30.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:58:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH 096/171] Correct SPL use of FS_EROFS
Date: Mon, 30 Jan 2023 07:42:09 -0700
Message-Id: <20230130144324.206208-97-sjg@chromium.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130144324.206208-1-sjg@chromium.org>
References: <20230130144324.206208-1-sjg@chromium.org>
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
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This converts 1 usage of this option to the non-SPL form, since there is
no SPL_FS_EROFS defined in Kconfig

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 fs/erofs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 58af6a68e41..ef94d2db45d 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-$(CONFIG_$(SPL_)FS_EROFS) = fs.o \
+obj-$(CONFIG_FS_EROFS) = fs.o \
 				super.o \
 				namei.o \
 				data.o \
-- 
2.39.1.456.gfc5497dd1b-goog

