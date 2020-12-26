Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1C2E2D61
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Dec 2020 07:28:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D2v5G0vJczDqLt
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Dec 2020 17:28:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1608964098;
	bh=p73TFyyUr6PVjuKRGIakHS47nCcbG5qBxTAQJz4BteA=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=fF5umI9APPGmrnGJg9kwfqrwoC6OpI0IEPXC533Ph3uvLMN1iq94BJ5pawIWB1488
	 UEwocj9iuuUOVLRADnob72A6p+c7F+n6+aea4Fx+MQdL3tKKr50HhdPu8NEfhysNDM
	 lAZv30eIQB6qhTxV2q6gCvdIeAVIz4q9DuijI4bUKdSfK3Y45OZ5E92UXxZ75uv/8s
	 o2VjmjRE2bd3NqKWvobUI/fFxmPs0mxaBXMEDoRh4s8mkA3h+9Lt/pWI340A5+SK9m
	 cTcxLzprtK03JZmZfKfs5GPfNdNoU3aZGDQ7rH2HWdKXQ7K/7+moeYfpQGi9X6w1hg
	 6clqmWt70ITmQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.30; helo=sonic307-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=SdrxH7UO; dkim-atps=neutral
Received: from sonic307-54.consmr.mail.gq1.yahoo.com
 (sonic307-54.consmr.mail.gq1.yahoo.com [98.137.64.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D2v583ZT7zDqLJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Dec 2020 17:28:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1608964081; bh=Gal06hkUjwE422zqP0MAJus47qtKCvjk/c5XKW7FIdk=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=SdrxH7UOjau6/2VGdRRZn0jXtSInqQNM7ZETEcNx9WAKS/v9j8Ig7da0oVG4ooAC5eAmsk4xUKe8zZgXFsnlPQR98Nl8o7PaMCU3BaRvyiOfkQK+Myxd9qvA/7AZKl/VVMb13GzlPPuXa9+1VIHMP1oUG7RYqxY9C4nJVvcr22uNwcv6O/8fviJMEfYPF6KurdDHih3iUd4Ttx4Vzt6wvI6QGgEX99FEi9pI1ve4YsIcfNpmZCGtO83DnIpjtwFLPbvC5j9IVeiGQNIz6U0IahGqdI7rm+ZPfYeZDVTlf4+zYv+GkewwNk1Iuu+wHfWGtYP7x8PQmtQbBlp6JCOhMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1608964081; bh=O62fON4aiHBw6vUZLVgvAW6pqUkkCGoGSq0zaX9TeJQ=;
 h=From:To:Subject:Date:From:Subject;
 b=ihbPT9/fo0qiPsBHxkK1aMqGlLFB6Lu+1KSgddhPgnY2LhLMH2GDUMOFqHs0J5rCsJvkjM+pIRsmLwzbUJm0PNtHFzrieAghJvoT+e+qZJQ6aiXozg+gH8xfhEtR9kbCNwXEaCw10hOaygouDrQFsA2xoOb9V7/ypGXsUVFZiQlVfseJLmByBObDY2VBMR4m2Pu3TilzmfxS0KHeD+++BsXkylY5cC4Y8eon44ZoXQCr81ndy/aGrcwC0HRLwOMKoL6/pi/gdzILIZmIXJKe9hKnXas6EMk0Y5LI0Z6C6uVpsr6NzcXoCcjzebXJhniambgpY9NZvmxi9USDnP/FRA==
X-YMail-OSG: HtS1OZcVM1lcA8qILS1otuFE_6eRRy0BaSjbGpJ0Fyq9bS3W.XEtfFe5Q6trcJq
 v30nEChRd2mexIg6q6WJwrT.yiaRLy2.kKfpbnk0xuDPFqzteSOPUreBL1EgeGXKQCuixcoBE9Fe
 xWHj3Wr9B6HyxKV99SWZIcvgNgida8WPXWwby1Ggxz53KGYJc3TH5yL8.2jJt3ps7MthaoSDkmoY
 citpKW90FydJbzcTHxAU3mRjuGE189s9Btoyi_DPaiWUmfFw.Q_DkjEkGd7gR_TgWJ.AO12OMzKz
 q2Dd9q11ScJ8TNQ8S6blxz2txecIMWrQrTZCxj8IAD7YIln5E_TsvI7Uuynj_YSg1KRf_fWXIfpn
 qbOKloR82s2edcNFZzrwQQ4f6HhLa4IU4Mo.0C3lcdRvkor34Z69ZHMbt8.jpQZMfo_xXJn1Xy85
 GYHlhPMKPAyVjver11zdVcgJyULmMDU9HRexxqF4C7r7OI.2WkD0wL83gHUAw2ceJdAh2tRPCmUx
 Aoe9gQRBNSKn0OJ8hqr2c29puNI.4B4OBTvWvDOqSRCkWpPLDHEDNS5LUDl5sq09wNHHy2S8Pnoo
 L0czS71hmSUnWEHlA0H2Q_b8UcVfbgWKa4ckmEYum3nuMBGt9bqycd1yJMUqmymKYc7.bVtXDR7v
 YTRwYczw0BjCHcebBTB00fmBCSXzyZd6CBaQYEDjbnt2rT31IUfeqd75kaixY8BD20F95HWwPf6f
 a4Z7rqf6iGrepV.PB_rKrT_gqRq0zonj2r6arcGCfOcUUD4qQ7u5V3OsZfE.M6j66E2zjmZLWdu0
 dyR7.GpMu1FOqZhcUM3O9HZxnLoRrms63YfKg5IHlPb5Cd6JMyD2krFQM5J8frqeSmgV4niZF.p0
 HDJCQRhcT4eUYfo.bNt_05AsQThf.l4jfdD13Gpn.jLcAJtCu8lxzqera2bQBi1_xxxd0s0BVnVj
 Yba.S92unHi1rCLgUh5i6QipDTKM95CkUn_A9D2oU4COvXW9Eg8aYPSx2kVwPhlgKJqZDMMKzYor
 BmZ3fRaV6Pu3bkKDO8dl4ZDwuKl9WrX8qQ62cPRpltT1lXDCJIaBZcP4cyL.yBMaN9qF9q_C8msL
 hXwlsMn6tJ_X59EXwz2Ucr2Yo9fap4AmPpZHc4nGN5f1ItV24ui036mdkBZLcwUkT93GG8JRcIN6
 XW8SpL8MFpMK1eirsSHX3YOaol7vAky4cYgpVzRS2kofrWx2ECw0C8gEy_FUXWKGvM1HwEKdk3rm
 WUh.gIjhPTdqkD62H0DWl9RfdeS09g.vLPY3uiuae5Nbpx8D0fyIy2bhkZUTrs3093nOOQHGCQDu
 Jqv2igcv5MBpwVTemKcXx7RkCh_Bx8z717ftrVGe.RYySnUM.v5sSuY8cOMkioaljI26gstLGZL6
 MwtuI2lMNWnq7CFZmn3Yjg7SKSBfs89Ygw.KBeUD99uU3KCDR1QDSAiKF3S7Ih8uArytUOj..Kp.
 fhIq0cLqsaFOvG4GBjR43oOGTkXs.QRk1cKdJhTcK6Cra8b40_qvV6VyIWdf2yvlmpHnVO5BBzIm
 nunLb2rvZttyf_9GTZ7bVYKwPdas324LOPIFY893nEQCKNll3ANZrPmcqVkEcCbb9fftjk03Gmh3
 pXbTOKOBxRXMJlCwmD9P9OUgmr7A3T2tNErOfY81Igf6Ho2Mz9bTRJw5SY.CoDdvfL6arlYF.y9P
 GPvh1glMf7nYygahl9U.Sj.XPY7f2ZypcZrhBc6Oi00C3chDPOaU_DBF4KIHqFqI5242AnvL.Id6
 bbjWyPfZp9GpFmSVHHd0bbeuXhVYZ1Ju5sjQHi7m66UMJs.8H7vAovOaKAjRHh9OPEkj04P6EKTg
 MViFQdY4ljQVY6pUY2qGhgLSN0EpNy5j1ml02oV530K5SiJwTnVxpI4KHOC1MOwFJGmO_3DMFmu.
 2u7GQlft57f00FFzUagZHYvbnK0JoAgWCjIHa3Zs8.ema2joxG1MKtj83OkZvNeKNdglOLCxcP4z
 UZFsEhIfAD_l6lmRjgLckLEuidw7DhsApKU_mm9_mJPkCIlfxYEpSAujkZD6dvK4Dawl8.mroAg4
 _PdATHFwbJhNl0V5BeeVDK4WySLxuIULnaR.ADbM2pQ0Gw9qehF80S0xuI51PpMVobje5jstKLcO
 zndiuT21jueb7UxQv6CxXNNFCUiEgk_kUR20OiOk5uRJNRHVXFycRWR0_r4GRGyq8pMd4N4MYlXL
 98rXnhuoz2h9OJal.YYnWjW9jxFxr_ayiz67ISempoAQu_p39Kb2jgpVDUQaHwgbVdqMUCzpDWRr
 73wlmtbNL.rvfLNDqyB8Zz0RhN93Fd6OaA4.vOnb41LharjknSv1Avl1BHN0KVXTvCh8zoC9Xn7a
 OJBd70Ed9meSTB1ostHfNKz7vccJAlTf8zDMRPLtTNNxmwPC27VRx1TsxGUOGOEFRi2S7FaXcSX7
 KobgutIBWen8iJ2qumzkcMgm46_rJB.8Vfh.Wxi82gExQv39224poCx1I24AwKKDaIrE9FBqfBWu
 Urcu40oM6bOdvt8ycTc_4_eOzXqxL2xnrSaWCumRasF9REpjTQH.YsQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sat, 26 Dec 2020 06:28:01 +0000
Received: by smtp403.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID c92d10730ff2cb3e80741da0025cbc69; 
 Sat, 26 Dec 2020 06:27:58 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Yue Hu <zbestahu@gmail.com>,
 Huang Jianan <huangjianan@oppo.com>, Li Guifu <bluce.lee@aliyun.com>
Subject: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
Date: Sat, 26 Dec 2020 14:27:36 +0800
Message-Id: <20201226062736.29920-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201226062736.29920-1-hsiangkao.ref@aol.com>
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
Cc: Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

"failed to find [%s] in canned fs_config" was observed by using
"--fs-config-file" option as reported by Yue Hu [1].

The root cause was that the mountpoint prefix to subdirectories is
also needed if "--mount-point" presents. However, such prefix cannot
be added by just using erofs_fspath().

One exception is that the root directory itself needs to be handled
specially for canned fs_config. For such case, the prefix of the root
directory has to be dropped instead.

[1] https://lkml.kernel.org/r/20201222020430.12512-1-zbestahu@gmail.com

Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
Reported-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
Hi Yue, Jianan,

I've verified cuttlefish booting with success, It'd be better to
verify this patchset on your sides. Please kingly leave "Tested-by:"
if possible.

Hi Guifu,
Could you also review this patch ? This needs to be included in
the upcoming v1.2.1 as well...

Thanks,
Gao Xiang

 lib/inode.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0c4839dc7152..f88966d26fce 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	/* filesystem_config does not preserve file type bits */
 	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
 	unsigned int uid = 0, gid = 0, mode = 0;
-	char *fspath;
+	const char *fspath;
+	char *decorated = NULL;
 
 	inode->capabilities = 0;
+	if (!cfg.fs_config_file && !cfg.mount_point)
+		return 0;
+
+	if (!cfg.mount_point ||
+	/* have to drop the mountpoint for rootdir of canned fsconfig */
+	    (cfg.fs_config_file && IS_ROOT(inode))) {
+		fspath = erofs_fspath(path);
+	} else {
+		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
+			     erofs_fspath(path)) <= 0)
+			return -ENOMEM;
+		fspath = decorated;
+	}
+
 	if (cfg.fs_config_file)
-		canned_fs_config(erofs_fspath(path),
+		canned_fs_config(fspath,
 				 S_ISDIR(st->st_mode),
 				 cfg.target_out_path,
 				 &uid, &gid, &mode, &inode->capabilities);
-	else if (cfg.mount_point) {
-		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
-			     erofs_fspath(path)) <= 0)
-			return -ENOMEM;
-
+	else
 		fs_config(fspath, S_ISDIR(st->st_mode),
 			  cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
-		free(fspath);
-	}
-	st->st_uid = uid;
-	st->st_gid = gid;
-	st->st_mode = mode | stat_file_type_mask;
 
 	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
 		  "capabilities = 0x%" PRIx64 "\n",
-		  erofs_fspath(path),
-		  mode, uid, gid, inode->capabilities);
+		  fspath, mode, uid, gid, inode->capabilities);
+
+	if (decorated)
+		free(decorated);
+	st->st_uid = uid;
+	st->st_gid = gid;
+	st->st_mode = mode | stat_file_type_mask;
 	return 0;
 }
 #else
-- 
2.24.0

