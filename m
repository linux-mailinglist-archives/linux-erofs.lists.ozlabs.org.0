Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB465EB8C4
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 05:26:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mc4lx5g7Lz3bqW
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 13:26:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SY1jDJoW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SY1jDJoW;
	dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mc4lp0lPXz3bhQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 13:26:12 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d82so8510832pfd.10
        for <linux-erofs@lists.ozlabs.org>; Mon, 26 Sep 2022 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KZblzyshVRsZqp8gcyYhUjl47k0q6CEw/a6KSnrIuT0=;
        b=SY1jDJoWRbBK/7TMYE8e22/APXrF9W/gl9jIEBX+t4PwNBwRwwMrkTasdYFuRa4tii
         jpB3Peaa889ximjpj9Gch6FTF9O7lDJSSFrboeXsDIh6IbhmsrtZJ2ir7+APJ2qfvkWG
         3FX8x0rxnxpPmt8I+rOZFscoN1NdZPQ1VUMhRoh3nf8bfUbcUm3YIMm3KvFxeeIO/8Nk
         TUuirFCfuRIOoYSn7CjmbmLEa1iz35M7P7Eh22ia/IUjVNY9e6sZLKwPru3qI9jDuX+M
         /p2tNZ2EKt4n15HcthRT5pbspWIVKagK5uQnNWMZhSGreA7rzfxh5KvfH91c3BX28uYf
         +u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KZblzyshVRsZqp8gcyYhUjl47k0q6CEw/a6KSnrIuT0=;
        b=S6ILfwQe4fTuYvh8uw/TahnY84+TZdnQQnxZXZOe5Dg8X0u31Lws0MhjtgKwFdo4Po
         rAXykWyzf2Z8K4olKrkkpX+3F7Z0sXUh6BoIkLNedE8QrG93p9o3wpPCWpSsNN9PDKxu
         Mg47HGI6qZ2Y7C2YSzUaat7xZLVR6XFdoQetW4dTlnvMwUhtRhH54shQ+fLzo1H/bRxm
         gAWWEUKlPBwXU7C5E5IYYoey3ZJJsZcrpAyrKeYR2zXxMaXXRR1o1NVcetnu5xH7yVdj
         HZMS0iEmuqfTdHmewFz/GsQ90xbEUYIQuILsNtSh8U8UdyF1SDJ1/0qFS90nsN4nAItp
         jbgg==
X-Gm-Message-State: ACrzQf0tuVaSZf0pWCoZ7Q519TgTc7dqwvd4Y1syT2274ciwvkTW10mV
	ix1jRyyyYUNGxvADbcTEKp0=
X-Google-Smtp-Source: AMsMyM6ehde7iMnPLV2L8onbpU6kIXx//z/vxwguggErnKb0GtFbTCnRrazAf7zHjjB2+/Z5dYufOQ==
X-Received: by 2002:a63:698a:0:b0:41c:8dfb:29cb with SMTP id e132-20020a63698a000000b0041c8dfb29cbmr22481624pgc.170.1664249168435;
        Mon, 26 Sep 2022 20:26:08 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b0017550eaa3eesm223390plk.71.2022.09.26.20.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:26:08 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fold in z_erofs_reload_indexes()
Date: Tue, 27 Sep 2022 11:25:18 +0800
Message-Id: <20220927032518.25266-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The name of this function looks not very accurate compared to it's
implementation and it's only a wrapper to erofs_read_metabuf(). So,
let's fold it directly instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zmap.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ccdddb755be8..4cecd32b87c6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -166,18 +166,6 @@ struct z_erofs_maprecorder {
 	bool partialref;
 };
 
-static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
-				  erofs_blk_t eblk)
-{
-	struct super_block *const sb = m->inode->i_sb;
-
-	m->kaddr = erofs_read_metabuf(&m->map->buf, sb, eblk,
-				      EROFS_KMAP_ATOMIC);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
-	return 0;
-}
-
 static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
@@ -190,11 +178,11 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		lcn * sizeof(struct z_erofs_vle_decompressed_index);
 	struct z_erofs_vle_decompressed_index *di;
 	unsigned int advise, type;
-	int err;
 
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
-	if (err)
-		return err;
+	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
+				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
+	if (IS_ERR(m->kaddr))
+		return PTR_ERR(m->kaddr);
 
 	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
 	m->lcn = lcn;
@@ -393,7 +381,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
 	erofs_off_t pos;
-	int err;
 
 	if (lclusterbits != 12)
 		return -EOPNOTSUPP;
@@ -430,9 +417,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
-	if (err)
-		return err;
+	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
+				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
+	if (IS_ERR(m->kaddr))
+		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-- 
2.17.1

