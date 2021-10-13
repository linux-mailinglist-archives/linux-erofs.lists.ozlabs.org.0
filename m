Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DB42BBE1
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Oct 2021 11:44:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTngQ3CSNz2ygC
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Oct 2021 20:44:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RC2+mHWg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d;
 helo=mail-pf1-x42d.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=RC2+mHWg; dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTngG5Z9Tz2xvV
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Oct 2021 20:44:25 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id x130so1958955pfd.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Oct 2021 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=309T4j0nNawHtdA5gB6WVyac2BbPJSi45edgVcgCIZM=;
 b=RC2+mHWgzNL1l9Uw9h9wyZCz36StP/awqP32lB4aGm6GKU72y/CymYLgb2nXPGodTs
 8+bmEXyIzLR7fWDi54KHWqwc0oekSmtim1753Oo02ZWXnsMYKk8rWWU/hTIzV7EMi1nn
 eAAhOr5IX0koMLgZNpQj9wP3KIcMUeDWU/Z66kPXDl/DeEH8a7ROMmrN+uKUWfEGInJy
 jWlJkhr7fprG0KVe2j/FMGhiQhAjqqbj2pbuEeTXrH/Rb795gcmXf6eFdQB/pF0wxr5E
 Fy/g0iP5TthUsa+1PkoQ0HcrStAkdfBff6wna2PM6l90+SyjIA/1k68F/PTRJrR9lD+e
 uhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=309T4j0nNawHtdA5gB6WVyac2BbPJSi45edgVcgCIZM=;
 b=NP7j92w6f9+DbNth5a0uzcULtJYqxM2eOvlqS3P1OoMt4CNDlDof/Kzu0AriQ9D9SR
 8baBsOMIXNu/2bV44tj+RkPMhfhsBncEHCiwzOeQ8uDF4b5ITLoftgGwJv8rE+hKZorI
 sR7FT+G5ZLSo6XhURyII1xuQRbthb2ZRdji9SkKDo9ntcV4sgBHVt3FlGNdzSmkZlglN
 Sp8Scy362PxBBoNFd8i8pSBP59T4xHMNyE15JhZBtkiyqAYrIMEMfuF3bPmYQvog5knF
 gSMB5i9kh13km6L8dOirWDcQme7Cx95KRpj//v986WjpHUvEwzuqojkybfAcGFlMWRj2
 KHXA==
X-Gm-Message-State: AOAM531lBXcd8GudRtci0wCkhr6jhIWmi8KpGQ8kKu1eLVyZDE7Dedao
 sS1yB6TqH8liaVwcj0atVOQ=
X-Google-Smtp-Source: ABdhPJz0jjcuXnTewZgN2TT4N95DlzSFOe1oMfFx2udq4eQSpccgSQro5ZXj7osy6fZ+SWwloob+uA==
X-Received: by 2002:a62:9215:0:b0:44c:4de1:f777 with SMTP id
 o21-20020a629215000000b0044c4de1f777mr36612292pfd.31.1634118262763; 
 Wed, 13 Oct 2021 02:44:22 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id v20sm14338080pgc.38.2021.10.13.02.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 02:44:22 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix the per-CPU buffer decompression for small output
 size
Date: Wed, 13 Oct 2021 17:29:05 +0800
Message-Id: <20211013092906.1434-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zhangwen@yulong.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Note that z_erofs_lz4_decompress() will return a positive value if
decompression succeeds. However, we do not copy_from_pcpubuf() due
to !ret. Let's fix it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1..e4cab4e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -326,7 +326,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 
 			rq->inplace_io = false;
 			ret = alg->decompress(rq, dst);
-			if (!ret)
+			if (ret > 0)
 				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 						  rq->outputsize);
 
-- 
1.9.1

