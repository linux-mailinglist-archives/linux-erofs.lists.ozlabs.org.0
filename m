Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB071FECF
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 12:18:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXf9D2VlFz3dxp
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 20:18:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=VCmFLWbo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=VCmFLWbo;
	dkim-atps=neutral
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXf943kgVz3dvt
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 20:18:31 +1000 (AEST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-55586f22ab7so1423710eaf.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Jun 2023 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701109; x=1688293109;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upB3waIP2hUm/FpL58MJrFYCApzeB/vEH5POm2xK6To=;
        b=VCmFLWbo6mu7M4ibHvogOJZPbhaugxoCusWSW8lrzbb/Xv/sKoAU9HQd5Byz/sKDzz
         8rzJOBS9/k0bEBRlfuppsshIoiZGGI+tWoZFvWL7F0NAE0IhkCvDeD3nUAtPPG0Tv99d
         l6nPgZ2DPD3+JUsbafRUGCAbcO1I2CvLTPcvF7bx7kV5ma2zPNBQCKUzWeHyXGx/hzDN
         KbqM4bTgRzjgdMMC8dpi/FWZ9mtdoxaOy4MOYniIY+E129C/tYGoZtshQvAFXTeZ5ySj
         McveSlfK4gOco8P79rw4Al0DXf8Is3V4ShYticzEfA2BcJLPn8SUSg1gKMYRSEmL/BcF
         4Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701109; x=1688293109;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upB3waIP2hUm/FpL58MJrFYCApzeB/vEH5POm2xK6To=;
        b=O5k5EKa7xc3GfH0jq0SABYyXcpMVezvEi0kxhgYe/sU9yzQqwGoQIxDli1rdLDUk55
         tiFkQRr3RL1i5VC8HJXM4QCUJOeD7hlyoO9vur4qmSqcO5hg5/58yOHLtMfalGnHiQO+
         h5d52r4Huaoff7oERORpAag8Eoc8X74g6cMBkW4Xjw4mptk4+YdaZosTMnjCO8hRWAd0
         9hM171AIYcb3D2sJ6viTiOwgpGosxlJ+cDh8NXqyhPIG/0kH9vcrMmg8Em/CeePCtStN
         z4v/jj8uPUNXtbrP2SW43Y+z0QMlA9lzA31EuiHz6t2EZ7BByy99MFT+lLX02qhmS9pp
         m+sQ==
X-Gm-Message-State: AC+VfDwaUHDLPVKOtKSVlnKhY+WhA5YkZ0LwzeoPB4bktXa3d3xq47Br
	hnot/KOi2EK8k7FWVsaH3G5PnNqP0sA=
X-Google-Smtp-Source: ACHHUZ6Teoupmh0s3TpBxuwCWlK7gqGUPKZ1MJCtmnurBf4qs3VKfHzdMbo3aYOPqk4aqSJT2M+4aA==
X-Received: by 2002:a05:6358:5e1b:b0:123:3cc5:e6be with SMTP id q27-20020a0563585e1b00b001233cc5e6bemr10361831rwn.9.1685701109001;
        Fri, 02 Jun 2023 03:18:29 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a390100b00256a4d59bfasm2947046pjb.23.2023.06.02.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:18:28 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: fsck: verify packed_nid when checking packed inode
Date: Fri,  2 Jun 2023 18:18:05 +0800
Message-Id: <8e87974be6533d03cff7bf6af222869e7ddba015.1685700307.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d755ab1c4eaa634f8822b6ce663c1d1a66aae09c.1685700307.git.huyue2@coolpad.com>
References: <d755ab1c4eaa634f8822b6ce663c1d1a66aae09c.1685700307.git.huyue2@coolpad.com>
In-Reply-To: <d755ab1c4eaa634f8822b6ce663c1d1a66aae09c.1685700307.git.huyue2@coolpad.com>
References: <d755ab1c4eaa634f8822b6ce663c1d1a66aae09c.1685700307.git.huyue2@coolpad.com>
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
Cc: sunshijie@xiaomi.com, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Since dedupe feature is also using the same feature bit as fragments.

Fixes: 017f5b402d14 ("erofs-utils: fsck: add a check to packed inode")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index ad40537..7864318 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -789,7 +789,7 @@ int main(int argc, char **argv)
 		goto exit_put_super;
 	}
 
-	if (erofs_sb_has_fragments()) {
+	if (erofs_sb_has_fragments() && sbi.packed_nid > 0) {
 		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
 		if (err) {
 			erofs_err("failed to verify packed file");
-- 
2.17.1

