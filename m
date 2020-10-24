Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0254297D22
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 17:27:59 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJQ3066mtzDqv4
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 02:27:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603553276;
	bh=36CU3XuA2/9owtiDWZ6Zn1y7509Af/1+cv1EsIOv66o=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Q/tDOOG9GmD53j3Wy4W3xlfRSOom3fWkL/EQ5lceoOY4EbYBlkz9aMSj00MJGSjWG
	 slvi56hGTuFOyU8uDnHs+CxAHWidO4I/u/D37Oep1OPx820PiY0PWbwPQFJH9PH6Tw
	 7vhgbVSCTI55tXTI/7OSUiJEfmaag12WdJ0xPvtTtnJBweVPWe7CGvzaVCqIWMWhIW
	 HYI2yJwlb2p3FwnedrQB1mSv2EAijFqIWyG7uQVCLRpSKY3T1lmDDSWBCN+tOzOKQm
	 CZMNPXvWsheK32N7XFAOtTgTwvNTPJf1W53uETMPwafHpCyBfZP5vo7wSHIpx4ookl
	 gA18frsKtAHGg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Uh9+bhaR; dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJQ2m1wJLzDqsx
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 02:27:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603553257; bh=GmRl2y7NEIP+toR+3MzRVKgaiCqOcA8i9RQnhw7xoZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Uh9+bhaR9YrVgaq9F921W9DBv+JaptFbt0YiFRfeJPrqD/cnwmrUgH9D9kPiY7i6nKQUnLJSgouNMf2HfNjPrs3P9+1mFcTaBuVpBI1MT80jdVfmuR21A4DIuIYYE28vmT5Rno9DplZe46Ni40Nr3L/WlXS1Ki0hL+q94ZU7XiwaBVdhI4GCMgM3am4GmvT6K9hqTXZL2o3q+rPiUrm0LCoqlFThaA6L0EMfV5yZLan/o8ytaA2cLYEi9R7Xw8kts9hgYTJF3bkRQQJUOGgj3lFoY/mra2m+I/7Ql/KzjoRyoJuqT3TaM/0tY9lwxfcSPZWoJRZP7lUiKqrSlpP/Ig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603553257; bh=whs1rO7FeT6W+D1kpw94Rjma17k3pJgOvPYNnkBemdW=;
 h=From:To:Subject:Date;
 b=tNEOhiZe1ZhycuL/iN8obFJv0xAicc1nh4EHY5ut+KQC0q+dayE2mwLTbmReHG0jqQBhLl/w9mHYa9ZqxwGoxAVkiyXBYgufV8gDLs2+DbC8+HYlIOm6ubsQRXtqnuSx0ziU166pRBZFD3qU0NfM0GMW+6LndCGfJaZ5UVGveOjk7nrpvqsozfVfWjGSxEPZxq8BmkreALdOuu51h0iLlWBhvjH/IY+FtWXgKfyDZYGcK1GwjwOCtXB9J5sC3wP6XIDNZ/xSS9QZ/poolxNW4/B6TILthLTkyU3YLyOXfuOkHCXYThoy1aeUUfOBLQBWdcO/uGnmr43gTju33eCLcg==
X-YMail-OSG: GuEjJlIVM1mJ.97RAGKZLDea6cnGVlv1SsPadEgDzhgJSQoZtFo3bzPMxrVQP1S
 WC1FwpnXG14OnY7tpr1FrubOd1Smbf567tjfEdRW46e385CVKCtFLXjcZgfw1jMQ05GUFzdtiaKc
 mulB5M77AVdWaYG0XKGE6KhXZ3wOMhx2Kmjlxayo0OYVLHyJuK7PifpKmi6bNOTV.BRYFbC7F2Vy
 EKFl2ZXaTNxuQvC_AgEX_vynUD.saf.JTSXOcIPZhRhHXLbAZZMjDRJzWkqBr0VVzGc1xRbk7pjz
 2VK7Vv2fhjJZK_5BUTn1quyZCfVtk1k9qULAQVHZXMzMSEZWunTuQ2FuC82uD6tX1hFK5zkR16Vf
 QF.sKL4gaRl_h1T3bCx9lESOLmO2nLVpdJcN01Sram9daFOEoaI.ZA1QwU5WpVwotlBiZTGNNV9q
 BNNMlCctJPgxcb2lbSuGoLJxZ6dJOxbkwQ61Kit2nIj2IZpwQ6h9ZJwSD8uWiS3khIdRXKv6FeVS
 FzJUgtB3DJC5Li1IuGMPOD_lwJV6YUV0X95Y8zyABY_VxMZlGt90khMgIBXRTwTRqJVoT5t3Y1Sa
 VQP9XgEUhHjr2FQn_J_uSFjBMJ.lrSg2yz_7FA..D.sKQgRzuXy0TCmODX0X8wxKbPxNDbkJXOAD
 EcNW91ODjfpLRF74GxmyQZAVo3bPVuolFJ7iClTDOZbYfHxizkCBLXA4sU_gPRxuiuQVYHriXGEn
 phpMZ4m9qVE96f2yWX.lblSERaxUT.DTCB4kjyJBeyH3pFCLSlb3tMKy_Xda4UvdSssxYW9ByA7F
 BxnOn15aluyfxi5BxS.9xWunYIhB2jnGpk3GD0XMxn_C08wBZ8KVRUmi9rwFJeRUXuphnd9xf52S
 VvpK.mGRnoQbwXqVd1dSjxqMt0l_XBf8Qo6V_uz7c5DkvFq2ryo1Q0DQ6P2xn9ix9lK8Vrk7uenC
 BhshBwKYy9gj7EYpM88WqQAaTjKEwEdI8HoZIDOd.WDm2s9186EWA8URloqFkI._3C3fa8uuInzN
 1XYT6BiAo7ZltZmQNzg0.kOxfzry16tCQnBDrij28OaiPvRcT6RpEq1ZZbQ9D6Xa2FiA4mspSH_p
 dl7BdqkHwFKxwNbaPScI9I1GeFegHmNNG9tLk47DQA5gMNIArkNdIIjQzi2VytgWgtlQHYQRooHR
 qc9Q5LM93DPuTiDLkPPTvGHL.Zija.8.v0S08RLxRA5edBX.Or9jVtXcccBbN4NMhbseITo8oRE0
 0C8_u9iGI7iUgLG5b10YbFoZ7XMIPK6dzQuQ8ziseAxf3Ly9aK.lkanFe.CrwuZx1D.W7bDhSumE
 rxXs73wDXJyMZdY7_3kX8LKwsZYHyEeH4pgl4IewRymZDRODEFJJYQlDqs182oplYpOBB_mTF6.H
 FTn5xmpVtkxJvhICU7MYobd25jy_tSpFbzg3tbmEgJidV.xoBHCwG4SSPZ2dZC383GWBRHJlk50H
 QwfFAZSCASjOKL1VPtrZlCN57TkIqp9HisTC8o2Twc212Ve4wJthC.1p.r4N3W8dPG9R2d__sFpA
 nJD5QF34feKiaO6uPG7nAS.N7xZ_uR3ls0H.L4Jmwn0SmFGnHGiggG2USwSIvokbHEWVjVhXqZsT
 Qf153gxjGZ17aGlCYkCgh_ED6U8vw81EZRs1omSp.hKnVgT4UwFGf.OEnxfymse.gfTDg2VrnIFP
 iiNDpS3YdntYuZhwRO7HCC_U4JZkaMuFxhRtbgSCNYsFIvEHxiCi9LF7OHdBFtxPpBJ7UW39IAGn
 6Pl9zTGtkDjkhcAcUHbe94ZUCF2oLQBxKORiThPklH6_fSStsY4CJPj7rQZhgYOptKdBmQ0ys8Gg
 DjHdHD9fag6a7qzdGF.8CnCwnV3s0Hnj22wkWnHTwR1KvufcUHbwOyiXxhvSNg8cJYSdkBQhRVQF
 qHejc5P7QViNffaZhyYhzgy1sOEGs8261GE_kzABqIW0CcxlHqzAPYwWb0IuFF47cgrctCDJ68On
 kEO3XKnhvwBxcpVCBe5WcoOCs_Jyvcn_WlxrB8hHHwMJ6ELlz0jp2cLRtcNcysR.5JCnuYQjVelO
 jrM.n5ntW9M2AHdx28geX2zCw3o6QLDWrxc3qAoSvOhoeeZktwpI5h6ONVsMPcmaD6eiuroCwye0
 XsS1yW2SedR__mMBqfXVlYU08xWaHbv1bF7cKuYAZpMDaU6w4q2a350EdlWMkOW8mnmZxMz4LAMr
 kaAMGh6YdZLLUnuE2Sz9QNQ7ZKSETxe0.hW3V7msXgcYlByXlpT8ePlDt2pSqtKQR3U0SvpNBy0O
 6Ij4A_GW85zt4vnI.7V8G6mZ38KdIeyi_1.lj36kqvDPEqiuRFMnH5jbfOhBWZIMHMvOFhl1LxO4
 8Dwr3GA..TRhaIQmv2RWp7uT8DEHw2f_aWe96_qUWK_ALhMSNjku0Pcpsk54EptzZMSviELLT6Gj
 _McRsPhQEN4eSi7RACLYO9dwDyD55VAy.8pOqmx1fc.bFQBrcS_V7ECXWflAeA5b2.85Lxq8.s5O
 UVrNTMEhBRRAJkkNTQNwmqHnKLay_y.8pXqLvW3_IPTLHHflUl.CpybrdJYapwABVQwDP5L21drg
 07DD4ovF5FgL0x0S1a9AAmD7iPj_GHjADEsLmges._p8MqDUsr9wgn5uSErlMBVW_qDtH2jTY5M0
 D2FRcLDjss_oYZO_kWnI7n8qv84xb4O6ukr3r5ZYRDCq.CfHxQGBMtDXi2xvYZOskqft8fmqPHbG
 amiIg446EreKrgho4PL01hn00JuqFTi92zB5WhyKGmFQdHFpTSQJx9PEktY7Djl06bmW5CFxB8mN
 Ghvgrq1n66Ee4qZWuTNCO6pc7F0dngWlroPHCePOPYJZbGgg1JWoX50xL84WN_78xMgJLO42CF2M
 zEC.il03RzBVVzugIeBB.F8vCCCSm27_8pdefCZSfOg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 15:27:37 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2916ee8ddb6600cadb9ae76b200a557d; 
 Sat, 24 Oct 2020 15:27:33 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 6/5] erofs-utils: fuse: get rid of duplicated I/O ops
Date: Sat, 24 Oct 2020 23:27:18 +0800
Message-Id: <20201024152720.30603-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024130959.23720-6-hsiangkao@aol.com>
References: <20201024130959.23720-6-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ will be folded to the original patch. ]

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am   |  2 +-
 fuse/disk_io.c     | 72 ----------------------------------------------
 fuse/disk_io.h     | 21 --------------
 fuse/init.c        |  6 ++--
 fuse/main.c        |  4 +--
 fuse/namei.c       | 13 +++++----
 fuse/read.c        | 18 ++++++------
 fuse/readir.c      | 10 +++----
 fuse/zmap.c        | 10 +++----
 include/erofs/io.h |  1 +
 lib/io.c           | 16 +++++++++++
 11 files changed, 49 insertions(+), 124 deletions(-)
 delete mode 100644 fuse/disk_io.c
 delete mode 100644 fuse/disk_io.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 8b8c4e10d90d..dc8839c84d73 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c disk_io.c init.c open.c readir.c zmap.c
+erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c init.c open.c readir.c zmap.c
 if ENABLE_LZ4
 erofsfuse_SOURCES += decompress.c
 endif
diff --git a/fuse/disk_io.c b/fuse/disk_io.c
deleted file mode 100644
index bb1ee9a202db..000000000000
--- a/fuse/disk_io.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * erofs-utils/fuse/disk_io.c
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#define _XOPEN_SOURCE 500
-#include "disk_io.h"
-
-#include <sys/types.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <pthread.h>
-#include <errno.h>
-
-#include "erofs/print.h"
-
-#ifdef __FreeBSD__
-#include <string.h>
-#endif
-
-static const char *erofs_devname;
-static int erofs_devfd = -1;
-static pthread_mutex_t read_lock = PTHREAD_MUTEX_INITIALIZER;
-
-int dev_open(const char *path)
-{
-	int fd = open(path, O_RDONLY);
-
-	if (fd < 0)
-		return -errno;
-
-	erofs_devfd = fd;
-	erofs_devname = path;
-
-	return 0;
-}
-
-static inline int pread_wrapper(int fd, void *buf, size_t count, off_t offset)
-{
-	return pread(fd, buf, count, offset);
-}
-
-int dev_read(void *buf, size_t count, off_t offset)
-{
-	ssize_t pread_ret;
-	int lerrno;
-
-	DBG_BUGON(erofs_devfd < 0);
-
-	pthread_mutex_lock(&read_lock);
-	pread_ret = pread_wrapper(erofs_devfd, buf, count, offset);
-	lerrno = errno;
-	erofs_dbg("Disk Read: offset[0x%jx] count[%zd] pread_ret=%zd %s",
-	     offset, count, pread_ret, strerror(lerrno));
-	pthread_mutex_unlock(&read_lock);
-	if (count == 0)
-		erofs_warn("Read operation with 0 size");
-
-	DBG_BUGON((size_t)pread_ret != count);
-
-	return pread_ret;
-}
-
-void dev_close(void)
-{
-	if (erofs_devfd >= 0) {
-		close(erofs_devfd);
-		erofs_devfd = -1;
-	}
-}
diff --git a/fuse/disk_io.h b/fuse/disk_io.h
deleted file mode 100644
index d2c3dd598bc0..000000000000
--- a/fuse/disk_io.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/disk_io.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __DISK_IO_H
-#define __DISK_IO_H
-
-#include "erofs/defs.h"
-#include "erofs/internal.h"
-
-int dev_open(const char *path);
-void dev_close(void);
-int dev_read(void *buf, size_t count, off_t offset);
-
-static inline int dev_read_blk(void *buf, uint32_t nr)
-{
-	return dev_read(buf, EROFS_BLKSIZ, blknr_to_addr(nr));
-}
-#endif
diff --git a/fuse/init.c b/fuse/init.c
index 6917e995370b..867f4bf90e9a 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -10,7 +10,7 @@
 #include <asm-generic/errno-base.h>
 
 #include "namei.h"
-#include "disk_io.h"
+#include "erofs/io.h"
 #include "erofs/print.h"
 
 #define STR(_X) (#_X)
@@ -43,8 +43,8 @@ int erofs_init_super(void)
 	struct erofs_super_block *sb;
 
 	memset(buf, 0, sizeof(buf));
-	ret = dev_read_blk(buf, 0);
-	if (ret != EROFS_BLKSIZ) {
+	ret = blk_read(buf, 0, 1);
+	if (ret < 0) {
 		erofs_err("Failed to read super block ret=%d", ret);
 		return -EINVAL;
 	}
diff --git a/fuse/main.c b/fuse/main.c
index 9008fea32639..26f49f6fc299 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -17,7 +17,7 @@
 #include "getattr.h"
 #include "open.h"
 #include "readir.h"
-#include "disk_io.h"
+#include "erofs/io.h"
 
 /* XXX: after liberofs is linked in, it should be removed */
 struct erofs_configure cfg;
@@ -142,7 +142,7 @@ int main(int argc, char *argv[])
 
 	cfg.c_dbg_lvl = fusecfg.debug_lvl;
 
-	if (dev_open(fusecfg.disk) < 0) {
+	if (dev_open_ro(fusecfg.disk) < 0) {
 		fprintf(stderr, "Failed to open disk:%s\n", fusecfg.disk);
 		goto exit;
 	}
diff --git a/fuse/namei.c b/fuse/namei.c
index 172e1bcdb457..79273f89be1b 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -15,7 +15,7 @@
 
 #include "erofs/defs.h"
 #include "erofs/print.h"
-#include "disk_io.h"
+#include "erofs/io.h"
 #include "dentry.h"
 #include "init.h"
 
@@ -55,8 +55,8 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	const erofs_off_t addr = nid2addr(nid);
 	const size_t size = EROFS_BLKSIZ - erofs_blkoff(addr);
 
-	ret = dev_read(buf, size, addr);
-	if (ret != (int)size)
+	ret = dev_read(buf, addr, size);
+	if (ret < 0)
 		return -EIO;
 
 	v1 = (struct erofs_inode_compact *)buf;
@@ -160,7 +160,8 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 
 	nr_cnt = 0;
 	while (nr_cnt < dir_nr) {
-		if (dev_read_blk(buf, blkno + nr_cnt) != EROFS_BLKSIZ)
+		ret = blk_read(buf, blkno + nr_cnt, 1);
+		if (ret < 0)
 			return NULL;
 
 		entry = list_name(buf, parent, name, name_len, EROFS_BLKSIZ);
@@ -176,8 +177,8 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 			v.inode_isize + v.xattr_isize;
 
 		memset(buf, 0, sizeof(buf));
-		ret = dev_read(buf, dir_off, dir_addr);
-		if (ret < 0 && (uint32_t)ret != dir_off)
+		ret = dev_read(buf, dir_addr, dir_off);
+		if (ret < 0)
 			return NULL;
 
 		entry = list_name(buf, parent, name, name_len, dir_off);
diff --git a/fuse/read.c b/fuse/read.c
index 86a2bfa1b165..8e332e89478f 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -15,7 +15,7 @@
 #include "erofs/internal.h"
 #include "erofs/print.h"
 #include "namei.h"
-#include "disk_io.h"
+#include "erofs/io.h"
 #include "init.h"
 #include "decompress.h"
 
@@ -31,8 +31,8 @@ size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
 	while (rdsz < sum) {
 		size_t count = min(EROFS_BLKSIZ, (uint32_t)(sum - rdsz));
 
-		ret = dev_read(buffer + rdsz, count, addr + rdsz);
-		if (ret < 0 || (size_t)ret != count)
+		ret = dev_read(buffer + rdsz, addr + rdsz, count);
+		if (ret < 0)
 			return -EIO;
 		rdsz += count;
 	}
@@ -57,8 +57,8 @@ size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
 	while (rdsz < sum) {
 		size_t count = min(EROFS_BLKSIZ, (uint32_t)(sum - rdsz));
 
-		ret = dev_read(buffer + rdsz, count, addr + rdsz);
-		if (ret < 0 || (uint32_t)ret != count)
+		ret = dev_read(buffer + rdsz, addr + rdsz, count);
+		if (ret < 0)
 			return -EIO;
 		rdsz += count;
 	}
@@ -67,8 +67,8 @@ size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
 		goto finished;
 
 	addr = nid2addr(vnode->nid) + vnode->inode_isize + vnode->xattr_isize;
-	ret = dev_read(buffer + rdsz, suminline, addr);
-	if (ret < 0 || (size_t)ret != suminline)
+	ret = dev_read(buffer + rdsz, addr, suminline);
+	if (ret < 0)
 		return -EIO;
 	rdsz += suminline;
 
@@ -104,8 +104,8 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 			continue;
 		}
 
-		ret = dev_read(raw, EROFS_BLKSIZ, map.m_pa);
-		if (ret < 0 || (size_t)ret != EROFS_BLKSIZ)
+		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
+		if (ret < 0)
 			return -EIO;
 
 		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
diff --git a/fuse/readir.c b/fuse/readir.c
index 0fefcd8fd0cb..8111047803df 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -13,7 +13,7 @@
 #include "erofs/internal.h"
 #include "erofs_fs.h"
 #include "namei.h"
-#include "disk_io.h"
+#include "erofs/io.h"
 #include "erofs/print.h"
 #include "init.h"
 
@@ -98,8 +98,8 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 
 	while (nr_cnt < dir_nr) {
 		memset(dirsbuf, 0, sizeof(dirsbuf));
-		ret = dev_read_blk(dirsbuf, v.raw_blkaddr + nr_cnt);
-		if (ret != EROFS_BLKSIZ)
+		ret = blk_read(dirsbuf, v.raw_blkaddr + nr_cnt, 1);
+		if (ret < 0)
 			return -EIO;
 		fill_dir(dirsbuf, filler, buf, EROFS_BLKSIZ);
 		++nr_cnt;
@@ -111,8 +111,8 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		addr = nid2addr(nid) + v.inode_isize + v.xattr_isize;
 
 		memset(dirsbuf, 0, sizeof(dirsbuf));
-		ret = dev_read(dirsbuf, dir_off, addr);
-		if (ret < 0 || (uint32_t)ret != dir_off)
+		ret = dev_read(dirsbuf, addr, dir_off);
+		if (ret < 0)
 			return -EIO;
 		fill_dir(dirsbuf, filler, buf, dir_off);
 	}
diff --git a/fuse/zmap.c b/fuse/zmap.c
index 85034d385c58..9860b770362c 100644
--- a/fuse/zmap.c
+++ b/fuse/zmap.c
@@ -10,7 +10,7 @@
  * Modified by Huang Jianan <huangjianan@oppo.com>
  */
 #include "init.h"
-#include "disk_io.h"
+#include "erofs/io.h"
 #include "erofs/print.h"
 
 int z_erofs_fill_inode(struct erofs_vnode *vi)
@@ -42,8 +42,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
 
 	pos = round_up(nid2addr(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
-	ret = dev_read(buf, 8, pos);
-	if (ret < 0 && (uint32_t)ret != 8)
+	ret = dev_read(buf, pos, 8);
+	if (ret < 0)
 		return -EIO;
 
 	h = (struct z_erofs_map_header *)buf;
@@ -97,8 +97,8 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = dev_read(mpage, EROFS_BLKSIZ, blknr_to_addr(eblk));
-	if (ret < 0 && (uint32_t)ret != EROFS_BLKSIZ)
+	ret = blk_read(mpage, eblk, 1);
+	if (ret < 0)
 		return -EIO;
 
 	map->index = eblk;
diff --git a/include/erofs/io.h b/include/erofs/io.h
index a23de64541c6..557424578ece 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -17,6 +17,7 @@
 #endif
 
 int dev_open(const char *devname);
+int dev_open_ro(const char *dev);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
 int dev_read(void *buf, u64 offset, size_t len);
diff --git a/lib/io.c b/lib/io.c
index 4f5d9a6edaa4..d835f34da50f 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -108,6 +108,22 @@ int dev_open(const char *dev)
 	return 0;
 }
 
+/* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
+int dev_open_ro(const char *dev)
+{
+	int fd = open(dev, O_RDONLY | O_BINARY);
+
+	if (fd < 0) {
+		erofs_err("failed to open(%s).", dev);
+		return -errno;
+	}
+
+	erofs_devfd = fd;
+	erofs_devname = dev;
+	erofs_devsz = INT64_MAX;
+	return 0;
+}
+
 u64 dev_length(void)
 {
 	return erofs_devsz;
-- 
2.24.0

