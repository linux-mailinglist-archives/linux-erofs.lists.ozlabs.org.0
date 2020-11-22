Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 769902BC490
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 09:55:29 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cf3yk31JnzDqYY
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 19:55:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606035326;
	bh=FrqiybJ34a+YDWI59pSUJal2NJ46bAfvSU2DR+R8loo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=duC72UKfc2FyctGwvl4Vx+mLP6U03/9GZJziEhzABgm7BiTxlvhLrhI6ZIng+bDxi
	 +Ql4mg1aWsrFErF+5eFRdeTKYlH4TW6S5k5VpRRFsrSrtvdeeswgDRT3Xx5TfF2OYz
	 CbDkaLgDO6RoUub/vMHtufiNbKb8HLZrnNRwURa6P+6rA3orYIlCP4B+uuuhduEt2+
	 GPMCcIvJel17lxZaJmZjmBJbQcnBB2rMRZyofAnn58rsrwpqPREsMyUM+h7EmnhtOQ
	 AV18z6+7zOOs2I9QFmu/5sQolr1J0p9tGVgxtJt8RMmHJTb1NMFUQU2bPoQg1puPn6
	 wMRqhkobwthhg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.27;
 helo=out30-27.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=VX1r5/oJ; dkim-atps=neutral
Received: from out30-27.freemail.mail.aliyun.com
 (out30-27.freemail.mail.aliyun.com [115.124.30.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cf3yX2sczzDqXr
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 19:55:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1606035307; h=From:To:Subject:Date:Message-Id;
 bh=MfVSJsMbFlMAIlOIs5rVY+yebELK/v2CfVRGBagG/jY=;
 b=VX1r5/oJJv5VKhlbPMnrJLVEE0MDJVvlCW9PEe2MawBseEgIyjw7KulvPJ832sluXAJyOWyrpOSgKIEsdrZwQWW/fW+hSySMpj+SmnK8tjXkTewFXLcCTAWA4EJGM+5bZQwtgh+x55i/UULpCdtbjz4G+l5fOaPFeAAF0N/kJ6o=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08235136|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0540586-0.000491844-0.94545;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04395; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UG7IzDE_1606035305; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UG7IzDE_1606035305) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 22 Nov 2020 16:55:05 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: stop build tree if file fails to open
Date: Sun, 22 Nov 2020 16:55:03 +0800
Message-Id: <20201122085503.35139-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201122042759.33623-1-bluce.lee@aliyun.com>
References: <20201122042759.33623-1-bluce.lee@aliyun.com>
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

stop and exit immediately if it fails to open a file, e.g mkfs.erofs
doesn't run under the root user (e.g. run without sudo.)

Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
---
 lib/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index fee5c96..eb2e0f2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -908,7 +908,9 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			if (ret)
 				return ERR_PTR(ret);
 		} else {
-			erofs_write_file(dir);
+			ret = erofs_write_file(dir);
+			if (ret)
+				return ERR_PTR(ret);
 		}
 
 		erofs_prepare_inode_buffer(dir);
@@ -982,10 +984,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
 		if (IS_ERR(d->inode)) {
+			ret = PTR_ERR(d->inode);
 fail:
 			d->inode = NULL;
 			d->type = EROFS_FT_UNKNOWN;
-			continue;
+			goto err_closedir;
 		}
 
 		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
-- 
2.17.1

