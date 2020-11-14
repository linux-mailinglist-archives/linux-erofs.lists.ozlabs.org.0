Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58C2B2FA7
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP176ZDrzDqSB
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378379;
	bh=9N3hRGjT1zfqMfjuR5GAMqYHIRzcqQ1NY1ePj+Sb13M=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gw28B6xyLrRJJUrEWCBzbOum1YICa8ohM4mUQTWI7mJQoxGAQUQCXbEARwsiBWaAl
	 mXNrUj6Tp45fCCr6O+Wrr9+DK3UjG2eXyVxy1cUDJGQ2iL4Ks0J8GdsyaTzKt7UN75
	 ybL5EcogCrVwP5V2KgpTro7RrabOAHWzm+kpMgFevRJyKuAsIcFwLnb3fYBxy0E8Pd
	 gxWWpJwjolVh/IIj2lfj9sQ/g8qu0EVghUmkEWGRR8FqJ8W1RHpX0h1wj4FFiojw1P
	 JxhdIFDjtAQaV4tXl1gbQc/exb81Ykqx6DCp8FMATEsjDrngv3NjNnL/qkRV+aesNk
	 /vNnHrsslrLIQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.83; helo=sonic314-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=MURmarhC; dkim-atps=neutral
Received: from sonic314-20.consmr.mail.gq1.yahoo.com
 (sonic314-20.consmr.mail.gq1.yahoo.com [98.137.69.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP0f4hhdzDqRr
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:25:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378350; bh=p4Ehg8rautfdjPFgytInyV1xnjif74I/pFavFvvLkxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=MURmarhCBjwE57TsPSW/QJdobL41YbucEMjKckxLJHD+XRV7/K0/MCF7excVLtGFyzw5q5PAO0P0Y3vjbmNYm/SubOk84nlq4+Ey0mtKRhDwPRHWbPjo2BpZj/EFsyTEzDL2JKDDO6M3+5sBYzkDADh+VlVSywYDLavRTzsYaF2numaaxX4FFxNzDy9ylRhEJ//W4NZmBLYY24sJ3ieHGHLuY1a/k0A16UHH13QQ+Dj/PP/X793TUeVyDyUCZip+lIRFxnTr0MrWrjr4Vq5NkponBgsoD0uHe5ixbNfgjNGSCw61+ef69oNSX6XM+PXpyib2AF48J7aMYSGTRQg2gA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378350; bh=90lIXtHg9bQBmp/tEh4w+wqtWEOineqmtDS5/R9Ki5q=;
 h=From:To:Subject:Date:From:Subject;
 b=oCMgKqYnq6lrshZBYqQR6oz/MdDyVCU4kP3l0JL73m0moDIfyjSf9PlwnlZ5gpmxAO4bEGH0J1jTLlCOMXVpxyFKmKAZd9B4yoh+96pQeiMj5EYmNKIYwEf1eHSsmikf5NJoNjw2G6lL84tQnpA91XWhRywB/s5sjHnq6G0jMWztaRjUlj3ihMHdCLZumjwunHL4CREsKHJHM3pLT+FkHMRdtHFeil//1zZNQOytAldIRci3EsC8qdrp6tGyp7x+lkls37mcsVl2IBSwVPaQjFouyUt8q/yKQnnimB01kbJy9BfYtqJgFfg/UrTnAaVt0rBWiTJyK+SUwZdeDsR+ug==
X-YMail-OSG: r3RcA4gVM1lKqObbW14IbphB1ApP7Wf1Rh6aeT8zNtotRf1kqmaP9UTq7RFkmLI
 6QPC_.t8J24jhqqRt0SF5XqfAMN1Lm7gGaI9Z5psdaniYrFzDoxCIKXCeP.5EcgwljJSRxbDgImh
 d6YX_XRSO3k4V3XbJjjW7PpBzeuRg5Ebl.PAacxdgIWToK6fwMolSwdZ0w727UH4pxtchF0c4CqW
 7IrVxUWpCYHCI1KX0nQ1VPHoNXJ7X_vgoQgYAFF6YW8CwhnsTGuL1TNVrPFcu7HU2SP.KnWCFpmK
 WTdyvkEy__45.wgIyu13hQ524nKitYec.IgkjKxNXcp8XVDF_wvMHWaoBfyWjsZQunGuGdqggqr8
 k7O13LQdvmdxbjnV479UY597iqZDc_yXRj_GbR9XPfCZa3l41HJmI8zvAJVUT4dCMpIk6nngTXyk
 UMzM.rX7Z4MfXcu0opwOtn.zmBBCJXtCDF33q.2AqSyerA5m5F1KcDnB9U7LluKKRmaQ5ptfWeL3
 jwPCFHBgmz9A8910jOj6VXMk0EGb_glqQO1O3R8G.M.hFIvd1Nsed0OrPRG3ynZ38MxcW7rssfCH
 mhJrb7mJqdg3bsmFaTGYyM.jw8uWupHyZ2Dy2gpqM5FxqixZoHUUjPD831DUfQeUOv5EXu3JhLo0
 HbAQLm319HpnMsUiWFVztZUh3OcTDP91z3UV7Psgmxc3fA.isapc_ohgO76Kw7ZKvAbFHcsSCyEr
 7rHKqIxwZ4xidSBpJ6NVtFMxgzZCvffH6QOcoZGAYts_wDITNvlRwDjha3w6NSRRuGGXqF3ZgcgT
 mVF0oMoznv02Cb0A9g44spQ6v2kCUORYD8QeXaqWuPav2iQim_1HYErEVgSVcl42UggI5_Jan9a_
 Fxp_x_VwEjIN0Tvebt2YPnN.GpFRvEPIs.mcI8usI_9RfjEWZtrmPr5g_Dtvg.WZ0F4am_igwh05
 2XwgueAwMbanPvDf6xqx2GDYARF9KDFHFt.avxNg2rNl9LMfkMtVoOwGHEmU2vKNJP_vbpB6Zsji
 kkDJ5VtCnfK1Wkfp_ZRRRBMyeFap1.Rjiej_e1bgdc8WhOdDNeNIOTpkliEtR0DP3IFBT6JdFlpa
 lybwgpsgO2SMkqTam3y32JIxYs.nrUF4YbiRQiKyBEEZ2aquwkBzk7eU8qxfwVeSfigRHlcL3cfz
 CzfhanKTfUVgcyB44ZcRKPvuDNGof8nlbE.bHj7tMMJiQ5PlHrFU8nlmK0BMoCprnY62aZGabCvp
 qIfu7e8U4L7e8BuTVOQZE5n75kanac9k7J67uBWsC2i71hC5EaiXIKJ.4cqAJVZhyEz_AeMd6DOk
 UXQw2G4i48xQFFFqA1JtUeRpeJSsdJIzoZv3hhhNgdafBLRdQBbLHgZxc9yxihIsqzLTyP6SUaI9
 uiPHo_WmuLsT5nTF6dfaLp9DEhsOcaRwHaU.oYBMRmeSTbJ1Z5D_Gn4yXV.NdkKNvsa2CQFsDFG5
 Ue_aayoWvhKUrVXQCeZwBT5L6mI4vq19cNvVBabqrHi2yUtCs2x_AsyZBGLQKcsCxelrJgLXLzXg
 3sewveDtzL2pmInBFTFiBA137..N_Angk.dRFPQFliAW1kLfU0IEDnYLz7X5Un3iWyPudmF4M8wh
 so0haRP1ZF.tHsysjWjhPP7QRyx8XpQbZuPoKcjlFAl5BLwc.phWEEnTqQ4thI3GKfgNJirL1KaJ
 1PHD4b5FlFEkGQuZguN6LrOTlvkTnEs2gDNmnOBXln2Scy5LbkCEKT._Zud948fcTdb2gI.BO6Tu
 D9wKyQBJswwlRo0RBApDTFlHFtlKI5IhjjpBiYe2NlkGK7ZrbNKgxG7_.L5ccdFTymShD55LD4jD
 GAPtt.7psmoH9Kh0AHFgq5VWocl3LojZqTPpOB6my7.fg9osUJZbPky80A7sZ1_LVAs1LIF9e00O
 Nfm73dgPBUg6jswhiL8E3ghT5AJnNFvuYdcXJLmHjbTtA5AOEDrruVA18oV.kwjEs_0EZ_Fiqc8H
 IlHFG2uGPWmhx2T.oiaHvBdFrP5pXaFPp22UOezzyJTLtYe.Ffpb.OCrycslpLArtjBIgBCS.Qi1
 dresuOQtE.SXO2gCuktwXItM2CjGavIFWBH33tEQaCXx.R6EB6QNTb0TkZ4HDhg4QKzhRRRgAoei
 D6blUqAusy77y8ZCikMK6UO5YHOSdHPodtj04U.cXl9DJdIdwj1OCvanESV7iDxgGnL7ONF1Yz7.
 tC0hYnil6uUvw2HDe7vfmPW49tTGVPzkmwT1nRHbvDwbvQ5j.Y8YgQZeNXcJRWoe4ToNzEaXp0B7
 hqUg6wnFaeqO7IGdK1SVav7ebxh5Q21MWPRe5Kk8ijmKjY20jzpGYPdTwv_7iGH4M7R7FTYXqGx1
 5qlWw0RehQ2l_kNd9srR.Aeui6hV1swFKRZFd2nm8mSBvi3CgkMRsttzZBElokwM3u8KwZdq3dAe
 i7Strw4wpFH3hLefTaTF8QpqcEOf9z.1MDueV0l1RVWIJAVtvVeYiwAjy9AJLhiKkjELj7e0I4KM
 ZDwbms2YnchkvGuHhPjBvgBEh69RupyriJJfGP5liFLlu4ZrlY8O5YbACpHo1sNHdB1njIPJwm10
 WeByyntW01jI7FhNJDStkf6xtlZgoFIDNW2sD8dHVt3.EL241WUv_19rX2Vsp3V1Y2w5DKOjKwP2
 EfB7TfnlDETr_3iCbJSWMUlKGhAoAu_rIYycsGZAYTo2d.6pH9a._D.jpJf_WWJ3E_yFOWF1QbZ5
 y0s598wD0W3954AUqaxD23NzPWzO.ERVTqwMQ_H6UTZ3RVbQjz1brJdLx7yRjHt64nb8P.YRRWg-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:25:50 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:25:44 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 02/12] erofs-utils: fuse: add special file support
Date: Sun, 15 Nov 2020 02:25:07 +0800
Message-Id: <20201114182517.9738-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201114182517.9738-1-hsiangkao@aol.com>
References: <20201114182517.9738-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c              |  2 ++
 fuse/namei.c             | 14 ++++++++++----
 fuse/read.c              | 26 ++++++++++++++++++++++++++
 fuse/read.h              |  1 +
 include/erofs/internal.h |  1 +
 5 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 5121e8325f32..563b2c378952 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -146,6 +146,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
 	stbuf->st_uid = v.i_uid;
 	stbuf->st_gid = v.i_gid;
+	stbuf->st_rdev = v.i_rdev;
 	stbuf->st_atime = sbi.build_time;
 	stbuf->st_mtime = sbi.build_time;
 	stbuf->st_ctime = sbi.build_time;
@@ -153,6 +154,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 }
 
 static struct fuse_operations erofs_ops = {
+	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
 	.readdir = erofs_readdir,
 	.open = erofs_open,
diff --git a/fuse/namei.c b/fuse/namei.c
index cd747ad1be56..e79e77d1e3c9 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 
 #include "erofs/defs.h"
 #include "erofs/print.h"
@@ -37,6 +38,13 @@ static uint8_t get_path_token_len(const char *path)
 	return len;
 }
 
+static inline dev_t new_decode_dev(u32 dev)
+{
+	unsigned major = (dev & 0xfff00) >> 8;
+	unsigned minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+	return makedev(major, minor);
+}
+
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
 	int ret;
@@ -63,13 +71,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFBLK:
 	case S_IFCHR:
-		/* fixme: add special devices support
-		 * vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		 */
+		vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
-		/*fixme: vi->i_rdev = 0; */
+		vi->i_rdev = 0;
 		break;
 	case S_IFREG:
 	case S_IFLNK:
diff --git a/fuse/read.c b/fuse/read.c
index 446e0837cbc4..a55c0f2f78cd 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -70,3 +70,29 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	}
 }
 
+int erofs_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret;
+	erofs_nid_t nid;
+	size_t lnksz;
+	struct erofs_vnode v;
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	lnksz = min((size_t)v.i_size, size - 1);
+
+	ret = erofs_read(path, buffer, lnksz, 0, NULL);
+	buffer[lnksz] = '\0';
+	if (ret != (int)lnksz)
+		return ret;
+
+	erofs_info("path:%s link=%s size=%llu", path, buffer, (unsigned long long)lnksz);
+	return 0;
+}
+
diff --git a/fuse/read.h b/fuse/read.h
index 3f4af1495510..e901c607dc91 100644
--- a/fuse/read.h
+++ b/fuse/read.h
@@ -12,5 +12,6 @@
 
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	    struct fuse_file_info *fi);
+int erofs_readlink(const char *path, char *buffer, size_t size);
 
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f9e757316efe..77fa8d82c746 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -168,6 +168,7 @@ struct erofs_vnode {
 	uint16_t i_uid;
 	uint16_t i_gid;
 	uint16_t i_nlink;
+	uint32_t i_rdev;
 
 	/* if file is inline read inline data witch inode */
 	char *idata;
-- 
2.24.0

