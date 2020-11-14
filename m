Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47452B2FAA
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP1b6bBTzDqSV
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378403;
	bh=PqK/xJgT/FeUJEM+oVEHpuPbFNSkdDBw+qAntee2rAE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lSF1Gd4rS2x8IpkUkkgJ3AjsG/E7GLc2YCAgeuRNl2vnVXFKX8wK2X+iVJjlUWuVA
	 Bblmql1sM2ZhRnVZaVp7lyU0gXqYkX5y5lXd1uTFV9rJabcbIex51v1YLSQ2AbeCWt
	 DFTseNRl8waSKhD6QoB+EIRvLaaQ+ikAleJZKRNEwZ7I8cGn/SoBLeSiKQs3j9AWj3
	 jAuXjrQ6bT0/f/XxAL0DoG4W5sfLObf5Smp3w15Lhhvllph2s5T62VBACrB7GiYTZ1
	 o+XJHmKtJgFIzSkDbFmVcdX3IImkbGMt0bLhEI96a3Q3F+XKlkzulGJuqz3Z84gfbx
	 lT6gq9vyY53+Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.83; helo=sonic313-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=o3rtYBBU; dkim-atps=neutral
Received: from sonic313-20.consmr.mail.gq1.yahoo.com
 (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP126vrkzDqS4
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378371; bh=SBTwRA2OItyKbQ1pm9GTpmnYItgFtIkI3Uy9NkqkAPA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=o3rtYBBU7bLagzRZ7UAdEtXIyUDja3N/sJm6T8DPRoLQM10DdD/mU98/jWdhSZXT0wo18iL/hAOaUGy+US23yDCOnUtcuPVtcV0fapBADMBYQ+9ye8+0jsUaTucChnPywz0N5yEU7+EKLAS9xEb0HLnl8orwEXfzki8WM1hUyzzjfa1JthpQMwsJ5xMqvHHVmuw1C62RAtUY4hgXl48VMkqxCUg/HBw0enFYJQyd06R4NeC2AYt+wGZ/4qIutXcCFeGfTWlBQy9FNir37h5WjKASNcCHAmSLKuSmsg5/HvIiN+KyVBhPL99FGb+pPFdsK0NzelS7axZf6deEQfyNNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378371; bh=V7JRHKTg8t/KxKAxRzKm2LYM1dw8+KqbdmsD1wUx/mK=;
 h=From:To:Subject:Date:From:Subject;
 b=L22S9EkPvPRJIriZbDSkJkNpq+Thp7vss0bqnopf3v/LqSGirfM1Qp7PFJXTPKWntTKEEmUF8F5Qq0Tv9mH/pjIfGixKQSABMUhz1Ayka60e8bY+76UXs4CJPq8tcR+kSMzWQt2NUQgjunPCqWuLXzx7q5XwYH2T05lH03J30tiVCOWgQcac3I7TeOBNImhrVVzX6mLBuqHEqG54yeA2nEZ5l0jFfTwH1fWM0Ac7Ivue6HaJ70rswUTSjg+13j2/IiP8erZBq+bNsTdpJwA4Fm8wq/jzUXTypPQPSWD/mtoNgUV5qScez6UCz2w8ycqSUN24qWQeFrUpXmCnt2mNxA==
X-YMail-OSG: Wn8PlT0VM1kU13CABp2STH9N3f9Eu8XR5pSMgs74o98jDZRBc7LUtn_T7VAbLAI
 efYa8.U0awGChBUHtaOw6I.Q3WG8lsw0z7WP0ePom2cIhu4c3G6XmTScr65dapcddl2jp7nhoJrc
 R6W6ybPnDwSzPch_f9IamVNtUeZZReqrbbcyyUBpKCJDfAzhC5oBHXmj0jcwwPCmcjUVSNYeGdPE
 DkqnpIM_d8QiLjuAZaWR1u75zVgLc4eAv0_cRAppbfGgB2YFQN.jtoMsoWZp4RGJbsARz83Yahp5
 fskMHPVMwGR2zKHD196DHVwUYHusZ6WqhI6wDvc_52AMzgqByC1JxoDCpBG_oROx3J58gYrhHTg8
 a6xapItb5W2qc6RcGXHEs.9PUE7Qbb7.PhhBrh9VmYzkWTopnkVl_bU16YqTTLVnjN8bckDg7p6U
 PMHZRcXzA2E.RIMYumGiUn.aNeKObYUptInoy3qfweX45uzJd8JWKktLKS...BGRN1XMEY1JZo.w
 BsZF0rnYuQWbhDsL5Ha_Gf0ikiP6h56tIF1PEKDU3LjHKtAGJBKpFyqFi49K75W5RyxsJkKczxi1
 x0TN8nXtv81qEp9KvEwyPdYY9sE58mWDvmXzgo5KuAWb9hujfab9rRkwnXV3tde21pujiheGRBxl
 snqWRPTsEenr_ClgZ5M8nbFo.6fiqcdZVO4EW3i9naoDoh_fktrkMOCbM3anKDQ.Zymu5CaLULaa
 wvJZK0Gbzxk1aPS6esCJmoVTrbWBYBof6u8D5Se9BKsS64oyQVw0tepglKF84s0I81EHtaapXYhF
 7Fsos4ixvtboll4cOu.M0ZhXcBpknI4gu04ZcVLeML3V8EDVYINnxfbfEIn_7FKqjIEYuMUQ8zpl
 CZKB1zMGQtAFPE0zgJwT_H2lu.Dio2zM_Z7hx6jyYazVL0OVxpcFnmnrS1ukYAR_.XtGr0ZXDJP.
 WdkO5p6xiUAqOU1J2VIYS6EoKkxldu8Oow5b2iNF8b3wI5m5R9WaD56xVPrmdb_LTH02eGd2MePW
 ncgbBaZzXPjxkaDyFekTc4rCFVTB2ABsnUQPpM4OqUk_jbguh2OKeDnHq5vmP3AmoRtWaaIgIv0q
 G.0La44PB_YGymLMrbbn4nAX5ljTQdLZrwAKQp.NcFTcmOwtQRTuivLpuoNpJ6K3iBoVBcbHCXbn
 8lUhIex_0AAJhg9.iiaWjT1KEBx6_pmYYqq_SZFruBoFq1VjvdP.WsjTcEinqKqFmFBUuU.UvS_7
 hX0eP4iDlaY77sbKbylV3jJ..5JNQ5Avn7G728Cyt0uOk3Tevi.1VoRnv1zIbmbJIYbChEM2HqOp
 P_q2Q6ChNzqZlMYbMiBUMu.8R46RP.7b6gz.BU6SWAqmhXrZfpKsLs_o5bq44Quj303VJpyre3Dh
 ylmi5BzwmgLAz1B0aUNKF1biBS8DBjrjHHVFXRYXU3dtvtsh4P9FQTjW4Gouvm__Mp99L4APhYsm
 1e7gFBSVYoR68gYQmO4.a3PTWqGxhRJjjoc4LA_2NsXXPiarvJ.ZZcCZKIwkF32GS1ItAZyDimGw
 wqaNpr9yf5KXgdgLh8uj_6kjPCdarD5w3Mo.qyxREJXc90IAurFQezxdjCxchVbsKuy37_nxWfWj
 EkDnUNKJLOdjV6a_DDeDpjbXiufGOYAwodgyXixhWUboiCT9bVdRCxR8lehcu255IGFCrG1VBbwL
 vJgdFlU3YWmhvysLshOA0N9M40fk5ddrg20z8ybvvvrTca5rZm2b2TFW92bgXWl82tBhE65.HimZ
 CGcbNtNZDA76a.Zgs20jeGsmQPutM8dXeuJPCB5tz62jYytItO.KcjaGC3QLtAB7mSRHwHxMn1fq
 bTZZGT6nuwBAbviFsW63aFmeQPcYsUOKdoxYMIxy5Xn9gTg6dfTHpDCT0EXp82om.APJ4t3by1i0
 uWbFMhExm_9k0sxB4kL8k6l6y1q6jfllzl5NJovIlo1rSot524tz5tutnrqOIs.ps0a15ZHoy7u.
 c0FpmKvd6ouwWeSMKo.0TUd2UfHEaoX6akwELttOyC2LAZNlr8Tuc9Ble7ykQHtSkquZ3CextUYM
 eRL6._kp.BocFXKH8Gxm.pxUsN9M1PRw_o3VJn18f20uCBweBDaYBp6B52J3yvpwv7jXar7mF5Rj
 aypSP69VAPr84_DrPcBsbUrAV18GV19BSW8cpBd6QRNNNdoXGZBbgFILnPKXisuOcC3Twug7YIPq
 aFy.lPz30LZB9DxlLbUbcIMLZ1HsRm2g.cqqzCoBchAYJYS4o0imUwVGQmRaWIscFMfuojdFQ00s
 prilrbuey3ouDaLkFjNJuIMZh1TqLKs5NKXN2rvTBdRu6Yq0gtMCtU5NOt5lowwFSyHS.1c37DJr
 oB7fv6BZ6fDrY7rRhu62zHOuYN1KADcBncHipSi1w2xKcjs9.sNBZt093hN9flE0FLBspZp11VHf
 wYaLp4EOZ4OV.c2LPOe1VcG9DUxLJnFgub9SkJ779MnyyaM_bmXJr0hIilfrVLckQDANP52WiefT
 yyeYkmKtShVFQQswgD2GpEcWNIJA3hc9ytLyCX7U.V_vR8pusyvmz7B26XAS5IRNfKhmvzZiwUYk
 essTk6zUypNE3Wctby9L83XpvthdNcyOBkiOuwBDmrBq0MXPWwWHx6kTwTo5FgtEpjY37pkRsq9c
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:26:11 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:26:03 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 05/12] erofs: clean up compress data read
Date: Sun, 15 Nov 2020 02:25:10 +0800
Message-Id: <20201114182517.9738-6-hsiangkao@aol.com>
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
 fuse/Makefile.am         |  2 +-
 fuse/namei.c             | 17 ++++++--
 fuse/read.c              | 87 +++++++++++-----------------------------
 include/erofs/internal.h | 22 ++++++++--
 lib/Makefile.am          |  2 +-
 lib/data.c               | 73 +++++++++++++++++++++++++++++++++
 {fuse => lib}/zmap.c     | 36 ++++++++---------
 7 files changed, 147 insertions(+), 92 deletions(-)
 rename {fuse => lib}/zmap.c (94%)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 84e5f834d6a4..d6e6d60cbfdc 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c namei.c read.c readir.c zmap.c
+erofsfuse_SOURCES = main.c namei.c read.c readir.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/namei.c b/fuse/namei.c
index 37cf549cd2a6..fd5ae7bfc410 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -71,9 +71,20 @@ static int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	}
 
 	vi->z_inited = false;
-	if (erofs_inode_is_data_compressed(vi->datalayout))
-		z_erofs_fill_inode(vi);
-
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		struct erofs_inode ei = { .datalayout = vi->datalayout };
+
+		z_erofs_fill_inode(&ei);
+
+		/* XXX: will be dropped after erofs_vnode is removed */
+		vi->z_advise = ei.z_advise;
+		vi->z_algorithmtype[0] = ei.z_algorithmtype[0];
+		vi->z_algorithmtype[1] = ei.z_algorithmtype[1];
+		vi->z_logical_clusterbits = ei.z_logical_clusterbits;
+		vi->z_physical_clusterbits[0] = ei.z_physical_clusterbits[0];
+		vi->z_physical_clusterbits[1] = ei.z_physical_clusterbits[1];
+		vi->z_inited = (ei.flags != 0);
+	}
 	return 0;
 }
 
diff --git a/fuse/read.c b/fuse/read.c
index aa5221a60d4e..21fbd2eea662 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -43,72 +43,31 @@ size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
 size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 				   erofs_off_t size, erofs_off_t offset)
 {
-	int ret;
-	erofs_off_t end, length, skip;
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
+	struct erofs_inode tmp = {
+		.nid = vnode->nid,
+		.i_size = vnode->i_size,
+		.datalayout = vnode->datalayout,
+		.inode_isize = vnode->inode_isize,
+		.xattr_isize = vnode->xattr_isize,
+		.z_advise = vnode->z_advise,
+		.z_algorithmtype = {
+			[0] = vnode->z_algorithmtype[0],
+			[1] = vnode->z_algorithmtype[1],
+		},
+		.z_logical_clusterbits = vnode->z_logical_clusterbits,
+		.z_physical_clusterbits = {
+			[0] = vnode->z_physical_clusterbits[0],
+			[1] = vnode->z_physical_clusterbits[1],
+		},
 	};
-	bool partial;
-	unsigned int algorithmformat;
-	char raw[EROFS_BLKSIZ];
-
-	end = offset + size;
-	while (end > offset) {
-		map.m_la = end - 1;
-
-		ret = z_erofs_map_blocks_iter(vnode, &map);
-		if (ret)
-			return ret;
-
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			end = map.m_la;
-			continue;
-		}
-
-		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
-		if (ret < 0)
-			return -EIO;
-
-		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
-						Z_EROFS_COMPRESSION_LZ4 :
-						Z_EROFS_COMPRESSION_SHIFTED;
-
-		/*
-		 * trim to the needed size if the returned extent is quite
-		 * larger than requested, and set up partial flag as well.
-		 */
-		if (end < map.m_la + map.m_llen) {
-			length = end - map.m_la;
-			partial = true;
-		} else {
-			DBG_BUGON(end != map.m_la + map.m_llen);
-			length = map.m_llen;
-			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
-		}
-
-		if (map.m_la < offset) {
-			skip = offset - map.m_la;
-			end = offset;
-		} else {
-			skip = 0;
-			end = map.m_la;
-		}
-
-		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
-					.in = raw,
-					.out = buffer + end - offset,
-					.decodedskip = skip,
-					.inputsize = map.m_plen,
-					.decodedlength = length,
-					.alg = algorithmformat,
-					.partial_decoding = partial
-					 });
-		if (ret < 0)
-			return ret;
-	}
 
-	erofs_info("nid:%llu size=%zd offset=%llu done",
-	     (unsigned long long)vnode->nid, size, (long long)offset);
+	if (vnode->z_inited)
+		tmp.flags |= EROFS_I_Z_INITED;
+
+	int ret = z_erofs_read_data(&tmp, buffer, offset, size);
+	if (ret)
+		return ret;
+
 	return size;
 }
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index fc28d82490a1..98e1263fa19c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -108,9 +108,13 @@ static inline void erofs_sb_clear_##name(void) \
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
+#define EROFS_I_EA_INITED	(1 << 0)
+#define EROFS_I_Z_INITED	(1 << 1)
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
+	unsigned int flags;
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
 
@@ -145,7 +149,16 @@ struct erofs_inode {
 	struct erofs_buffer_head *bh_inline, *bh_data;
 
 	void *idata;
-	void *compressmeta;
+
+	union {
+		void *compressmeta;
+		struct {
+			uint16_t z_advise;
+			uint8_t  z_algorithmtype[2];
+			uint8_t  z_logical_clusterbits;
+			uint8_t  z_physical_clusterbits[2];
+		};
+	};
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
@@ -265,10 +278,11 @@ int erofs_read_superblock(void);
 /* data.c */
 int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			erofs_off_t offset, erofs_off_t size);
-
+int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+		      erofs_off_t size, erofs_off_t offset);
 /* zmap.c */
-int z_erofs_fill_inode(struct erofs_vnode *vi);
-int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+int z_erofs_fill_inode(struct erofs_inode *vi);
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map);
 
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 487c4944479d..7d9446b3cbcf 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
-		      data.c compress.c compressor.c decompress.c
+		      data.c compress.c compressor.c zmap.c decompress.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/data.c b/lib/data.c
index 56b208513980..62fd057185ee 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -3,11 +3,13 @@
  * erofs-utils/lib/data.c
  *
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
+ * Compression support by Huang Jianan <huangjianan@oppo.com>
  */
 #include "erofs/print.h"
 #include "erofs/internal.h"
 #include "erofs/io.h"
 #include "erofs/trace.h"
+#include "erofs/decompress.h"
 
 static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 				     struct erofs_map_blocks *map,
@@ -115,3 +117,74 @@ int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
+int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+		      erofs_off_t offset, erofs_off_t size)
+{
+	int ret;
+	erofs_off_t end, length, skip;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	bool partial;
+	unsigned int algorithmformat;
+	char raw[EROFS_BLKSIZ];
+
+	end = offset + size;
+	while (end > offset) {
+		map.m_la = end - 1;
+
+		ret = z_erofs_map_blocks_iter(inode, &map);
+		if (ret)
+			return ret;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			end = map.m_la;
+			continue;
+		}
+
+		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
+		if (ret < 0)
+			return -EIO;
+
+		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
+						Z_EROFS_COMPRESSION_LZ4 :
+						Z_EROFS_COMPRESSION_SHIFTED;
+
+		/*
+		 * trim to the needed size if the returned extent is quite
+		 * larger than requested, and set up partial flag as well.
+		 */
+		if (end < map.m_la + map.m_llen) {
+			length = end - map.m_la;
+			partial = true;
+		} else {
+			DBG_BUGON(end != map.m_la + map.m_llen);
+			length = map.m_llen;
+			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
+		}
+
+		if (map.m_la < offset) {
+			skip = offset - map.m_la;
+			end = offset;
+		} else {
+			skip = 0;
+			end = map.m_la;
+		}
+
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.in = raw,
+					.out = buffer + end - offset,
+					.decodedskip = skip,
+					.inputsize = map.m_plen,
+					.decodedlength = length,
+					.alg = algorithmformat,
+					.partial_decoding = partial
+					 });
+		if (ret < 0)
+			return ret;
+	}
+	erofs_dbg("nid:%llu size=%zd offset=%llu done",
+		  inode->nid | 0ULL, size, (long long)offset);
+	return 0;
+}
+
diff --git a/fuse/zmap.c b/lib/zmap.c
similarity index 94%
rename from fuse/zmap.c
rename to lib/zmap.c
index ba5c457278a8..ee63de74cab2 100644
--- a/fuse/zmap.c
+++ b/lib/zmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/zmap.c
+ * erofs-utils/lib/zmap.c
  *
  * (a large amount of code was adapted from Linux kernel. )
  *
@@ -12,7 +12,7 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
-int z_erofs_fill_inode(struct erofs_vnode *vi)
+int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
@@ -21,27 +21,26 @@ int z_erofs_fill_inode(struct erofs_vnode *vi)
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
 		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
 		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
-		vi->z_inited = true;
-	}
 
+		vi->flags |= EROFS_I_Z_INITED;
+	}
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
+static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
 	int ret;
 	erofs_off_t pos;
 	struct z_erofs_map_header *h;
-	char buf[8];
+	char buf[sizeof(struct z_erofs_map_header)];
 
-	if (vi->z_inited)
+	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
 	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
-
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
-	ret = dev_read(buf, pos, 8);
+	ret = dev_read(buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -68,13 +67,12 @@ static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
 
 	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
 					((h->h_clusterbits >> 5) & 7);
-	vi->z_inited = true;
-
+	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
 
 struct z_erofs_maprecorder {
-	struct erofs_vnode *vnode;
+	struct erofs_inode *inode;
 	struct erofs_map_blocks *map;
 	void *kaddr;
 
@@ -108,7 +106,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
-	struct erofs_vnode *const vi = m->vnode;
+	struct erofs_inode *const vi = m->inode;
 	const erofs_off_t ibase = iloc(vi->nid);
 	const erofs_off_t pos =
 		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
@@ -162,7 +160,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
 				  unsigned int eofs)
 {
-	struct erofs_vnode *const vi = m->vnode;
+	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const unsigned int lomask = (1 << lclusterbits) - 1;
 	unsigned int vcnt, base, lo, encodebits, nblk;
@@ -225,7 +223,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					    unsigned long lcn)
 {
-	struct erofs_vnode *const vi = m->vnode;
+	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
@@ -279,7 +277,7 @@ out:
 static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					  unsigned int lcn)
 {
-	const unsigned int datamode = m->vnode->datalayout;
+	const unsigned int datamode = m->inode->datalayout;
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
 		return legacy_load_cluster_from_disk(m, lcn);
@@ -293,7 +291,7 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
-	struct erofs_vnode *const vi = m->vnode;
+	struct erofs_inode *const vi = m->inode;
 	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned long lcn = m->lcn;
@@ -335,11 +333,11 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map)
 {
 	struct z_erofs_maprecorder m = {
-		.vnode = vi,
+		.inode = vi,
 		.map = map,
 		.kaddr = map->mpage,
 	};
-- 
2.24.0

