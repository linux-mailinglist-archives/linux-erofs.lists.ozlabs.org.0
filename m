Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E63FC49A
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 11:47:20 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DJ8P6XVWzF40Z
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 21:47:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573728437;
	bh=jEknqX7zz7htau5lycYQ7KzAYEZYyALd++nYV2lp7gQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eSiFxjRR+SnXb3IFjWrvYhekWEoQmz6W0NQ464RpU5qiiCWs1oI0HfL9z0XypBo0d
	 0e2iI2XCZnj9BORBN812kti0e3Ds20v9YPpu0vdS3CsSDmag/pxNxUTJkqWUGTVRP5
	 vbYvzjFsq39ylbnifXMtlXNPaBF+gCYrnDw7/9VRj7NuHjbcs7N+5PrsMfLvyUahCl
	 ZvMXt2SMZkJqI/rMZjf87r6LSEz/3zsMCXmeDy4XmYEKT3iRBHCot0CrxUmtSevE6H
	 5kY36UrZ/xCi4De8Wfz88KKwlcR74ZmeZk406nKga6LGtqIL39PCuXnzh9S6fS9YJ6
	 nUiq0zrcw3pwQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.204; helo=sonic303-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rQV1rSGa"; 
 dkim-atps=neutral
Received: from sonic303-23.consmr.mail.gq1.yahoo.com
 (sonic303-23.consmr.mail.gq1.yahoo.com [98.137.64.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DGCG33cJzF6VX
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 20:19:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573723171; bh=r+IFC8DfiG9yZqR9y3BDoWJyCMAFPBXpCHhwiubDr3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=rQV1rSGaDQNtZfH5ilaBDkxZLDFskpF7K1GuiEtRBdJFouKFLlB1kiSc3QJUWrxzskwTw6tJomk0KtiaXOOkduIV8SifNFD8P1aSsoswMhDxN6Z31uIVImU9Ti9KxJshyiC9xPwQ9iOgLZYzTmdt1gC5e4yae9lZYoQxMBBEEq2xHWncdsk9x0SgeUHTx/PKqIO4Tm90PK8EQLgMi6VP/2FWAGh085f+ujGWhzLyKaRZTxA8clJytzjQpR/9WhjhcMREY9KNHm1bPJNOrAbpia+onOTrzvkCX1JRMnckSP3GjnteSnZxAmmuAROQLQEIviBVZdV2WMSw81kANAq/6A==
X-YMail-OSG: G0Xe6n4VM1kDRXxfXsonNw7TFusbe6yVYDY4HoMhvDQ3sDDOS0VEzdsXEWFmXEW
 LfxtHXtfUkjY4SlhFg.AxSo9B0zUsMewmJ8ArD0foOpC74ck0OxJdCbZurdbCPcy9hfm1LR9IKQ2
 Ry.vnxCPtytFgxC4BKsW8X3FwXljlgqh8wIJoKalZLQa_8npAePdMnkQHy0b6HarZk4fnx_LJTTx
 9zKD_vXyyZjuHY1mxU6pc9Yuttnw1IxbZleR5CynMjlnJ9E7iSd5ofcyh3mgn.du4Yos3hseYT7n
 IKLq60txbbzWD1v7p92EPe_GjdzOZSaxi.XkkRuMHhY1HbCKfkQ5mdHAYHq7H6JjMCmGOY4tBffa
 hTBRAVnzZc5JYYKqpEvq1ix96x_.46U.aP.CgqBLspndegOkpGuu4RU1rGS_jMFbSU65F2hAkxiw
 WL1ZyA6YXu_Htuv7aPd8NUmKffCrx8pLzbBumMEU1G2Y.GmJUqk8MivOLgsfIQJQTcw3tRRy5l3_
 CEagYkS9XSJYLHrb_yWSnYBJuVbtNSKUTDkdIPwTlYWIgpGoi6vcQ9YMrqEi03lOj.jblmJUeFOu
 1O2X0FlBLbqq1nKgNlEk38BNfSGPU_hgPg5W89ESw23BUGAl3PP.iBudf2Rq_o1CR4.UeZKbUg3.
 RrVKNJHBzsHqPSwZUVZiPqmi0eDYRib9MORpWxbmXsbwN2_pKATZuYZP4gEYmRcDZkm9Nfgfkz1l
 DWnh3FKbO0rStXAh6Dz6XRmo.UtHgiCRfefHFWx32Qx4peTtOR8vv7fvKx5ypA8.K_Yxb3qbe3S6
 3va20Nwe9fK427crKQ7gJL3tud1cUwe.8TLv_hIp0BqXRcv9NTCeHvTg7t_DGjVkbn4S2mQTNfx1
 Iu8NiIDIReDoh4.LF9hUERF0uE0cSnxcgNKO.A31SUKPzy6ANjNOhLcAIryDD_Sj6epjyF9u.Tld
 sE_iuNeZ3LBoQJObdXgcuTGPRByVmj7N3WeFnjK1fbfjomZpdyrKie3ilFwQrjnczTElAc865.N2
 1CV08X9N00rLV5Kqe8K0uvgqYFdQVvhqV.6GK63Lxe2O6Dg24F_Y2Ggsa_NNjDsn6mWyu3y_OnKS
 el9nB0Wg5uDK4PDbvzv43NK2ovYTJVfQSlXcqKvnDpHDxMgzag2p2ITBqSgHLvV33HTHZyXwa97y
 MSpqbDbclEhaL2DOqLdjvqanuUU97Ea6RqRdhJ5u0xn1djb8LmPPABNnjGvEBSzo1RtutsPG52qK
 bHe1w0HsOa0mgUrvmmEXc3c3kGcm7xmH2MB_0gE81mV34CoSIaf8WCWX3BHwKHLgt6uarfq8KRIi
 ZXnL0fsoTyqFjmSkwAtbVkwexV790KbjLfGdMYTiIss3VviNHlfQtrVtR2IMALZvi1Rgohx3TwvQ
 F8D2kjNg-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Nov 2019 09:19:31 +0000
Received: by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 7679f54d9b2fdd9aef05d84d1e956f49; 
 Thu, 14 Nov 2019 09:19:29 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: complete missing memory handling
Date: Thu, 14 Nov 2019 17:19:14 +0800
Message-Id: <20191114091914.6789-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113170335.17621-1-blucerlee@gmail.com>
References: <20191113170335.17621-1-blucerlee@gmail.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <bluce.liguifu@huawei.com>

Memory allocation failure should be handled
properly in principle.

Link: https://lore.kernel.org/r/20191113170335.17621-1-blucerlee@gmail.com
Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
[ Gao Xiang: due to Huawei outgoing email limitation,
  I have to help Guifu send out his patches at work. ]
Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v2:
 - avoid using system errno mechanism to report errors:
   https://lore.kernel.org/r/20191114015110.GA155186@architecture4

 lib/inode.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 86c465e..0e19b11 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -264,6 +264,8 @@ int erofs_write_dir_file(struct erofs_inode *dir)
 	if (used) {
 		/* fill tail-end dir block */
 		dir->idata = malloc(used);
+		if (!dir->idata)
+			return -ENOMEM;
 		DBG_BUGON(used != dir->idata_size);
 		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
 	}
@@ -286,6 +288,8 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
+		if (!inode->idata)
+			return -ENOMEM;
 		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
 		       inode->idata_size);
 	}
@@ -347,9 +351,15 @@ int erofs_write_file(struct erofs_inode *inode)
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
+		if (!inode->idata) {
+			close(fd);
+			return -ENOMEM;
+		}
 
 		ret = read(fd, inode->idata, inode->idata_size);
 		if (ret < inode->idata_size) {
+			free(inode->idata);
+			inode->idata = NULL;
 			close(fd);
 			return -EIO;
 		}
@@ -825,12 +835,18 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		if (S_ISLNK(dir->i_mode)) {
 			char *const symlink = malloc(dir->i_size);
 
+			if (!symlink)
+				return ERR_PTR(-ENOMEM);
 			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
-			if (ret < 0)
+			if (ret < 0) {
+				free(symlink);
 				return ERR_PTR(-errno);
+			}
 
-			erofs_write_file_from_buffer(dir, symlink);
+			ret = erofs_write_file_from_buffer(dir, symlink);
 			free(symlink);
+			if (ret)
+				return ERR_PTR(ret);
 		} else {
 			erofs_write_file(dir);
 		}
-- 
2.17.1

