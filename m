Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0C4C97F
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 10:30:40 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Tw4Y2wK2zDr9M
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 18:30:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LmN+7kal"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Tw4P3zvwzDr8N
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 18:30:29 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id t16so1233047pfe.11
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=M2u0R8cF7eueZ/4hSaCEDvL0USB3CKQxKznV4wooalQ=;
 b=LmN+7kaldve+jVzHuEu1Ji9YCSTSwYNQzhStjdJLVx0r+Fa2qt/3YkrW1bKKW/iP0Y
 LA6ajX4+ETtbuLypGzABuxGWjaNH2Moi8xiLSRMMdkxxSVkJcBaKw9pKiBULfhShAlEz
 82HA5g+au08NEnRIzefuj+Lsl6CFxuLmhxbey35yRXAKGZSd5FJVACVejlbofC+Gg8kw
 ccIMbtK7wpfOQnr9rgQPhLk/JilfvlujZZGtSwCF+KEQNxH1naqtMGMh3Ai1dMeJIq3T
 rRGxef9391JVtEC7GhnDCpgWgyAqk2ss4A6btuBsZC8fyfh459EXU0Ck70ZxBAiFXljs
 qQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M2u0R8cF7eueZ/4hSaCEDvL0USB3CKQxKznV4wooalQ=;
 b=pKizbKAFxM5GmCFwTYZWwriOiPB7mn0lp+tmWqD73Ha6dowtAsjCRCtY0Q/b5T9YIz
 zQtIha9wHwvtFnNWOKgViiBw45IBz6LiEFDQtE9vA0pvr8RNo/zFPpV5zJXRX8/H6jAX
 9FqS30fwg7uytwuNrkIBFHZBgLUoP1ofN9X1SG9zsH07axmRoBV2ENX77Rjn4tQQ8Lgo
 pPMmj1/d5VvW0eJTiNmix8syeIt5xtmFcjWVVGKbq0uN/TyM419st31hn1hCo7E3tMat
 V4cU61BYfz3hTBMHJKK63xhzX05GkPTh/GRLyoUo4RkYL5BH3gGH0c2/Jo/nN7EMUq/N
 1TDw==
X-Gm-Message-State: APjAAAWiVcsddooy91wRKj2k6x/rM6VZRdPtcqP4if7a9yN4tqENSViE
 ifEwPkuvfS77NZdSde1JLEY=
X-Google-Smtp-Source: APXvYqzVibTxjdUPYRS+z+HxWmKnniAsGRLJE1Hq0dOjiZOKPMvB6O1MQ2YIGd0wctcDDX5S/cwjYg==
X-Received: by 2002:a17:90a:be08:: with SMTP id
 a8mr1771499pjs.69.1561019427123; 
 Thu, 20 Jun 2019 01:30:27 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id l8sm19571238pgb.76.2019.06.20.01.30.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 01:30:26 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
Date: Thu, 20 Jun 2019 16:30:04 +0800
Message-Id: <20190620083004.2488-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

erofs_xattr_security_handler is already marked __maybe_unused, no need
to add CONFIG_EROFS_FS_SECURITY condition.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index df40654..06024ac 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 	.get	= erofs_xattr_generic_get,
 };
 
-#ifdef CONFIG_EROFS_FS_SECURITY
 const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.flags	= EROFS_XATTR_INDEX_SECURITY,
 	.get	= erofs_xattr_generic_get,
 };
-#endif
 
 const struct xattr_handler *erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
-- 
1.9.1

