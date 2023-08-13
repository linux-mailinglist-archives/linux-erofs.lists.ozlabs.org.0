Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073877A6EB
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Aug 2023 16:27:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CNBDVgv3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RP0HK73rJz2ytr
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 00:27:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CNBDVgv3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::135; helo=mail-il1-x135.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RP0HG2tq6z2yDY
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 00:27:38 +1000 (AEST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3492cd048c9so15723745ab.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 13 Aug 2023 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691936855; x=1692541655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw4GG5UZT4ju06xkyXiTq0DXE77GO29yWYaiJZLNCaw=;
        b=CNBDVgv38BYdCrAM/06+P85CnPqG7zarGVB5SpNdQsJ1Ma5YbLU//L9FOzdo57wmSy
         Yk8G1cAm80gkdjgP73nL9kCOZa5D1JZtWyShgT2ugacOEHkA7YbKRK46Wr8yi4lblIbZ
         DCDeM5olmGAgzFgRJbfqHxZNti+VLN5y/K+c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936855; x=1692541655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw4GG5UZT4ju06xkyXiTq0DXE77GO29yWYaiJZLNCaw=;
        b=BQl6yNueMauYUJ3oeL5HQR2yYTxhcKI7jcuuIdADMYsq7Qe5/pPr5luF7aME0id1fc
         KUDT1loj8fs81lSBvetEhoTwbTyZW3vrsn68SO2mH4iek+OSeiDIoHLMGbguh/0n8hPE
         30JPeAXfubT+5aPw5Jyst7dqLoI1wU7I/2QjLx8bcf4pyoDCs/OKB/OO9NH0iO4Yr+r2
         m23EBPP3UW/yVuuiSihu50/DssEtltUs4PzrSK3Fj8j8y2Go5R9QjV4+8SFYV0NNnmfQ
         PnPQhyTgineyWwvold5fp8THxVpiAjXHG9UtjgqIUMBFahnHd8BTXHgd3nl2yzlSF/KN
         D4GQ==
X-Gm-Message-State: AOJu0YwBhLp30+2FAampr+VUnisSvro4lZ+hjTOkkt81LVHqqHN6HqoA
	BrPgDadr6SSWV/URW1yWvNSK+g==
X-Google-Smtp-Source: AGHT+IEuYboGs4ZmqPBIRUy3sMFL2kd5ZxAStRQxhojTsSYeawY7BQPJ/Y/4rM1y+LnjMHAwLQfxGQ==
X-Received: by 2002:a05:6e02:190e:b0:345:6ce1:d259 with SMTP id w14-20020a056e02190e00b003456ce1d259mr14165965ilu.28.1691936855232;
        Sun, 13 Aug 2023 07:27:35 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id w7-20020a02cf87000000b00430cf006d9bsm2280952jar.30.2023.08.13.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:27:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH 12/24] fs/erofs: Quieten test for filesystem presence
Date: Sun, 13 Aug 2023 08:26:40 -0600
Message-ID: <20230813142708.361456-13-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230813142708.361456-1-sjg@chromium.org>
References: <20230813142708.361456-1-sjg@chromium.org>
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
Cc: Simon Glass <sjg@chromium.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

At present listing a partition produces lots of errors about this
filesystem:

   => part list mmc 4
   cannot find valid erofs superblock
   cannot find valid erofs superblock
   cannot read erofs superblock: -5
   [9 more similar lines]

Use debugging rather than errors when unable to find a signature, as is
done with other filesystems.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d33926281b47..d405d488fd27 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -68,14 +68,14 @@ int erofs_read_superblock(void)
 
 	ret = erofs_blk_read(data, 0, erofs_blknr(sizeof(data)));
 	if (ret < 0) {
-		erofs_err("cannot read erofs superblock: %d", ret);
+		erofs_dbg("cannot read erofs superblock: %d", ret);
 		return -EIO;
 	}
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
-		erofs_err("cannot find valid erofs superblock");
+		erofs_dbg("cannot find valid erofs superblock");
 		return ret;
 	}
 
-- 
2.41.0.640.ga95def55d0-goog

