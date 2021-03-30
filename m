Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAE34DD13
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:39:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8VvT1BNYz301g
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:39:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064773;
	bh=60hWNP34cG5snRhGdzg7v9lQTAGh/bVJo3Aiiz6CpIA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Jor65LxQvFVJkmBJvpaIJJAnPQq2xScPXYEjnyhrlboqNvVezB480kA5IiIeI4J9m
	 NkpQNm71CjpdslSe4Di1J7oNHwLset5RKOJiuOz8X1YMa78UWVXF4PkutJD+5+F84V
	 3bWLgcLPjQrhBLVZchpTlcaG6mOvnNulhlH+TXGM8QGMw0ZOVXWlFbog3msCbwwVwQ
	 cmTvPytR/OJsN8VtfgGLSZ8NSwC+un4uQd5LZhfUU4E3dbhCEbh9OB3RcMa/OFSFns
	 FkDuiz5xNzlgaDbbqOuIfWWchfydy7iWVPtgYzHUvK2qsp5GBMXy+IJTekcV5hCvNG
	 hxEGy/xgWaioA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.84; helo=sonic305-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=h5SMi9c0; dkim-atps=neutral
Received: from sonic305-21.consmr.mail.gq1.yahoo.com
 (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8VvQ5npwz2ydG
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:39:28 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064764; bh=AHhaNT6x9g2ko1zrOFUDma3YQ6e1UaK+4aHSNHjEi/+=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=d+N+C4+agbH5fqdifDvpkUEc2MaQfK2wTAYqDpzoqZnUDbK+8aIVFZ4lHt0faeSS9dLQYbSIyAh+1bnT7+TjOXq3n44JIGOzlG/RAjLKy8e9fvoLpZk59+eXFP5rfKkxruuXdWorB7puuYTmq1/qSLNP5p8bnc1BCyp0cRT1beZomenpuZWi4N9nilSSdbRVRyPVV6bVDrPOcok41Qjh661nANUlUoRPPaDoOaTrchGruk4IsFk9E5DwwTRu2L6DZKscM9yi6wEtG8I2H0spLxTtXHU4E3ReAY1n8nx3SnDIQNoEd9In9f6NO6RCft2HCRDLIptVWuRgLamPZ07QKw==
X-YMail-OSG: qnUpAOEVM1lT0MlwTyqnBux9qjQG_D8yGSAQARgOTN3Rc9NAqiTjH63x2Qndsj1
 Qt0seLIxFICH_UUZGFs03fzTkwweupbix54akqfbnja3onhuFVI094bNvjZDDnlGmNuTIMi6zLSB
 NYyiej93SC.6hCrnNlFdl4nHmc1LPdme.3wrSKanuId8VONk1PWdoiNveNR4JAS0BN0maDqi.9F1
 MLijpDErMMHvTS7cf8tLAqAOa_8YyPO43yMhzfxOoesym_Rc9o9R79TsTqW1PmvqdSu5G2c68d_2
 ewmldlbKSzuw9BF7YwLKQU0WTHH0dL6yeIbobLF.EBQM_Jp4vFEJwQYc16pbjUXTky4e3AJ6wtM4
 vhUuB_umUlcEC9OtuY3Ko_QjhTVqzfcqmlK8eOdHC1FqxTwVOiFc800uJcUSaZyLIANN5NrhzvNl
 s6xfOL30gDiRy3cEJL7actU13wfdA4AcO.p4Lwg3xj8zXrACUceL8JpITlCJttzCgTi2VKKERJpE
 rO1QzG77DaKVwmFI4ChM4HtiF_2ZWHYedQgjU8.F707WngR_24AF_30kKJXBLspF5M852wKY_PtJ
 dlGNyF6gkA8w4udI9nBRNuQGdDJla2hyEAT_5bxR5f81FpaPvlW_ywD8LH_VKa3BZzMRYFZkzvP.
 k89ZJDPj6rTVGoFEpZNipVolNlkh9yd44UwNChssxtD7p6_6Qo787QLutCosQ9U6Zn14h6DTPHB9
 8TP27ADkc0lO45F5RH7hmTg0rZlLW8qfq5cLqomuoUpjv3FguCv7Lgajh8LiLHTxjbD6TDZDmbL6
 V9vnvkSwjTNxjQA.jXccUBMy7cDg1tsf87FyWYPsgD548PLWniSPJ0h4Fuz060PpNmA2iIiDQUQk
 _TDRsjftVKrCKk4Cxfkkq37x8yghhJEd3_v_eVk_LWFf52v82PN88N0f3eGs4w3imHY9vF_IiSDT
 Ju1U0Jej1Cwe8KlBFUlyAXaWc9HUoenVCzKcscub4bqp_.iKgByKxgS0fDhstV6to8jlCwTCLHQ1
 LW1ApvrhTuUVneLlpBFn2FFjaFm6An.qfFvGP466yqkujw.P3KE6Sp55Y31DisgBLrInXCv8HaXk
 HHDU9OVl331CatIzHWRe2HI7qWw9Luro1ITm8_x_mIshjlTCqiLzPgtNT5OmK.OdpyD2jHAzkXJP
 nYerO0HiRHZjZIgMSBRb.k.ObzbwD._xIozOWGmYfdUmH_QyGORvprZgycvmKFCrHQge39m4_.QH
 hHg.uOuB8iPHmKOWT8fJLPG8QZfaSj4iqb81a0eH1XK6cknCvhvgn7O82vxyoj4SSaWMfnJDrKri
 .m5G89J4Gv9JybSWsJHEhR9BxSqjkohff18dkUBEzgRjvysVOqJMNh.rZ8Hf70B__5Muecpb8R3s
 2XK6kKaeCysyeywr8sTPQQRTHI84yiRXVMMhmOEL.HuJ3EVSnJ_1aiFy9NMHEHy66xhny6ebUgyw
 nB_RIw3HQX.PqoAA_cfJw3OeH24T6gBMVmSe4.DvQhHnXejSjc405OSVwGFQTl4pLjHCSi2vmVzL
 ieSwmbofUwacdH88H1wY0y3QWD7mwloMzoKS4KT6cr6JXtCdMjLdhFCfz8r7rzMYmKMw1WPZVSmJ
 cKBXz7sYCaGlDEDKsDHIpdK3oAkHSydUJOs7QeJJm8aYV2Gf1so0RWtn65JJqIpvUdYu0B6Lfwqd
 r28UD4n6JSbDHhWv6Umu0wDTUpm_o6WJoD9tnu06dWcYeoNIKBRbmpdbWYug0hqRzGRiAWV89Dgt
 gS5d8MOrLcSjdJm5WqyQvZY6HG_wk_3auk4O5HlZ9..G_IT1fQ3NGyplbk6VSo27A0lcm.1nBq74
 Uo7mbbmJ8E6kUJcVaH8uksgvi5X4KWYwiBezaea3ayuB0OcxSD8HdZx_i7nvQYV4ci8rnf0JVu8D
 3BKWt20b5yRdHnl752I6AlcIXvKFfDnv5_h.T6Ok1zV.pCK6B3MPLB.aAPe6YKcvNi000u97MIKc
 piH1_dl4ZLCSVv9TP13m1EngDQsgmMXzObzYAPYhm24nr6fAFZxXgPIfIfYhs8uN5rk_BrQ6OrRl
 R74ve0dvY1jaX3ksBsAi4GGMetoLdDgt4nYDYPUnUXKjQP5Mnm6RXQDtL9OgUGKxJrDBElD11ImY
 M2UubBdOy6Zy7Umg6Zoz6m7xeVE9SMbZR1j5hnyJwKxM9PZozG.zqtJTHmgcjm4qxG26ImSHj2h1
 zGywSPcEOPIWqHee5tKl5geCiYBu5KRGtPVOrDhiFhAG6HB8zLDIac1tb8DuQMP.uFtoSE1r.HAt
 55Pste4YaPhM.WyAlB9v4ogSGta.lgd3Z8nnQDucUemyRqvf6sSZ4UjXv6nDP7ExSPBBIVf5vMtd
 H.cXYWNAV5TTDyx0QYX_3ddQVnIgIiLJkNUm6M1vLjCYMFexvu.o3rdbZl4nmSjo5MyGxxuTWYm7
 f9XGjq_ZoCfJ2GG4ONqkeOXw012RXsNCr7_4zVUDZ58ReexJSMMXBUKJZ1.qkAHpc8PyMpt0.ROw
 LZvAq7C55XO3cAF5EThA_PJpeLeaT5tjEY82M2rlOHriG1ciRo3bHXxE2ksmctiYyPIyykGtxxCU
 HMsJw1e6TSQpIxoBIdRjVM0.NOBs_gOZshPs8dlxWSj4Tq7lTzVnRfaDU_FtjDvcZLw61GNpcfin
 7PIdFhtPve_zPviB6_uGXzhWtMarkdS8PY1UAxKUldnksBZCDOh6Z2FS4rTEOdBf0XgOFgronZJu
 ai6Uv3oqfNpgt.W1v4m.dihknxyXizr49mLCzDdUIMpx1ycyC1EvN29g3e18sQ_77R9oWJsmSvIP
 5RHIK4csAgXPgKt6K_EYHCrLbQexDeYKaqoGDB2Hh.Sq1Hiodf3VY5wxXcVBF.bfvnrcNQ.mIYw5
 .ZSTHzERTHHJ1HVhPHLUeepsJ2QZNp8XJgDzCmO5HxcpfEZ63qPA6kFwKJ5Lnq1pAR8olbmwMaH8
 sfG9T.98vdtIv1_z7jyUTIqMpBNVfxw5.TDSDUInG1rR9FOskcfdbhnbo2DvkL4zcsSMLZIFUPlz
 hSinXGfECHkszv7gqh6hsmb_MvHP1rTaZfkYo_snmfAI4rD8DGwwXs1CC6iiagdwlq0rUAT8s9s.
 70PvMn.7AFXzMxR1Um4b0M85QtGxQ1D5hvJMENQ5htAtV.axoBPhCmrVMdeX6a4dT
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:24 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb; 
 Tue, 30 Mar 2021 00:39:22 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 01/10] erofs: reserve physical_clusterbits[]
Date: Tue, 30 Mar 2021 08:38:59 +0800
Message-Id: <20210330003908.22842-2-hsiangkao@aol.com>
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

Formal big pcluster design is actually more powerful / flexable than
the previous thought whose pclustersize was fixed as power-of-2 blocks,
which was obviously inefficient and space-wasting. Instead, pclustersize
can now be set independently for each pcluster, so various pcluster
sizes can also be used together in one file if mkfs wants (for example,
according to data type and/or C/R).

Let's get rid of previous physical_clusterbits[] setting (also notice
that corresponding on-disk fields are still 0 for now). Therefore, head0
and head1 will be used for 2 different algorithms in one file and again
pclustersize is now independent of these.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h |  4 +---
 fs/erofs/internal.h |  1 -
 fs/erofs/zdata.c    |  3 +--
 fs/erofs/zmap.c     | 15 ---------------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 17bc0b5f117d..626b7d3e9ab7 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -233,9 +233,7 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-4 : (physical - logical) cluster bits of head 1:
-	 *       For example, if logical clustersize = 4096, 1 for 8192.
-	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 * bit 3-7 : reserved.
 	 */
 	__u8	h_clusterbits;
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 60063bbbb91a..05b02f99324c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -266,7 +266,6 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
-			unsigned char  z_physical_clusterbits[2];
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cd9b76216925..eabfd8873e12 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -430,8 +430,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	else
 		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
-	pcl->clusterbits = EROFS_I(inode)->z_physical_clusterbits[0];
-	pcl->clusterbits -= PAGE_SHIFT;
+	pcl->clusterbits = 0;
 
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = clt->owned_head;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14d2de35110c..bd7e10c2fdd3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -17,11 +17,8 @@ int z_erofs_fill_inode(struct inode *inode)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
-		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
-		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
 		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	}
-
 	inode->i_mapping->a_ops = &z_erofs_aops;
 	return 0;
 }
@@ -77,18 +74,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
-	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 3) & 3);
-
-	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
-			  vi->z_physical_clusterbits[0], vi->nid);
-		err = -EOPNOTSUPP;
-		goto unmap_done;
-	}
-
-	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 5) & 7);
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-- 
2.20.1

