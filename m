Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 020332B2FAE
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:27:12 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP252N0mzDqSF
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:27:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378429;
	bh=7HKT1V/W1p/Irj2nlgjG73rOLJNFHwoj2gi+hTid/E8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YIP4Z9MgD/QW9yAy9pm3sSwewxpOzXKHW3hlpKMc6AK2VJp5YUh2CS10Fkm2Z0tMk
	 K+B1t3vKXGX3L0Dappmy/g2cIRJ4PKQFQ09UoASyeU0L80ctFaZ+Iv3YnTq/NJg+tf
	 A4/Fa4O0gB/s+D9HpCCUYvh40Fgt3MnSIYBXvwTO/QIOmxcy9ajTnfZFsryR+oDwmx
	 elTqXo8zcZ64I6GMoXLiQLc+/F68SvDEUZbd4z3UoHGVmcg0itrVPDKrULE6NwFYaB
	 lpvnYG+MqpuhVxGtS5091NKdNIIShGo+NX46c+a7ky7LuHDa6GawOXfB1FmKPZq81Z
	 C86vuk2+FkzhQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.205; helo=sonic312-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Xfc/5CYl; dkim-atps=neutral
Received: from sonic312-24.consmr.mail.gq1.yahoo.com
 (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP1R1jXtzDqS0
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378393; bh=JiZKv6ScXhz+9IalCSEEtgVXTfxgZBhvcfQZXHS7QXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Xfc/5CYlF4RxB8LGehdfHFOnS1kTSWYcP16JeWPJ4RZlS7RBUtaUxHKq06DoTevGPztHbF2h7HcRDCkxtIb2zhYQlPHW2RBanYl1mk7coKLXA8uv9fzSqtdTzq6zf2KlAa7546qH0PhbIEgVsO2UDnRJcwvqy7s/qSndKFEGCW5yE/S7OKsukha90ybMLGdqEmuVc4znk9eKld2hUWg5UVkzoBfePm4BR2lo+h0KBvKbW6ImiWE6z8YAln9OPoJYjuF5IwIxh3cmTUxyusTJFIvIY76aZiS+qRX2SiZDV25YVa5HxV8zKbO1on8qaz90HREScbkttXxhsLTlT4raYw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378393; bh=QYPl0a3RPkQJlJLOpxlG1KJFuYfCyNIPQWBYx/Jq2n7=;
 h=From:To:Subject:Date:From:Subject;
 b=Ak9Ijxrq+6rDOYlfBoUMBkKvvCipLhsHn/ryhfElTzjkTySKP/N9B7nKOAlUslqOgGWRfWqM7uxkBOosTRn33YuPxMQSyNgzA+6WKR5G8G5EyrEqMzZLIHmWLOy8Dsc9q/4fvMKe2ZKs1C7wlk3y3FnHsxGwLa2/oG3CG3X0c1OBUL0XLld7xf3i2f5m0UC+WGoRxGxPYrBNP/AcUGD1eUZsRef/IdtRQQgarJ+8W9Iv9K8R56p1RROKuMKkadu7oWL/Y1kJXwacHyDliua7k7N1aRz5YW9zRP1bmLlMxkd8mF9BJ/FvcHeQ5VWjYRcLD0TK1/1olSkEnQV9XPJ6/A==
X-YMail-OSG: WR76SEkVM1mcFmKYzLNLjmoNFGfi89heRHwV0p0YFiTJV8En9czLMvtfe4CjMG_
 9bUht8q_n62hjBnH0aaBzuSspmEbFA7zcpoe4.avOLkm0pGnK3AtUSj33RZOCGj4QnC15Vg7ihm0
 F2yQb_0QHe.y_hX2dYr_E2m.Yu4.H8uEjNOIGLybjrdnMGH7JyFGpGJjlaqaqmK__.8zCqdHm.Qi
 yCWnQ4HB502on0A65D2AbrrAXW.sOSyxITAh1xO.wIOVSdLpC.P8iTZYUxvL4pgG4Y_HwCETEmx7
 blkX6q9QRuXbX1CjAxBPq6yXHeVaAprM5OChpLgrL7eC.46hUVNCxY6tb399V1t8C2WoJZtmBP9q
 RR4Lqn55nhrxXr2CezzkmHAzRNZgeaSVfVjz29iP.R6agR64s2W4IHmz6RWrhHcgtZH4DHIBkHKB
 Vui0d7shK2rHM8B0BOHdTqFKIftRcaJckc2wlRE2ajW0EmKvG6Rss89volbTd4f5W0rQj_MieoXm
 0zKkBOLUP0iTq8l4VL1sLFGYYn4wuc19ADKxjW2jVzgBVQap_AFp_LwZWfaa9VTgU.F_6oz2tGKD
 MZ5GEbpKfKiH4o2UV_SZq6QDqdTpdG74Y.KUfut..gVwfCisqTA55oulPacQ2eaX5l2Uz8SpHAGj
 IsO2V1pOip89W7dH7KC0rfH8pK5d8EkF0ptB2poVIGu_xAbipPc_IM93AWmZ_4L_w2_i56O.sm_r
 NOhi_Rdq75O0mE1VCzWQPJ9kIAfCRqJfHiSqLWpWE_HTnL0M3rsJYancCdYkBSiSwxjZ5eCwSfyv
 XjtsH5aeguQDF0YBuPX0tV9H.EqXQUR5kgkMMD1Zc1LcUJLBhv3A5336a9lyDFaKi4yqH9RTwQ9E
 8eqHCk6UqouIXuEcB2qt9OHqLQcQ3wt6JZSDBqMVUuZWOI32zdx6lkRPe4.DR4LOriFUhe7wuIE9
 GezkxSXLU_f78_dH6sXMub6h.jKlDCuvMUNEwFNiHA5bdadMHvyWvhjx5WLz.dRqWwkf39DOAeYm
 8RVommUduZZbnDb9C8KroT8Pm0L.PIOaGKannskoe1Zsv.wxrRNnoRIvIvJ8a4VyBUyV9vEEFVMu
 90icEr2m01kMfP86Yd7RHmz7Gid.PewhLC0RT955rGwbUiaep2P_bc9IgWxquAD7g8uHO7blvQ2U
 ARMHPqW9TzAo46Uoz27rMaPB8URGwnjYCcYxE_rmju3dLdYFsR2xsinUI2e_DM5t6q9iL4Ck8dWi
 yTegH0C68FvIhd4ZGVYs.BMUeVdaQpPRJN3TyYpmVKLZptw86WZSbDcs_Oy5g5QlvaR4eSUO8CXw
 2D3ZZCAo31gV7cjXMYEayHMU6kvksFbVLqoWXfbZ4kIXXY_iunvGefTCdKZGh0p89Z61.0m31gRt
 vZdPA36irliLjkhWovaJiHuStzBonzQN0PhGzV6AKvViWI0XwwT9rfN0a2JMiYAmbYTi.UIZh_3w
 InUru924esWL5Ha6rcksWDftn4jO3irXzkyZopMGs3v52hn.YJ1pFJgERUAnzP8IKeTFHA5h3NTz
 yW.urFBJfBNZPwzvXLvpoma6kh3qnYMI8603APVhngZsPm07iXiPWkhiIEGnp5rEu0iYP3MnGCTm
 XDOv5Nvgof.zevhE.i9dXgOT2INrYaNH75MOWxge4xambX2UYeKUf_X2f6lnvRaKcFGdKIVZGI9z
 WxdwvBjQO6hujwkC65NJao247iNAkmoukIiCCj4ZFYtM0yjXLVGQFBb9fJbqUllUIMW30sIlNIiS
 2gmaahD4axeFI7dNtfwgYKx98ix4a06Ck6h9JaOXMJqSaWIJ5AueqDWTBdipynfgHJmYixao3nbf
 G41Rz.9b1oWDpcIk2.L9bXp_YFQEUBjs5ZJ02k66k.47bS4CaKmlVbE.Yj_v8buacUWUJKsbY0zO
 hoUoRNJlgpQIOHwUbcc7piLL_b5G0jD8SFlXDP1KYA_ESK0zK6gHUStC11uSWTfmY6tZJG_zdE0T
 98zqLc3jvbrjn46x9aHczZoR2QFkq6oBHa2VYfIqse24Oy6pYil9hWu.CeXvr2H4O.kAZ6.c_0rm
 GhIa0Nqt9qTz8oIdcT8HbLikynZzD8HMBTgICL.zFg6S.kGVpheph2H9M9akOWK2WPcT.kfGXVVq
 MNCEYJkTyTVPpLVonohdE6ScdUDNJ4ZrwjNxPrsQR0IOvosYD_28aD7wu_irOQaXY7S26GIe8ept
 OSo.qx5lChKcG_wZeM0PXOw8wQcxA22jnDuoFweSS_rNglv88OUoojrwQwPSqST10.5VzHvSEw55
 aC.5INq91Dra95LYY7Wf4P8csZnoBJZ.OvzsQaTWloFMtq6BcA6VSuPbnQr2Z6X23EGAnq5zPLjw
 G96Deur2VsCJfO_he4sW0JmOASlW4UBqaYf.R5vIKkjk5DjY60QHvUyIJiEhuJAy3i5Wn7foFfS2
 CMt95ki4edPtzBce8HaHRdvTzb_I3dl9UKreDsYeJLvqV1k2d0ab.apED55Ta5r_qHU8h9pUU2Qk
 ZBIFLf1nWEaddhnnK_WX_zpDgzmfOPUVbAMKXf98.CvtHQ2lz6HlozEQEO5QGTX_DUR8hc7zHQ3g
 429.1BlWm0yefpR9_Av_tnGFwyhiviotTfzqcGhRqffKqBG2Sw0UMBZoKvK1ydvx.R9ISR7Lvu_V
 vBO0E1TVqNz5YDYYiGx5fmAQNOl00QPdLN3jH_OI-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:26:33 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:26:25 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 09/12] erofs-utils: fuse: clean up readdir
Date: Sun, 15 Nov 2020 02:25:14 +0800
Message-Id: <20201114182517.9738-10-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c   |   2 +-
 fuse/readir.c | 155 +++++++++++++++++++++++---------------------------
 fuse/readir.h |   4 +-
 3 files changed, 74 insertions(+), 87 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 9ac8149c88d9..a4b7a3692c19 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -182,7 +182,7 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
 static struct fuse_operations erofs_ops = {
 	.readlink = erofsfuse_readlink,
 	.getattr = erofs_getattr,
-	.readdir = erofs_readdir,
+	.readdir = erofsfuse_readdir,
 	.open = erofs_open,
 	.read = erofsfuse_read,
 	.init = erofs_init,
diff --git a/fuse/readir.c b/fuse/readir.c
index a405dd702d84..2e90c95c38aa 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -4,114 +4,101 @@
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-#include "readir.h"
-#include <errno.h>
-#include <linux/fs.h>
-#include <sys/stat.h>
+#include <fuse.h>
+#include <fuse_opt.h>
 
-#include "erofs/defs.h"
 #include "erofs/internal.h"
-#include "erofs_fs.h"
-#include "erofs/io.h"
 #include "erofs/print.h"
 
-erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name,
-			uint32_t dirend)
+static int erofs_fill_dentries(struct erofs_inode *dir,
+			       fuse_fill_dir_t filler, void *buf,
+			       void *dblk, unsigned int nameoff,
+			       unsigned int maxsize)
 {
-	struct erofs_dirent *de = (struct erofs_dirent *)(entry + ofs);
-	uint16_t nameoff = le16_to_cpu(de->nameoff);
-	const char *de_name = entry + nameoff;
-	uint32_t de_namelen;
-
-	if ((void *)(de + 1) >= (void *)end)
-		de_namelen = strnlen(de_name, dirend - nameoff);
-	else
-		de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
-
-	memcpy(name, de_name, de_namelen);
-	name[de_namelen] = '\0';
-	return le64_to_cpu(de->nid);
-}
-
-int fill_dir(char *entrybuf, fuse_fill_dir_t filler, void *buf,
-	     uint32_t dirend)
-{
-	uint32_t ofs;
-	uint16_t nameoff;
-	char *end;
-	char name[EROFS_BLKSIZ];
-
-	nameoff = le16_to_cpu(((struct erofs_dirent *)entrybuf)->nameoff);
-	end = entrybuf + nameoff;
-	ofs = 0;
-	while (ofs < nameoff) {
-		(void)split_entry(entrybuf, ofs, end, name, dirend);
-		filler(buf, name, NULL, 0);
-		ofs += sizeof(struct erofs_dirent);
+	struct erofs_dirent *de = dblk;
+	const struct erofs_dirent *end = dblk + nameoff;
+	char namebuf[EROFS_NAME_LEN];
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dblk + nameoff;
+
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* a corrupted entry is found */
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent @ nid %llu", dir->nid | 0ULL);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+
+		memcpy(namebuf, de_name, de_namelen);
+		namebuf[de_namelen] = '\0';
+
+		filler(buf, namebuf, NULL, 0);
+		++de;
 	}
-
 	return 0;
 }
 
-/** Function to add an entry in a readdir() operation
- *
- * @param buf the buffer passed to the readdir() operation
- * @param name the file name of the directory entry
- * @param stat file attributes, can be NULL
- * @param off offset of the next entry or zero
- * @return 1 if buffer is full, zero otherwise
- */
-int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
-		  off_t offset, struct fuse_file_info *fi)
+int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi)
 {
 	int ret;
-	struct erofs_inode v;
-	char dirsbuf[EROFS_BLKSIZ];
-	uint32_t dir_nr, dir_off, nr_cnt;
+	struct erofs_inode dir;
+	char dblk[EROFS_BLKSIZ];
+	erofs_off_t pos;
 
 	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 	UNUSED(fi);
 
-	ret = erofs_ilookup(path, &v);
+	ret = erofs_ilookup(path, &dir);
 	if (ret)
 		return ret;
 
-	erofs_dbg("path=%s nid = %llu", path, v.nid | 0ULL);
+	erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
 
-	if (!S_ISDIR(v.i_mode))
+	if (!S_ISDIR(dir.i_mode))
 		return -ENOTDIR;
 
-	if (!v.i_size)
+	if (!dir.i_size)
 		return 0;
 
-	dir_nr = erofs_blknr(v.i_size);
-	dir_off = erofs_blkoff(v.i_size);
-	nr_cnt = 0;
-
-	erofs_dbg("dir_size=%llu dir_nr = %u dir_off=%u",
-		  v.i_size | 0ULL, dir_nr, dir_off);
-
-	while (nr_cnt < dir_nr) {
-		memset(dirsbuf, 0, sizeof(dirsbuf));
-		ret = blk_read(dirsbuf, v.u.i_blkaddr + nr_cnt, 1);
-		if (ret < 0)
-			return -EIO;
-		fill_dir(dirsbuf, filler, buf, EROFS_BLKSIZ);
-		++nr_cnt;
-	}
-
-	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
-		off_t addr;
-
-		addr = iloc(v.nid) + v.inode_isize + v.xattr_isize;
-
-		memset(dirsbuf, 0, sizeof(dirsbuf));
-		ret = dev_read(dirsbuf, addr, dir_off);
-		if (ret < 0)
-			return -EIO;
-		fill_dir(dirsbuf, filler, buf, dir_off);
+	pos = 0;
+	while (pos < dir.i_size) {
+		unsigned int nameoff, maxsize;
+		struct erofs_dirent *de;
+
+		maxsize = min_t(unsigned int, EROFS_BLKSIZ,
+				dir.i_size - pos);
+		ret = erofs_pread(&dir, dblk, maxsize, pos);
+		if (ret)
+			return ret;
+
+		de = (struct erofs_dirent *)dblk;
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, dir.nid | 0ULL);
+			ret = -EFSCORRUPTED;
+			break;
+		}
+
+		ret = erofs_fill_dentries(&dir, filler, buf,
+					  dblk, nameoff, maxsize);
+		if (ret)
+			break;
+		pos += maxsize;
 	}
-
 	return 0;
 }
 
diff --git a/fuse/readir.h b/fuse/readir.h
index ee2ab8bdd0f0..16b878fe9f29 100644
--- a/fuse/readir.h
+++ b/fuse/readir.h
@@ -10,8 +10,8 @@
 #include <fuse.h>
 #include <fuse_opt.h>
 
-int erofs_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
-	       off_t offset, struct fuse_file_info *fi);
+int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi);
 
 
 #endif
-- 
2.24.0

