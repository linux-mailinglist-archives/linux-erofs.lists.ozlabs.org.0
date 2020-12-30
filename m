Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DB02E772E
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 09:48:24 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5Q1160y2zDqJM
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 19:48:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1609318101;
	bh=hZ2iSDfBcW/bq1wQ4SUvJsKQ5+FrReaH4de+NeDfC2c=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=e0fq2hNxa8DDVqJL81uEAEdxfiWIKf0wD/RhayE8mJqWUpHQTrGtTaqzs5T9efdya
	 Q7xD9uSHtaZJQlhZWXQzzYmJQzjjySoRmNw0zw6bCZpeVlMIXNQDsn4bl/mz7UrLLs
	 pschSL5AqDoJmEQH7YHujR6AKClzLxUFlUu4zg6LAE73eXZcVDwYrSUQPZHIpbvgCQ
	 W4MlAHDGAkCPjRzfiFEUfrsqXmiFOt+VgfjetkSITY9qvwKJuAA2bqZW8HqQUwq6Tt
	 9xXArwI1TBwhg6kcQUITXNrFFuZC7cpjYxiWxN7NRvWFQqMHvizHXcSrmxR5GyCqmV
	 UPlT3opTayuJA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5Q0Y6zZ8zDqH5
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Dec 2020 19:47:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1609318075; bh=Bi9ULZHz95Ar5zOwefLAStN5FqE5sf9xwuUPYP6Up5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Z9RKg5KTNN1D69NSgNb2R3AH1XF/BbpLENsvI9h7sW+dfLUQ5cnEot3ayxaAGrtmgW61j7B8t6b3BXVv0Csi8GZ1jJtd2ywu2vZ0oKXVHEfnX488fV6AGEhPgSJaASklnHY27Inz6djUgPUzF7iw6D2WDEEyBmwho7N9e08lulS8kDxLZpRh5g5JDKkHjFuOBo7OzMmzmZ83hjdDwAD3Flz0EEula9PfuLDZkixuEX1aeXh4x6Sz2RTpHzTtfWK5DRb2t1VwYvYnO9Pbt7m9PAu1ACkHa/tLGgHdwaTeJgMM8B+ZEuVbnDNcSVaSlkVgtAdhDBkfjVGKz8agtvhZKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1609318075; bh=HnGUo4Rb0RYYCXd3W/JFBq5odSZmLKWd+zTLl+lNDvn=;
 h=From:To:Subject:Date:From:Subject;
 b=hz1W0Rzry+hLOzCbNwVdzD13bg6s0JabazNkz7Lx3dXJXbUUtSMsMMcI3eCLE/U1B1J3ri7uxtdvVAahY9olrCPd2tMupmAme2WhKxA3CSbJjf9MMPOEoXONn2/IT+Tw7ebGUCRnLuvhqAQxqSG7I+jBkxSI6c63qYzGjnhiLCgqAq362zQqmtTkUwNa8PchW0XjAVrcsKCXp/GuEx3X9ds1karOwY5LWNDuXHiDrtEbPUeV9s2suT/JG8ynGtekumUdl1O7fZ9mRUdgGeQNjBD2T5K/VJ/9Cg0+O9hgGi0NvI0LddGw1KeDg5mKLBOmd7H07TlevCwgolXTGvFDnw==
X-YMail-OSG: O2KGn14VM1nCUzTTkOiCcXRcTjtsNYByXd5ZaBk6KIaxsxCfNWH8AaosFZsld_b
 zW9wDxzw5Y.XCS0G6GVmLMWi8CHTZ7bDl3Ew_ztdcNpZJyF3NmKKSN8ix7GCTW_Dghx6HnyWTs5P
 tGWfrVfh0iwTxYS8EuFpWP3BMuyQ7nWqsjAaE__HRJoDLp9JBFF6YUg9TjxFPwQnySLs1APrGp1a
 hcXkRFl526bFqXF6ijxZEZcX0N_BbFhaAqvXYCK5WoqsA4.Bj0HRycRtKrUAh4n1eKUbHT0xDUmm
 _0Kz2I2MNk6he5BPMv6xCqeDv3xN1uYMsAirDw8_GWU22RTvC0_yS_BHEx6oEwuNlX5Q2O4SMHmp
 hooL1rSsurSSI7LrUMFl.ErN3Mu9eatajQf12xXCFqZygGskTs9o.VZS71R4dIRot6GfqetzQKBX
 h_2DBBgY5Ji8IIYUZwA1zJYw9DasalCGiU7fA3fYVA8PCE0SqYu0NJm4l1Wp1dTB_jtJbfwsFu9X
 8zU0JTjf7vel.i0pkd0w5E10DchfTJnB1Oit.R2l18PKhnOlwm8Wkejf9vx.kRWgryJSLlAByXGW
 yuHiSfMhi7uDPs.7dBX.f.Ul390NrDyTSaiQPuECYbJvdbrFgYPqTscvqYtegMh1q.Cs1DN6X4Iy
 GI39uvkQGGa1.Ru2mVeeD9Zr5e2vh1_bKz_5hZMj19F0vgyQxorZy9nfUyVj9hZvsF72sQXf7ij9
 GZA6n99GPhC12mqYu04vas6C7_E5qjTJ6V_fJfPyAjLYjJS1LVwpSIvGmPvrqgwEzVQLRmjuno7g
 8TsTbTzdg5FDSEDrFgYh9d.KlDFD8jvhW2_IWSHI6L4hcd5hBqsl4KU5stQDvdXql6Qagg2df0gK
 E2R6NzTnWiZQ6aNv7VcmV5jsxsUIMla7axcQKhjO3p0kmPFirooFOj2AJsbjnmIpeQmq1RY2BZNE
 8fvMdNcr2Y0h7iUg_1kbIkaUIrLQPnKHIi4Yxjo7tJZylB5rV5QZWeY8X5LBbKzJevhJS2YQTJ1E
 UXJW_dCQqT5bsi7sRTHiRKsZJOEeKT5EJjOyr1V2J2Vl2yqy22qNm7FljDpIhEdVenc48X1IcrdX
 T.pfH.LPEEemOAZPSc1sHUHnTdlHIKzcNIYGm7ClLmv4sK.a4g1Xw.dNwuknEK01rbwkUbT6uMV2
 .ExRcxyOFZBS6enS9DnZHoahmPoadhf7k_.ASSzceG_mFJgnGASevKiJf8NUv1S4NCK.G_7tHeOx
 W_8aOcptbKkbXRtANB.hvF9AC0jrN5ULYFxIcXx1gk9TRZUk3hq8JpXaPPAqnmR.KVSojTRKgiuo
 JjO_nQqE09MN8AzAfq39CRwzZnf5nKvNRon1Ghhez7oo.usdSPsYtDGBkjJ4hEMxcGyIkdIEzqi1
 UHGO4lbnZnIpAkayH71ktHbtOgKH1OjAgOhpux13LYAEqDlrf0kcIzEeQDdXnlqoufnW67IRio2N
 15MvqN9E3NB0DWEqP1fEp7WitRZQPvX2bor0BgakH9c3yzdWGdgv9E4LkNFjphrlg2sKME.6kkC2
 2L2SlXnJ1Cx4xvkSopaRw2tQEho8yGgKahacqKSeocSbgMGlb_T.Xwi8XoZBhuwl7Ly01MoL34go
 _vycxc5iYFMwxbNKu.iSt_O5iUHJsVz2_YQVhUiV1TNqq9Kyiap6ruM.VD97TZczAaR7UAuE.Kd2
 J3glCOJVQu2OaHUbnVMh0BEEZLg04l66hfKTKxBfF_q2YfS5EFuY6IJAk0WLzMgGLSfq0mX3E0j3
 0_gJEenSGHT1fKMfSzSR9duuyFSt0_tZVNCbHYnt0ONBYphY_zUyWZbfySoPWgW67lhrqA.zRIQE
 BQMZBIAoYk64pa_k7BwiDt6indLnjShIl7vjBWFYw68xygql_6DTbpcKRVrnDJwwVYuLNHfa2FR1
 lpujMn.M2ChOHqee3c00zBrBu5Or.zrS.qQOkZri3RucntKu0VPLCYZWrHsQSFIREetHtXLJJCn4
 0B1RDA2XDsjHOrKzNTXCbef7CVLq09EYZvMgQ1E7yJDV4SaU.36JBiwpI6jUApg0FxsvddrPhqrs
 Sq31I9VDF7BoUTvgkn.3Cx0hxMh9bBQkaLYxnK_K1HQi.vS8Ps979JhuYsevYsWhg5pwNmHrpUAt
 DDDNAH62_XgGIFqB5lWrDyHFDWRLzz63JbVtyfkB6IGs8WIGnPVRc.Uwr.m09oHzw622ANOstJBj
 8CVumzMycYupHf0xW5deZJkqPjwcUFCaAJdQSDtw0piHGmQBONbsj.__YKi9viMINn.rvGnJ0JMr
 cJgTsSTWsRN8XgMRow5Mkres56.O3KyPNwaUqUFAJXK5tN4jtuTJPgrKgwbloPaapTS9d9meAKCK
 UT7m.iU7c3WnsbLrgMnlBJpFctk4LOJLpLVGkaL6DI7b6ct0qkK_jWuipFrp9GE5Sz7FdA1tdXPb
 D2wRRBSsMzi4__CsNPRv.MMDhMTJRMBCfBQLw0ToL9g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Dec 2020 08:47:55 +0000
Received: by smtp416.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 68e206c49d6e76b1b6872a88eb7f98ec; 
 Wed, 30 Dec 2020 08:47:53 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 3/3] erofs-utils: fuse: support multiple block
 compression
Date: Wed, 30 Dec 2020 16:47:28 +0800
Message-Id: <20201230084728.813-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201230084728.813-1-hsiangkao@aol.com>
References: <20201230084728.813-1-hsiangkao@aol.com>
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

From: Gao Xiang <hsiangkao@aol.com>

Add multiple block compression runtime support for erofsfuse.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/data.c |  4 +--
 lib/zmap.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/lib/data.c b/lib/data.c
index 3781846743aa..b330a91e4e34 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -127,7 +127,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	bool partial;
 	unsigned int algorithmformat;
-	char raw[EROFS_BLKSIZ];
+	char raw[1024 * EROFS_BLKSIZ];
 
 	end = offset + size;
 	while (end > offset) {
@@ -142,7 +142,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
+		ret = dev_read(raw, map.m_pa, map.m_plen);
 		if (ret < 0)
 			return -EIO;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index ee63de74cab2..096fd35cdeb3 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -14,7 +14,8 @@
 
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	if (!erofs_sb_has_big_pcluster() &&
+	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -37,7 +38,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
-	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
+		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
 	ret = dev_read(buf, pos, sizeof(buf));
@@ -81,7 +83,7 @@ struct z_erofs_maprecorder {
 	u8  type;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk;
+	erofs_blk_t pblk, compressedlcs;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -130,6 +132,15 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = m->delta[0] &
+				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
@@ -333,6 +344,51 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
+static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
+					    unsigned int initial_lcn)
+{
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn;
+	int err;
+
+	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+	if (!((map->m_flags & EROFS_MAP_ZIPPED) &&
+	      (vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1))) {
+		map->m_plen = 1 << lclusterbits;
+		return 0;
+	}
+
+	lcn = m->lcn + 1;
+	if (lcn == initial_lcn && !m->compressedlcs)
+		m->compressedlcs = 2;
+
+	if (m->compressedlcs)
+		goto out;
+
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		DBG_BUGON(m->delta[0] != 1);
+		if (m->compressedlcs) {
+			break;
+		}
+	default:
+		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
+			  lcn, (unsigned long long)vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+out:
+	map->m_plen = m->compressedlcs << lclusterbits;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map)
 {
@@ -343,6 +399,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	};
 	int err = 0;
 	unsigned int lclusterbits, endoff;
+	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
 	/* when trying to read beyond EOF, leave it unmapped */
@@ -359,10 +416,10 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
-	m.lcn = ofs >> lclusterbits;
+	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
 	if (err)
 		goto out;
 
@@ -401,8 +458,11 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_plen = 1 << lclusterbits;
 	map->m_pa = blknr_to_addr(m.pblk);
+
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (err)
+		goto out;
 	map->m_flags |= EROFS_MAP_MAPPED;
 
 out:
-- 
2.24.0

