Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEED34DD15
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:39:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8VvY1WPLz30BM
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:39:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064777;
	bh=66ULpPqRoXviiDRkPy0ik2xdEXssx0yJg3xrJXJm+Zc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JtImkuUVdSf6Y+IFYArOgAeN9GnWXU+Y1EYMzgclbC1c4i3fYxEh7o+SawLJw1+VO
	 9+X/y/ePxfP/3FR1oy+p2dPv3wp3WFMXwAaX6T4c7f9bxNe8DKJ24qYPa6mD2hFhbj
	 YjEMvWdsZmgAyMrVcwUfzmv/MOjgJRwrqSD1fxkTeQeP6TzfGfcdG0qsZBas72Bjlg
	 OGZjIiqH8zwXUJ5w6ObaMIP6X9UWON7onB1ny0n8CfGEGU3dCJFgPQqN6+sAtna5br
	 ffeQHly8KLKYZfvk7QrCbaiDJZayBqxu7uPB+cmpi2wRxhEPBf9dAnd1Boqb9gDuD/
	 vNOvq1Q4nbzJA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.31; helo=sonic316-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=HtR3vaWN; dkim-atps=neutral
Received: from sonic316-55.consmr.mail.gq1.yahoo.com
 (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8VvV1KShz302v
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:39:33 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064770; bh=QEylsRZEpQAkVKqmgHtILHgcP3E/UDb7RL28KlHT/Eg=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=bwTxzXrZVfeu7NZpNvl4w7Ny0bks3tgdtvo7iUnideZxxIUTsGwGjcKlARrOzKl1/jG418SM5J4jCnyCXuUVqepdJWR3uLG7WITXThDxVJW2QtXWbrxW6tIYLKO1xEPpx/lYOXaoJRhfKOAJv9oRXU05bs70yGczwNy28+nwUL6qEKsc0LpDB8TrPo8KRgBZ5EiK/xmVHBy/MuGC8Hs/cO7OwRiSxdobcMnm31ao3ZBHOjmm8SnB+qJV1E8f99V/JVVL3ybyJ1ID9eh0UhDQm4jKUvgTG6KSHuV+2VCtbRbfOFluKD6W5/el6FuPo/Svd4l+Bea+d2cjV1BOYSdCCQ==
X-YMail-OSG: 5nX0Ow8VM1m3b0e0kKzC_Dt_4Tf.udKEr3QkL1VXxs271DM60cUxrJhxEt02V0l
 bkItPbHUFdsOujSXc05NDfIiFxoAYjTLrfxUs6bFp6C5PA3RmsKtUmgdi7SSOZyndl5xT9tASC7o
 MXBs5zWlTi2ocT9Zcy4HdWAa9C4Xa6Ox9Y1Ogpecj745Z6_IXSakDb2C0M87jC3PUJQA11cA_ykk
 zkBg_tNzQJB1iNdvQCMQhSa7xv6Fm1dViynFxiBfei4u888TBT_0PnjHZyhwlCCLqPpLPeEcXQA_
 BFmofXEZmp.2oDwOApnnyMfP1Qpw7Xk3guI1OkQrX7IcoNw6q6QpE6dWK.xEUo3Pp7r.acFPJ8gc
 urtyuevLIqqcND9CieNLlL17Qdm96DaNiKiATbSUU7VsD2nOziVx.XzvLdXtKvgxOwb5WPUOpuIc
 SXWufTZbWJny9p_N7.V5.w9OLVZzp6te4c_axNiHXMsSdXOKLYLzf3j6cyvHtl0OakgKcE.K07eE
 32mEl5v7ToX5orOjUs3ttM40KlIijVkJx_.aaZd4Oe7R_lHaAf7JfKC.hSIaPf9LGu_hfjjqY3Od
 Wy1_QNKMLyMB1.K0VBhj5MT9PWDwp3IN.hN2YxP4ELuMIUGpLe0bfJbKd.ifimbz5GtNVYTe1hOy
 X80xQZ5sOKyWcQ_XzwwdCdC5brhueicROiyK2vRAPPwjM1zXazRiaVldPxUrI3ePyG9.qcm3nVpp
 ZjSailKLQFD.ddFTcXKkxrjLH3ZpSUHP5GmQFp9hMk_w6Cec8IUdr4MtOm.4gs3WTFPvwdXv3tQX
 o7Y5xNhEPCwFfLFvdP.xOvF05xBdx7OGINQBCuXQX9dF6mG.nWRSQMu_DlImPMvArhdpfo8xjSU3
 MO5L50cbX1q20nnSu5ZRDlOeBwi5CaPuHDo1CQ_R5uN7BL4w67ODJGd7foJZ9R_vpYEn_2ssWYSF
 LzQlhEEcX5W.5vfNeIwd9cXkIffx5CbZ42ayqryfsV3rLnJOMqa38W_dG8JBogzvooV7rBmkF0ek
 tgwNlBG5tCZuf3X0SnuAbRn4cfaW.KjwCcX.zJ8xQGIs_SzBEY5S.iBZ2JbAl9LhFMojFkH_S42B
 J7o0vz3RmxKABEKW1A8Oy9GQfdFDPbs2_NVdgmg_sClBF74pHQwd2f0F2wRg3JSWpGlX_wfMeVLK
 My7FEL8gc7PeWfOCjUt6WAT61oMEmGhantJJ624WEJ57TeeD9NnpVS7l_r2KBoZaX4vEpyT_lwrt
 4sv9W.jwYlHLhhYT5HILNKzil0tHjGdxI3zOLtdRakt4g5mNlO4qECQD_TRTr3FRJ9YdefL6.058
 y6nQklCBRZF0DjDVMrRK9.nlnBcYkmb37Ya5joZjcR18MlZUV9nXcYJezO8V1yfXIQxD6k1R98TU
 U4Ny4b3qAW10.nrBZjAkHXo91ITjeEDdqoUJfea2dqKNSutNFkPfrF8bB3eZaJ.QF4nMITbc.R7P
 hYuBzLLUggfdlXmdXIzLHtZ.slGLlEI_YhxCiZCqnGyb7x3N5LnktFVT5tWkvnFEmkaC1zCZcKg4
 AUc86YdRSsmWBnGNg9fnQpxa.5LXu5Adhh1JwpiDz6IBOY3PRfI1i.SygqP0fKx5TSbTB4bRdFi4
 hZHazib6xNlLV8y3xk1aEloKSm6xkWtw_u9DOmCOyLSCcd69SyV6c8Btsq2WNu9AijzYFN1UImiy
 ZkDhFtAQzwsv2tJ2iBh3EzZB8oR29iACN876cCKhPsaBMLWA0o.1o1lwtVptCf.fg7Xg6exhTOQa
 U0nkypPLnsryAG.adrWXfVOBuOI9s2eYlTPye8u5P3JvZxqvZU7tWylvyJ2fokEc4vBUa.xClaBz
 O2bR92_uxoN7wC7bmxSBUIIHlH7qgzoVAh37RdeM1096B6miqR.WDbFk8Qx8VV5SLJbytqFiQyjA
 S0FXwhooGkmZEuIJZc_C.Gifr1J.m0rwUifcTYAYNcnMWFz0mcLcf1bu.TNAxGE3EDqsGR3W6tWd
 l.HDGEK86Oy4_YBv..gmpqY4N_.LqOgsx4X1kS_31h98bqF1xtN7y8_PvADZyU6wUaQ_Tt2fUuEx
 LTPIkmtTQY1213x6Qn5BY2uvvYmCqg6DBJvoI301sApHS1F_5UBjUtXvN44d1D3jWh2zLszHybiQ
 8R8uhZRVQjhMNj31vd4vWdorAW36sBpjReVoN2gIUv9aj_J_FlU6xzJ8wjcdg4VksfG17zP2EqVn
 Mhc1ljPVbLx8i9F9tFNdBIXwxP9VkpGlrfagoMBbmfqqPNYtTXsRIdOfpP6FbFACC.R50H9.Dp4r
 MfsyxM7DqfoFjvXsHBny0ovyIIfItU88OeTaK66C7tfxH5UurMTYQfvnHx0KMZzMtjwwMrwwGeFX
 1EoHq1pGsTbNHEkZgAa94VmfypWZ6Xryvo0J6qZvO4dVTGiKU9Rzy3oa0R0AGi17c8_BnD5D0j6W
 1iUEsBnqg8X5kqG29RaAtg6Ytg_ZoPB9cRUqnDdLNpizkUgL81bKrQ9aBRP4.4Hr1Whej7kUN95.
 I9cBZdOgjZeIN8OJJPr2r2T15vYxQMSbEFvwyl_2FcfrKec.8MuyY_LFMz1wAaPjSUnOxMFgHbSq
 OJcVk.jodd6ZakxY0kT1xWFxR4smZbeYOCj0OzALuXvvuCElXGYhMkGjAdxBR8WtlexnCnCydzrK
 4ShdgftiDdJgu6311xAEB.uWx9Rjug1Z.M_ealqXIDdar9e.aW_2.0767aTEtT64VNgdhUBt1u6Y
 VD62qk5R2PuAx1Ef588_AxwauQccbTkkGJuPeAlXex2qS1b_c0oCF4OZLyqKjn8mx8uLQboiHI8v
 f9LR2_kzjHTbPLNJ1l2YzYaK61IkzdUS7rPxv6YwCvCPC6wTfl4vSnNVcFkhqTMzhvjgeX486Moq
 K_lfJRYWQTwuqjdo1_JZo0jXAqQXK11ijWjXzzK0vFPOguAZ3KKEiVhQd2MVsxA.8PCz3LzdH4.v
 x6feNAMvgKIweNCWGZMvUF88.RG6DlJzsShpqCFEQ6EOYIL2eJOIV03Ra5SkdRJNqE3UoZP1oGEF
 qQfmwG6KrQ98CjjEGAAmReEP1KygIunGDvC7Vl33bcZQk_5DgAIw_dU41R3gYgEPOxZ.6pqBaYoK
 ddav2TVOLDRCUjJdSrU8-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:30 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb; 
 Tue, 30 Mar 2021 00:39:27 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 02/10] erofs: introduce multipage per-CPU buffers
Date: Tue, 30 Mar 2021 08:39:00 +0800
Message-Id: <20210330003908.22842-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330003908.22842-1-hsiangkao@aol.com>
References: <20210330003908.22842-1-hsiangkao@aol.com>
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>, Guo Weichao <guoweichao@oppo.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

To deal the with the cases which inplace decompression is infeasible
for some inplace I/O. Per-CPU buffers was introduced to get rid of page
allocation latency and thrash for low-latency decompression algorithms
such as lz4.

For the big pcluster feature, introduce multipage per-CPU buffers to
keep such inplace I/O pclusters temporarily as well but note that
per-CPU pages are just consecutive virtually.

When a new big pcluster fs is mounted, its max pclustersize will be
read and per-CPU buffers can be growed if needed. Shrinking adjustable
per-CPU buffers is more complex (because we don't know if such size
is still be used), so currently just release them all when unloading.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c |   8 ++-
 fs/erofs/internal.h     |  24 ++------
 fs/erofs/pcpubuf.c      | 130 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c        |   1 +
 fs/erofs/utils.c        |  12 ----
 6 files changed, 143 insertions(+), 34 deletions(-)
 create mode 100644 fs/erofs/pcpubuf.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index af159539fc1b..1f9aced49070 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 27aa6a99b371..fb4838c0f0df 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -47,7 +47,9 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-	return 0;
+
+	/* TODO: use max pclusterblks after bigpcluster is enabled */
+	return erofs_pcpubuf_growsize(1);
 }
 
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
@@ -114,7 +116,7 @@ static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
 	 * pages should be copied in order to avoid being overlapped.
 	 */
 	struct page **in = rq->in;
-	u8 *const tmp = erofs_get_pcpubuf(0);
+	u8 *const tmp = erofs_get_pcpubuf(1);
 	u8 *tmpp = tmp;
 	unsigned int inlen = rq->inputsize - pageofs_in;
 	unsigned int count = min_t(uint, inlen, PAGE_SIZE - pageofs_in);
@@ -271,7 +273,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	 * compressed data is preferred.
 	 */
 	if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
-		dst = erofs_get_pcpubuf(0);
+		dst = erofs_get_pcpubuf(1);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 05b02f99324c..f707d28a46d9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -197,9 +197,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 
 /* hard limit of pages per compressed cluster */
 #define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
-#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
-#else
-#define EROFS_PCPUBUF_NR_PAGES          0
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
@@ -405,24 +402,15 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
+/* pcpubuf.c */
+void *erofs_get_pcpubuf(unsigned int requiredpages);
+void erofs_put_pcpubuf(void *ptr);
+int erofs_pcpubuf_growsize(unsigned int nrpages);
+void erofs_pcpubuf_exit(void);
+
 /* utils.c / zdata.c */
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
 
-#if (EROFS_PCPUBUF_NR_PAGES > 0)
-void *erofs_get_pcpubuf(unsigned int pagenr);
-#define erofs_put_pcpubuf(buf) do { \
-	(void)&(buf);	\
-	preempt_enable();	\
-} while (0)
-#else
-static inline void *erofs_get_pcpubuf(unsigned int pagenr)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-#define erofs_put_pcpubuf(buf) do {} while (0)
-#endif
-
 #ifdef CONFIG_EROFS_FS_ZIP
 int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
new file mode 100644
index 000000000000..3b606e299b1d
--- /dev/null
+++ b/fs/erofs/pcpubuf.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-2021 Gao Xiang <xiang@kernel.org>
+ *
+ * For low-latency decompression algorithms (e.g. lz4), reserve continuous
+ * per-CPU virtual memory (in pages) in advance to store such inplace I/O
+ * data if inplace decompression is failed (due to unmet inplace margin for
+ * example).
+ */
+#include "internal.h"
+
+struct erofs_pcpubuf {
+	raw_spinlock_t lock;
+	void *ptr;
+	struct page **pages;
+	unsigned int nrpages;
+};
+
+static DEFINE_PER_CPU(struct erofs_pcpubuf, erofs_pcb);
+
+void *erofs_get_pcpubuf(unsigned int requiredpages)
+{
+	struct erofs_pcpubuf *pcb = &get_cpu_var(erofs_pcb);
+
+	raw_spin_lock(&pcb->lock);
+	if (requiredpages > pcb->nrpages) {
+		raw_spin_unlock(&pcb->lock);
+		put_cpu_var(erofs_pcb);
+		return NULL;
+	}
+	return pcb->ptr;
+}
+
+void erofs_put_pcpubuf(void *ptr)
+{
+	struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, smp_processor_id());
+
+	DBG_BUGON(pcb->ptr != ptr);
+	raw_spin_unlock(&pcb->lock);
+	put_cpu_var(erofs_pcb);
+}
+
+/* the next step: support per-CPU page buffers hotplug */
+int erofs_pcpubuf_growsize(unsigned int nrpages)
+{
+	static DEFINE_MUTEX(pcb_resize_mutex);
+	static unsigned int pcb_nrpages;
+	LIST_HEAD(pagepool);
+	int delta, cpu, ret, i;
+
+	mutex_lock(&pcb_resize_mutex);
+	delta = nrpages - pcb_nrpages;
+	ret = 0;
+	/* avoid shrinking pcpubuf, since no idea how many fses rely on */
+	if (delta <= 0)
+		goto out;
+
+	for_each_possible_cpu(cpu) {
+		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
+		struct page **pages, **oldpages;
+		void *ptr, *old_ptr;
+
+		pages = kmalloc_array(nrpages, sizeof(*pages), GFP_KERNEL);
+		if (!pages) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		for (i = 0; i < nrpages; ++i) {
+			pages[i] = erofs_allocpage(&pagepool, GFP_KERNEL);
+			if (!pages[i]) {
+				ret = -ENOMEM;
+				oldpages = pages;
+				goto free_pagearray;
+			}
+		}
+		ptr = vmap(pages, nrpages, VM_MAP, PAGE_KERNEL);
+		if (!ptr) {
+			ret = -ENOMEM;
+			oldpages = pages;
+			goto free_pagearray;
+		}
+		raw_spin_lock(&pcb->lock);
+		old_ptr = pcb->ptr;
+		pcb->ptr = ptr;
+		oldpages = pcb->pages;
+		pcb->pages = pages;
+		i = pcb->nrpages;
+		pcb->nrpages = nrpages;
+		raw_spin_unlock(&pcb->lock);
+
+		if (!oldpages) {
+			DBG_BUGON(old_ptr);
+			continue;
+		}
+
+		if (old_ptr)
+			vunmap(old_ptr);
+free_pagearray:
+		while (i)
+			list_add(&oldpages[--i]->lru, &pagepool);
+		kfree(oldpages);
+		if (ret)
+			break;
+	}
+	pcb_nrpages = nrpages;
+	put_pages_list(&pagepool);
+out:
+	mutex_unlock(&pcb_resize_mutex);
+	return ret;
+}
+
+void erofs_pcpubuf_exit(void)
+{
+	int cpu, i;
+
+	for_each_possible_cpu(cpu) {
+		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
+
+		if (!pcb->pages)
+			continue;
+
+		for (i = 0; i < pcb->nrpages; ++i)
+			if (pcb->pages[i])
+				put_page(pcb->pages[i]);
+		kfree(pcb->pages);
+		pcb->pages = NULL;
+	}
+}
+
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b641658e772f..41fbfee4990c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -684,6 +684,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes are safe before cache is destroyed. */
 	rcu_barrier();
 	kmem_cache_destroy(erofs_inode_cachep);
+	erofs_pcpubuf_exit();
 }
 
 /* get filesystem statistics */
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index de9986d2f82f..6758c5b19f7c 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -21,18 +21,6 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 	return page;
 }
 
-#if (EROFS_PCPUBUF_NR_PAGES > 0)
-static struct {
-	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
-} ____cacheline_aligned_in_smp erofs_pcpubuf[NR_CPUS];
-
-void *erofs_get_pcpubuf(unsigned int pagenr)
-{
-	preempt_disable();
-	return &erofs_pcpubuf[smp_processor_id()].data[pagenr * PAGE_SIZE];
-}
-#endif
-
 #ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
-- 
2.20.1

