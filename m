Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5A55F7F
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 05:29:24 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YT6B0RmszDqMm
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2019 13:29:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="F39j0DFb"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45YT654Z3vzDqHK
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 13:29:17 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id k13so464944pgq.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
 b=F39j0DFbpORjG7U99JjjGnvYO8DvfbbYS/uHEhc53PXtyhGTgmUdMcYhoA4AQvABgI
 EsmUj0eatmyCEidyKK/IaBJQnS6bz4pr089jcIExUOc4vkqY7f+WvswvZK6RYzizXSR9
 O8t/0J3Fv9ndpNEg6teipkCTCOF9MZyfhN3bnBJK9yVyhkdLnPm4fPGtXsPqgKOUM0Tr
 c3pnzLcqMBoqM/bJfcmosPZvLgIE4B+N25nSTAfwFOFFjp00Uo7Tpi9bJsvcBzWpUXCb
 uFmdn5H5Uj8MQjikkkzeEwSByJMZRFiEJj30QQ/DWAgmmmPhvqrhkny1zE03XFxPoBkS
 xGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
 b=SNCOuZCokCxiBvPFl0lhLEC4JOem42+JpsWl7XmTSW2s27GYdW90HgDinFPw3fIuec
 E2r3ehh+ZmRSXT2QwKCqpnqcPe+jJgHHWVGcrrs0u0P1Fh1MpMSIf49odqUvTm82eU/f
 vpqMPBeR5R6mM33pspta20Z80WGEOYKdqGkLT75F2T2Xwvk1dGmRWNeQ9Akf+OgT26H2
 ILyrvJKi6RI3MI5/n+Sf8YZLHWvJxoRIRMzu26YJNAD0jTsvVYPsGvUJMQE8qybSzjOh
 NZve6NM86yl9HWdHpXx7az2i9G8izXMVlJ9+w+YNfg7Sk3DH10wOmW2CcDoiKKlHb7PI
 BS2w==
X-Gm-Message-State: APjAAAUtIkmMJCKqAoD2Z9I7rX3EB42qtGwNaTaJ0iv9zGmnDiHvUb4V
 Iv3p5CFw0f8TUZ9pDIW+U9o=
X-Google-Smtp-Source: APXvYqyi4Bt3ir6rU+TWNnN36A9pN8xg7s2JYPqJdArgPXkkE4o/jlC79rPGT33ctNm4inqrk9UVDA==
X-Received: by 2002:a17:90a:20a2:: with SMTP id
 f31mr1696212pjg.90.1561519754149; 
 Tue, 25 Jun 2019 20:29:14 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id l2sm14563306pgs.33.2019.06.25.20.29.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 20:29:13 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH RESEND] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
Date: Wed, 26 Jun 2019 11:28:31 +0800
Message-Id: <20190626032831.7252-1-zbestahu@gmail.com>
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f..d6e1e16 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	const int mode = vi->datamode;
 
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
-
 	/* should be inode inline C */
 	if (mode != EROFS_INODE_LAYOUT_INLINE)
 		return 0;
-- 
1.9.1

