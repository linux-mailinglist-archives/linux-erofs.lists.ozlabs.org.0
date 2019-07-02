Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6E5C782
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2019 04:58:57 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45d88G4DbCzDqTM
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2019 12:58:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YeKCuuuf"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45d888316bzDqSw
 for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2019 12:58:48 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id c85so7515706pfc.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 01 Jul 2019 19:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=/7tczepEzqTlmdybJcXMyIiLXAAIYH2wxpVMMpPnygI=;
 b=YeKCuuufxt1rPwf9tFm3JoYgmAoX8/7P77uCZJXLc34ku8ooPUW6fm90JBYOr7fonU
 Ec9Th7cAjR+DQOigpd7hJnJmSLu0cOtx1uyOAuNSPE/JBg0hDPhlena8qQNlhW0TW+cf
 jV0gQMltaEN3EWijsKA5MjLkCYgimin7zrHkZN7HipFBIKEQ4mZW7pvVbdTOcf/q4Zcy
 +8zftBaFi4ny41YIfIp7UGh1JQVwoGDoxA3fyhln1QGOlx+2NFWYYuGKFCwdV8m+e/ZR
 b9pPgJIHL86/YaD5/NNB42cjlsBPYnTfenXY+14o15yMX4F8QW1FwEjn/6cKy0UdB5M7
 E5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/7tczepEzqTlmdybJcXMyIiLXAAIYH2wxpVMMpPnygI=;
 b=FhcJ1PJqb/r1g7lbK2+3U/gg2ACZDW8csI9SREhelo4HDwYN62K9JkDeuI+7YDRQb+
 4Tg7sIWVURVYgQGVqTFPNjHaCu64xzmFSFPTp/aBfQXk7Xk0tLffq+WoB0ZgMg57N8hX
 riUxxYUeaWpb5uufYSIoXh3zlVGG7VCNuUxvBoVSAw1ZeejB5gUDfGrl/g1j+Ya3ZfmU
 QdAFa7k7vhKw249UFaJ9oLF7JhaQ7RnvbiVm9j9vPfz8ClD7ikQD0L9RM302QaYLxLfK
 NrgIcjSXo2HAeTOjAB4gSfUjtnJ4HjCBOX0eanW7hzN10+YbO+p/nA6l4K0EG+ufpEZh
 a5KA==
X-Gm-Message-State: APjAAAWF8tLxKyaIoN8hvZ9TrK8+w3TCN2qqJwB+uJxDKjDkrUiL0pRJ
 3BR65cha1D5+WzWibT3cRmg=
X-Google-Smtp-Source: APXvYqxwIeo9k12FDWXw1KWHtI7qKb4pB//KHdHVifTgoV2Vgw9mYCBFEQh08tMtoqU0COrGYsUgzw==
X-Received: by 2002:a63:6fcf:: with SMTP id
 k198mr15007946pgc.276.1562036325159; 
 Mon, 01 Jul 2019 19:58:45 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id r198sm14506893pfc.149.2019.07.01.19.58.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 19:58:44 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode check
 in fill_inline_data()
Date: Tue,  2 Jul 2019 10:56:01 +0800
Message-Id: <20190702025601.7976-1-zbestahu@gmail.com>
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
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
no change

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

