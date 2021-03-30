Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2634DD16
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:39:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8Vvd0hn7z303J
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:39:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064781;
	bh=5Qm0t4ZtUUmqyQI7zUHTrnaVLmUiKMMdOP4qIEazr0o=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KAitVHg7Vz21OloMc31Gxxu5DhLmdJLQiYr7ACU/k17Gi8oo/AyvZWFpCyKqlmbDU
	 HrxblWblqq4QsJNIwVgYOo8L9wFQyxSGEwiUtPQtbJBpv265HZ/wrZLZvtigOVGoZB
	 DA1+5o4tPTenLs1DNjBH0hSeDDFZEUv3JIRkNShmscMYBP8JXxoVv9OmhdwvGb9RKt
	 voNOdbDkYK0b+I5RehZ/SmTwRL2wpHtL6I6yqCZfIMjh1m5RvtI9ZmmXABXocrF6+q
	 /ZzUzfdX0Y7CPjZqEk5ktbC4HchOfxHUSpV6286HNMIF402a7U/oH+ZUoJbaZ+Zw9b
	 azsSnOCjjVsqg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Sv2Z89yQ; dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8VvZ4GFvz3000
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:39:38 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064775; bh=+V3gJWXsrkVUTLEVJJBzJxrFbdKZ5EjoXl6GZSEoAoA=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=dews7Vhes5ZNRaCXxgmGkgtADciSfYqrPhyqd9NV8UYdu7fooYcRSncFeF+mrT0R7PVYttngDy/AC9+F1WD/zjISf4YRB2PCeGmMvGslIajNs9C0xn4z1byMYmhRh+6haVnno0ZxC/sk0EdA1esvhmdhxKtoMoPiv24GbrYN/imLx68jAEuFOkdB5F/+gjzjDvDpcrWMPAvKQhmhY/gJChViVc2n8lkIQDDcxmwyRoleNStZQSq+kJg35dG/Pw9xa82hGy3VQILvgS8ZiQ193TmiXR7omY975zxZ44QSh2iJSDyKMmwNXssh06R522dKrX9V7TnZjDoY8HfvX2ym1Q==
X-YMail-OSG: d15pnz8VM1npTuXGC_RshJ9uv.Tt2e26T9tqHdaWDi3vGsDqyAQ_fR6Hc2XZu2z
 aVloSVbUZ9UTFToKXr82k4MhD4y1Lt2pger1UKZ84PR9darZaCQ3vgh8Tradka6eTXHFf932vFO3
 qRVrub2G.I9wPyRNzmSkPUKTNTjKFlILJW1sc0NJOYZ7z4y7lApdG00vnfubSX3kmjMX_vbsgb2g
 qt6xScc2wUAKAHqJnrnQNwv0Iv8RFpdMfCeVvxdz7gZMIEqmfZffTBxwpUN.4lxe15rQf6JBwDOy
 7BB_OrzH55JyEJSTpjO8y07gy9weK1mFT.sqz_uapfhl_PveBwfYUD1NfGFxVqk1TK0m763zluf2
 0u4weFadTRj7.EnyUUotAG5rk_QB7GvDuJ.HdshFAtRwbnMoSWW_TWB6ioEbJTrNsFpEi_eyttfb
 6XhYU3_2qBLOXWy3764BngEcyzMcj4YcP0XEnU7EPnQlro6KaKpgtFu0C9xO4ZTCkA7zdm9WEpOq
 FXVbMS9cV6XIEpQ_KmZYtZggJFp__aOn1DnttKjjSoO5wcjyLcWR0zaUw2p9vB4aUMMrT4Lfzj_2
 2tPSPl7OElhH.rPOZVe2PbbnheO4h7mdXP.YB0k1XmlvRE7ttPOdg5_xeGwx9Rwb_e3xPtfHYuFN
 30gWFS.l.zNo9kbO48HfX9mAC5skh0K4C32hZvbLjzku29nao0zS0bykuaef8kaHnPYN83kGwri0
 u8LAbszukF0cJFdHe6opU2aPs8MRktpOv76er59E23ShkWT.5MyFtVtDQYG8UK4_jQoN6mLEheou
 Ba3uCILbtlclHmBV_YEeLVUnga9okaysicitlffV9L83V6Ej_NnocIiWreAw0xojo6S.f0QToL7_
 XPS8QK5oQrDAhmfOU3Q.IWewybolme.1oLOaYV4eIjiFhPnFbyTxhgjiR_iFd_ogRoFt_pP27FdT
 e_LkoahwbpF_AuKeAPNRrFZ5iPyoWCeDYQ8XxyJKla.6ozkf7gvTbJ4ypGtP8C0iXx5EHhax1BhG
 NsvDAOXCGzwXlSFVMOsdV7y1TkOzYZ4P7V1IIsdO09JVJLYBEnk6_KWiLV4lTfAwDRR2IGfjouu5
 AAOCLbRqW2eCv0oExEw575uAQ84I5XqF2vS7wz19mAzL22TyBP1gFVuCyqyn1a3hhUErIVdPVbE2
 wxgKa0c92qjWMr0iNsTDTi6u13XeXOiPWzYcqnDjB7DJj.eW5lVkIziqgY83t.ozwW9po4Zd8nKW
 d.XvavNcKFLG.NNdjDBSAQDus.f76bGSMKXKsAaHhLhX_RnY.1QT8A7i7yF8j9C4LKbnZmcPDEgc
 8Xg8uWKH80.TtP7aaEUzQuSrpqDmskotNw0DGpXQo3xV.Jzh7Ac1U4Wrmq2M561Bww3Xp_B_TJyf
 xEgGUcNROSHBxhE4NnoeykQZ8eO0Im1hFolilg8F7TOPMx4f7h1gXE886z1n0BSfKjdGVbQ0Mb1O
 lwDOrYNNuU35.oRBVXPf_qjaw9YEF4y0yTbJEfvFZ4tpGOWSxXi1i7wXn57D0HvZYF6f4hfLbnxs
 YRxEZusscUDHvIUYxaFIregbME6T6LDYx989NB1TZO5WYOek.eu5tUr3_9rNhVXitiAuI2raHhxa
 FDDEQEH8c0gwLlCCxTqgw5V6vOaDZR_aXGeOcfmdo.kb6COQ9J9p4DIMW8IB9MJ6if4o9BDj4D6x
 682TchMtjYS5UKIU4WIpzF61ZNQEoNgelX6SO.ToQoIlEYPwgfw_HNfyejtoNU9EowJx6eRCP.3V
 L.9phuUiLNNb8eWbpSYokqqoG8MxgGbHjF0Tf5t4lx0uUPvcraL7Hv8ZTb32P2rIEhsHDD6OkjSX
 1etSqSAZKtclORF4UR5Y81i6lWBkyzsITUv9_xU4Q1qi0leL7NRBUfyHWAWu8h1Fu2XQ93c.yzTb
 Kx8jmpNz.Cc0BE.bStgNCkshhHMmUZeoDZd43YbkrDZljj9etJcr3zL63U.gFLLvmA4k0l6AdqRo
 E0RDO5cSf9wSwZ5FiCg.kJPa7aJJR0lV6NpK1PK1PuuPKYnyT3CFCbLhjTSunxbXF.0naO65v5Zg
 gNnPeDevvhGZQVjF5xAjFyHHA1OYzP304DlVrqYX96QErr3R1.eC0hWZeqnpCU94fMKQ7_cPkcIf
 pCaSq1rro0HeIxoi4ydiEvJ8MrDHV58BjjmMyaz_lU23vcAdUvqgGDkVbZeRUPb5u2pSHJhV6n2e
 11xIgfMuNWCgYGQb91BpyXOiudkmo7mZ2Ff5sAhxP2QEutVKjwLnv0rBueBR6RVNobYP1XwlOiY_
 BXEEXwRTbnq42r72BWTVp.3ldsIIg3ik_z6HG_xxWzMMKgErb3X803MEuVtm7qbU.E_AtUUKV0Kj
 aeRixw.BO6k81XwPdDbN7D9oA_IyFf1SuTEgfLZHp5jFpyPe9sUwFIR5Oxni7zfKkZqJCEui1U7j
 IaZqCKalnUgot5jzUeEKZg26mkTcTlupuNU6f7yJGf6a9stguW1T.Bw.TOoRKqh6SDAqqCkFD4EV
 aZIByURZesi0vwb3DjNut60hV1tPuTu9tjhuF79qJn4Tg09wDK0t4xhT66CIjfwrFxYlUpX6g8CP
 IrTmDzmuNiy1Qmo7un2RcOn1z.xmEwasTpOHoZnojpGzmGcZoaoDwHkzBFwcGvPyh6dNSqH75m8K
 0XxVE7xSFxBf_WrePIDJ8l4mdSH0EVb2fkhFgCPPyFWEo3qgZD9n0HE826eGkV9Nr42QRXB7dsx7
 5atrC5U2MReNN5QPLLmIc0i4YRKWj1lVM9I8BNRMLWbbLP7K9FrTAI1z_tjr86wKqEMsPY153jGS
 Sfe_4GX0CBqegEgEccYboU2AkaS7BWwFAFxUCvbIo7aMtUuzWrEzuSKGu7ju89T3dSm_.rejRqrp
 gjvADbI7iBjswYW4C6O.UjgcZ8CPJ8GO2jq_AQbakKqS_u.auI8vdlCeaM50JBNOQQQIm7V0ndJ2
 gibIY6Ycz5swLsSrVaeu1Z2mdFebPWkdOF6JyxffwGyML2pyHOXSr0xQ.SmpEkNkyHSMLc2E1_yJ
 4TFkpPM12ZTTy2_s9ODtVPlDOowupVZgW8rzypqi2n5doAHsXG4rIiera3L2_sshMvJW0womUKak
 P.TQX7HAKPvsYLN4buCBH4Xzb.hrgLB_brr11SLt_OKdHzcDe9j65UNWi409M26UjTdmmgHAPxfU
 -
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:35 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb; 
 Tue, 30 Mar 2021 00:39:31 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 03/10] erofs: introduce physical cluster slab pools
Date: Tue, 30 Mar 2021 08:39:01 +0800
Message-Id: <20210330003908.22842-4-hsiangkao@aol.com>
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

Since multiple pcluster sizes could be used at once, the number of
compressed pages will become a variable factor. It's necessary to
introduce slab pools rather than a single slab cache now.

This limits the pclustersize to 1M (Z_EROFS_PCLUSTER_MAX_SIZE), and
get rid of the obsolete EROFS_FS_CLUSTER_PAGE_LIMIT, which has no
use now.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/Kconfig    |  14 ----
 fs/erofs/erofs_fs.h |   3 +
 fs/erofs/internal.h |   3 -
 fs/erofs/zdata.c    | 172 +++++++++++++++++++++++++++++---------------
 fs/erofs/zdata.h    |  14 ++--
 5 files changed, 126 insertions(+), 80 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 74b0aaa7114c..858b3339f381 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -76,17 +76,3 @@ config EROFS_FS_ZIP
 
 	  If you don't want to enable compression feature, say N.
 
-config EROFS_FS_CLUSTER_PAGE_LIMIT
-	int "EROFS Cluster Pages Hard Limit"
-	depends on EROFS_FS_ZIP
-	range 1 256
-	default "1"
-	help
-	  Indicates maximum # of pages of a compressed
-	  physical cluster.
-
-	  For example, if files in a image were compressed
-	  into 8k-unit, hard limit should not be configured
-	  less than 2. Otherwise, the image will be refused
-	  to mount on this kernel.
-
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 626b7d3e9ab7..76777673eb63 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -201,6 +201,9 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 				 e->e_name_len + le16_to_cpu(e->e_value_size));
 }
 
+/* maximum supported size of a physical compression cluster */
+#define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
+
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f707d28a46d9..06c294929069 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -194,9 +194,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	return v;
 }
 #endif	/* !CONFIG_SMP */
-
-/* hard limit of pages per compressed cluster */
-#define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index eabfd8873e12..7f572086b4e3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -10,6 +10,93 @@
 
 #include <trace/events/erofs.h>
 
+/*
+ * since pclustersize is variable for big pcluster feature, introduce slab
+ * pools implementation for different pcluster sizes.
+ */
+struct z_erofs_pcluster_slab {
+	struct kmem_cache *slab;
+	unsigned int maxpages;
+	char name[48];
+};
+
+#define _PCLP(n) { .maxpages = n }
+
+static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
+	_PCLP(1), _PCLP(4), _PCLP(16), _PCLP(64), _PCLP(128),
+	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
+};
+
+static void z_erofs_destroy_pcluster_pool(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
+		if (!pcluster_pool[i].slab)
+			continue;
+		kmem_cache_destroy(pcluster_pool[i].slab);
+		pcluster_pool[i].slab = NULL;
+	}
+}
+
+static int z_erofs_create_pcluster_pool(void)
+{
+	struct z_erofs_pcluster_slab *pcs;
+	struct z_erofs_pcluster *a;
+	unsigned int size;
+
+	for (pcs = pcluster_pool;
+	     pcs < pcluster_pool + ARRAY_SIZE(pcluster_pool); ++pcs) {
+		size = struct_size(a, compressed_pages, pcs->maxpages);
+
+		sprintf(pcs->name, "erofs_pcluster-%u", pcs->maxpages);
+		pcs->slab = kmem_cache_create(pcs->name, size, 0,
+					      SLAB_RECLAIM_ACCOUNT, NULL);
+		if (pcs->slab)
+			continue;
+
+		z_erofs_destroy_pcluster_pool();
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
+		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
+		struct z_erofs_pcluster *pcl;
+
+		if (nrpages > pcs->maxpages)
+			continue;
+
+		pcl = kmem_cache_zalloc(pcs->slab, GFP_NOFS);
+		if (!pcl)
+			return ERR_PTR(-ENOMEM);
+		pcl->pclusterpages = nrpages;
+		return pcl;
+	}
+	return ERR_PTR(-EINVAL);
+}
+
+static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
+		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
+
+		if (pcl->pclusterpages > pcs->maxpages)
+			continue;
+
+		kmem_cache_free(pcs->slab, pcl);
+		return;
+	}
+	DBG_BUGON(1);
+}
+
 /*
  * a compressed_pages[] placeholder in order to avoid
  * being filled with file pages for in-place decompression.
@@ -37,12 +124,11 @@ typedef tagptr1_t compressed_page_t;
 	tagptr_fold(compressed_page_t, page, 1)
 
 static struct workqueue_struct *z_erofs_workqueue __read_mostly;
-static struct kmem_cache *pcluster_cachep __read_mostly;
 
 void z_erofs_exit_zip_subsystem(void)
 {
 	destroy_workqueue(z_erofs_workqueue);
-	kmem_cache_destroy(pcluster_cachep);
+	z_erofs_destroy_pcluster_pool();
 }
 
 static inline int z_erofs_init_workqueue(void)
@@ -59,32 +145,16 @@ static inline int z_erofs_init_workqueue(void)
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
 
-static void z_erofs_pcluster_init_once(void *ptr)
-{
-	struct z_erofs_pcluster *pcl = ptr;
-	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
-	unsigned int i;
-
-	mutex_init(&cl->lock);
-	cl->nr_pages = 0;
-	cl->vcnt = 0;
-	for (i = 0; i < Z_EROFS_CLUSTER_MAX_PAGES; ++i)
-		pcl->compressed_pages[i] = NULL;
-}
-
 int __init z_erofs_init_zip_subsystem(void)
 {
-	pcluster_cachep = kmem_cache_create("erofs_compress",
-					    Z_EROFS_WORKGROUP_SIZE, 0,
-					    SLAB_RECLAIM_ACCOUNT,
-					    z_erofs_pcluster_init_once);
-	if (pcluster_cachep) {
-		if (!z_erofs_init_workqueue())
-			return 0;
-
-		kmem_cache_destroy(pcluster_cachep);
-	}
-	return -ENOMEM;
+	int err = z_erofs_create_pcluster_pool();
+
+	if (err)
+		return err;
+	err = z_erofs_init_workqueue();
+	if (err)
+		z_erofs_destroy_pcluster_pool();
+	return err;
 }
 
 enum z_erofs_collectmode {
@@ -169,7 +239,6 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct list_head *pagepool)
 {
 	const struct z_erofs_pcluster *pcl = clt->pcl;
-	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	struct page **pages = clt->compressedpages;
 	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
 	bool standalone = true;
@@ -179,7 +248,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
 
-	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
+	for (; pages < pcl->compressed_pages + pcl->pclusterpages; ++pages) {
 		struct page *page;
 		compressed_page_t t;
 		struct page *newpage = NULL;
@@ -239,14 +308,13 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
 	struct address_space *const mapping = MNGD_MAPPING(sbi);
-	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	int i;
 
 	/*
 	 * refcount of workgroup is now freezed as 1,
 	 * therefore no need to worry about available decompression users.
 	 */
-	for (i = 0; i < clusterpages; ++i) {
+	for (i = 0; i < pcl->pclusterpages; ++i) {
 		struct page *page = pcl->compressed_pages[i];
 
 		if (!page)
@@ -271,13 +339,12 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
-	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	int ret = 0;	/* 0 - busy */
 
 	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
 		unsigned int i;
 
-		for (i = 0; i < clusterpages; ++i) {
+		for (i = 0; i < pcl->pclusterpages; ++i) {
 			if (pcl->compressed_pages[i] == page) {
 				WRITE_ONCE(pcl->compressed_pages[i], NULL);
 				ret = 1;
@@ -297,9 +364,9 @@ static inline bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
 					  struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = clt->pcl;
-	const unsigned int clusterpages = BIT(pcl->clusterbits);
 
-	while (clt->compressedpages < pcl->compressed_pages + clusterpages) {
+	while (clt->compressedpages <
+	       pcl->compressed_pages + pcl->pclusterpages) {
 		if (!cmpxchg(clt->compressedpages++, NULL, page))
 			return true;
 	}
@@ -413,10 +480,10 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	struct erofs_workgroup *grp;
 	int err;
 
-	/* no available workgroup, let's allocate one */
-	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
-	if (!pcl)
-		return -ENOMEM;
+	/* no available pcluster, let's allocate one */
+	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
+	if (IS_ERR(pcl))
+		return PTR_ERR(pcl);
 
 	atomic_set(&pcl->obj.refcount, 1);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
@@ -430,24 +497,18 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	else
 		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
-	pcl->clusterbits = 0;
-
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = clt->owned_head;
 	clt->mode = COLLECT_PRIMARY_FOLLOWED;
 
 	cl = z_erofs_primarycollection(pcl);
-
-	/* must be cleaned before freeing to slab */
-	DBG_BUGON(cl->nr_pages);
-	DBG_BUGON(cl->vcnt);
-
 	cl->pageofs = map->m_la & ~PAGE_MASK;
 
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
 	 */
+	mutex_init(&cl->lock);
 	DBG_BUGON(!mutex_trylock(&cl->lock));
 
 	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
@@ -471,7 +532,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 
 err_out:
 	mutex_unlock(&cl->lock);
-	kmem_cache_free(pcluster_cachep, pcl);
+	z_erofs_free_pcluster(pcl);
 	return err;
 }
 
@@ -517,7 +578,7 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 
 	clt->compressedpages = clt->pcl->compressed_pages;
 	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
-		clt->compressedpages += Z_EROFS_CLUSTER_MAX_PAGES;
+		clt->compressedpages += clt->pcl->pclusterpages;
 	return 0;
 }
 
@@ -530,9 +591,8 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 	struct z_erofs_collection *const cl =
 		container_of(head, struct z_erofs_collection, rcu);
 
-	kmem_cache_free(pcluster_cachep,
-			container_of(cl, struct z_erofs_pcluster,
-				     primary_collection));
+	z_erofs_free_pcluster(container_of(cl, struct z_erofs_pcluster,
+					   primary_collection));
 }
 
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
@@ -784,9 +844,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct list_head *pagepool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	struct z_erofs_pagevec_ctor ctor;
-	unsigned int i, outputsize, llen, nr_pages;
+	unsigned int i, inputsize, outputsize, llen, nr_pages;
 	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
 	struct page **pages, **compressed_pages, *page;
 
@@ -866,7 +925,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	overlapped = false;
 	compressed_pages = pcl->compressed_pages;
 
-	for (i = 0; i < clusterpages; ++i) {
+	for (i = 0; i < pcl->pclusterpages; ++i) {
 		unsigned int pagenr;
 
 		page = compressed_pages[i];
@@ -919,12 +978,13 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		partial = true;
 	}
 
+	inputsize = pcl->pclusterpages * PAGE_SIZE;
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = sb,
 					.in = compressed_pages,
 					.out = pages,
 					.pageofs_out = cl->pageofs,
-					.inputsize = PAGE_SIZE,
+					.inputsize = inputsize,
 					.outputsize = outputsize,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
@@ -933,7 +993,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 out:
 	/* must handle all compressed pages before endding pages */
-	for (i = 0; i < clusterpages; ++i) {
+	for (i = 0; i < pcl->pclusterpages; ++i) {
 		page = compressed_pages[i];
 
 		if (erofs_page_is_managed(sbi, page))
@@ -1236,7 +1296,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
 		cur = pcl->obj.index;
-		end = cur + BIT(pcl->clusterbits);
+		end = cur + pcl->pclusterpages;
 
 		/* close the main owned chain at first */
 		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index b503b353d4ab..942ee69dff6a 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -10,6 +10,7 @@
 #include "internal.h"
 #include "zpvec.h"
 
+#define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_NR_INLINE_PAGEVECS      3
 
 /*
@@ -59,16 +60,17 @@ struct z_erofs_pcluster {
 	/* A: point to next chained pcluster or TAILs */
 	z_erofs_next_pcluster_t next;
 
-	/* A: compressed pages (including multi-usage pages) */
-	struct page *compressed_pages[Z_EROFS_CLUSTER_MAX_PAGES];
-
 	/* A: lower limit of decompressed length and if full length or not */
 	unsigned int length;
 
+	/* I: physical cluster size in pages */
+	unsigned short pclusterpages;
+
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
-	/* I: bit shift of physical cluster size */
-	unsigned char clusterbits;
+
+	/* A: compressed pages (can be cached or inplaced pages) */
+	struct page *compressed_pages[];
 };
 
 #define z_erofs_primarycollection(pcluster) (&(pcluster)->primary_collection)
@@ -82,8 +84,6 @@ struct z_erofs_pcluster {
 
 #define Z_EROFS_PCLUSTER_NIL            (NULL)
 
-#define Z_EROFS_WORKGROUP_SIZE  sizeof(struct z_erofs_pcluster)
-
 struct z_erofs_decompressqueue {
 	struct super_block *sb;
 	atomic_t pending_bios;
-- 
2.20.1

