Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3A34DD1C
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:40:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8VwF08ssz3016
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:40:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064813;
	bh=qiTfNqdFHlGJEG4movMfodOwEGyD5ToQ7ohERgIOeT4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HCj9aWPZ+F9+PedPDE2ZVyc6vipJTiyqhUMCLwVFeAmvZcuBSSGZ0XTfYAIlA3Ax3
	 yAgU6colI0gBcbAxVgklp0ZS3jUT6L1sjmNDmj68VsrkAdQ4nUOFvzI49BPSwUWKCg
	 wXiUWCUavgPgfh6Yi7kZFMSsFzzVQzp6JjxlFHJ03H6SOnF2BSTGl1yAcG9VWXNkvm
	 BIhR1lr94plgEMimY/Ot54qAbdn6mDcmhIzzbbNcR+oueJJ7qts914BDHJE7+IN0k1
	 XG4HG4AatmVBFs5xy0894o8bpXeZXhJyFPSmOz0TGxdFrhxvzgVh7Zzoju7DJsntRS
	 kRz9r+s//hFbQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.32; helo=sonic308-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=oMpxX56B; dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8VwB6P4kz2yRK
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:40:10 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064806; bh=043hFLznkXC16Fsym8qQwt5jZvMNyF5ajEliT9MQ7v1=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=CpAjsoLDugcgknPzkTVwMm4KST0DKLTEL2JL4KdTvPfFffWX77+LQ8yFHXfOY3wI3J9NfdurbnC89o0VSO/TdBs31tqBgmFSW2FWSkY2s1mLQUdP6WLiU5og7lHpBIIXGyUH6a8HBI++imKjIY21uwSI2eAyV/RAMlQPKrPe8Uvp1WudcawYB/0aIeh1bTLlfE74xnOiRGjR7QG94vAFcUknBzVtj7NAfPZg4XflR4wBwWsJKN6uiKoE2v06EqOY9nJQHIDjBDoB8QbO7H1MzdfacCK2SetLb7om8zNQErm257KbN6+/H2Kdr3vTKMbil3OX6JkVTeivoV/LqfvMag==
X-YMail-OSG: xVke46oVM1mOii5n5emxpQnwW5KbxMd5NtS4bLxYyljrew4ROOzHvEvTgnquAhL
 kzkzYsLMALA1wFTGDz4tNfafqqEn1efwGrrY6m7xrVKht.7PW1qmlalXeFobDDFUMiWIEaDPDEgg
 PPS_ON1mVSmd0RsX8Tw0bVoSLQfkBrjwf390WiEu_3EdauBKSJ7bTzrMAnwGAEUzJFiDJqZc_PY7
 beD4WpjXjt_.DOtrbmNu6ioyEiJMVm4eg6ILN3ueBshWZwZJ2KqNz34YixT08z70IcxAX21SepTC
 LQdgOslc4p5zHt_lCrcgOSeRYtpzyrvKdUZAM0wI2XSfn23Cpydjb2dTk_Kpy2vQjkljUhjjX0QG
 mvYSoL9reDKYQBfPY6n75WXX0tPqtoUcYQ7VrTXfMMb1xlmT1zUc0LJKo79OeoztFz9I1KxiAMLq
 ABDUBTB_alH1n8iUw4WXnJfRnW7oZq4dIZV8WFFy5j7KEwPpJ96vOLUPMo7vmovkcElZEFrqrtZc
 5nkDDslhlMLelyue8YppsHmVHE652Uby2MabLgLOVY64FSYwuJl.YPL4RuxdJi6WPdOb1A6yssCI
 wfOZq4YeLRWYrVSrOSkN2pk8oZ3Xvg6LsSv39R2_lRE5qvXdBdBg1C0hOa_MTzWhrbWCbscFg4kK
 JCBeR_CGs7sGM1t0URt_avxpmiKXGthmwvsU_o0fYi_UkbfGrDK5PasSYkjduGgRTXZXxarn4_Yk
 7clQCZ0f3jd1Qg5PSE.0gjE5_D2uM7i69qWYXGRAbkjTWgWyJcnPq10q7vzcr9gtdKcpQp.BjT2V
 gzYEqyzTfo07lyqHMVXhMPO1tGKdjPPRY4UnfqWdjhAjGQfM.Vdg8cnGm3afl9TmrKZTSqr_IA0J
 dPo3DiPamjJIq0vqXKcfr0IJfaP33yiwA02qBeDdu9juzWMPJywaSOVkdeDtwiRETJJut5XiLSgz
 YPa2ZCdcDyPuucP6rOp9XMJL1BTNvFe_uDl0AerpmzF3E1OhV_zxKvfimgBvq1NfqpNiTm99rOYL
 O2X7tc_95LWmV9sMMZrIQ0iVkwYYUSCrOijVFZEFHJCH8.tfcRaanDGx0d4io5gLJmVbQazcOkHX
 cNrYbpP0zob5liYxE_MvAZlHBP6UrhoKk448G7R7Sy4KH32ODI6qdveQQ2ETseMkZiiQqaBxp1k1
 3m0B3WafQ7Q6pwcet9IAa2PvvrDkGjmJHUQhlMrgc1yRK0hLBZasbPgAx4tGQflgIeBlY5e5QCDZ
 QJzYkNbmTpdO020yL3z2cOO8ZGJqhE3v8GFMqlLlZAqp7OUnlCELKXgwt.234n.1t8biVJm79gIJ
 APdQrHWdVDwI9SiY6tJz3nF.wP7XSwrITyC1xj6gtRZ50IzMgmHxp0EJuptrHYBvEVc1QzQq0ep.
 .lu5dwteiC6ehGS271afKtkQjiv41ehw7s8Ps.XxsdKExNxKF6wuJ07g1Y4Tq1estAf2uXI0MuLJ
 59hA5l2PLszwcgwyaV6.3bcFBQMCOVAEd5mPwy7yTeSSOTRZrD9VhP9CvbQ3zO5phaUHBHno6nRd
 Zp3UL6EpPs0107uvd5xksXbPRq.nWyZUXSnLiZCYI7QnP6k4yppQDa807c85KZ1WBh.Ru0VHOdQC
 f0bbG6lfEHm8xDsb3pb7.EkuolEEvGLhJ6Ay5xCYfYZqoblARnCiOitddnZCj6st3B06yPYC_OPO
 vQbjw2Ok_t1X.rh_iR7u_azcL38.hBf4urT3UDNDqJ4XAGsKDEUhECr9hlOObv_bFOTwP1OUi54n
 bxXhKAsWpxmdWD4lwFBKzUcjhUHX7FgipeNaAaEyt72Ha0PHhUC.WK0MqNfZZEFdVVWU_qDEByjz
 8NUxVWEr_XGj9_wEpoBk3yZVcFuApcPce6_T7wlNTfM.GO2dKHaPa62MPLCfa_oiHRoxsUWWeeja
 kcd.zBH9sMBaIBvUmP8ISXZQtRNWB49IUPh4PmLdMlVG9yBBsehAlIQCtU.G4EKVJooo7opJVqA6
 uDYVS_hcf8ECxz4Thz2tyd0TFbxQDrIJ0ZLKcYeR5QSA5oSUvphg9eIK7b3BQ.GBfTg_5VEgugn7
 Dn.6ReQgkmI6WkzJDqPknTpL1S7qD.e3mV5FkHHnmGi2E1MVwd0bhPd2uUqLTVZjAlcGTmFbJQHx
 pKuL8.MeB7a9HuMRE7z918XOHHxP1ykZChl7hcashbbZhDE3S1RT3FNt.80GRKGBcizUn3yB.41P
 goO6xbv2UhKYix_Du_2gbYlYhytbywtZxKB5fM71GQSKM7v5g1sy.M.kZVhWDiOqnH.Fz0pn6.yg
 K0j7OcgFnpkI4B_vNGZdAhU58C6oAlFCmmUEJbfu_6RXre2RHPhsAXjkEQEAiFklnq8y59JDM2EP
 8FF7aRbBX.vXfG5feWtzU_zGrTT6ki7pHLggyPIVi9mkjpsjGdbeEGVUWDC1yf18tsiI1o3SypHC
 TYRQDQmkpPkw_jJlZEXy7X8p_yDsajq0sFNMS7bSuO5VN_jovgrwJ8j8zh1eDspDHgdQGzFV9NqP
 P39VoQtur3ZCqpsQLx.TQsZiKFZM_tVgEltSs0a6hkn6X4V8z4l6XiPysvHzSO458_dLmOCFFAi2
 mGMCT2SHa0KdQOcJWLRRz7ONpfg.JB2PM83a9Cc0wrcVXVvOzUG.j._iL3puJVJWmmU6a.biSWtR
 iNEcEqeoMKyUgFBL_kZXYm17bcg9NiPLx7yZ61mPn9FcFS18ZQTEDbKhzXqI81OjuhlLC4F_bkNz
 zFPiUiVcxoOdrYoTPi2Fr1unYdCvz8plbU99kiXmhJi19XDs6jxl5NaXk9dA5NNKO7U_Fr4Q1dF0
 dDUPYFGyfknJeqv4xwH7ZlgqO7_JuF4h4wMYXU9hv2X0xXHHTgkoLe9A8wfOnzRP0PzubGBebIw0
 slz_yJVVEM_gokJSRrJ5rrY2gl8EE2el9tWTvSMYftN6puZf12szImP_ACnfjyvYJONLSXfDUDG8
 JuPyKbxkqCfqaDKRzi7tXD5DhDTToHKOdBe9TMc3Dt.Huw.VBOP0jPL0578SZ63hkmB7xUgRjbq.
 tPEAt4qqp2C6XI6TS_qKQYBYTGvJik6ShpmRcqtHPjvyTkUkswPlury_moXykWkyx4jmMPIHsf9h
 gNbItAdSImx4BbS0XrNw4f568zpzUuA3l03ooxMFCQmXXgW8gIc_iPABjETy3RSNmnfoiTxzkK74
 5daa3xqR5
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:40:06 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb; 
 Tue, 30 Mar 2021 00:40:02 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 08/10] erofs: support parsing big pcluster compact indexes
Date: Tue, 30 Mar 2021 08:39:06 +0800
Message-Id: <20210330003908.22842-9-hsiangkao@aol.com>
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

Different from non-compact indexes, several lclusters are packed
as the compact form at once and an unique base blkaddr is stored for
each pack, so each lcluster index would take less space on avarage
(e.g. 2 bytes for COMPACT_2B.) btw, that is also why BIG_PCLUSTER
switch should be consistent for compact head0/1.

Prior to big pcluster, the size of all pclusters is 1 lcluster.
Therefore, when a new HEAD lcluster was scanned, blkaddr would be
bumped by 1 lcluster. However, that way doesn't work anymore for
big pcluster since we actually don't know the compressed size of
pclusters in advance (before reading CBLKCNT).

So, instead, let blkaddr of each pack be the first pcluster blkaddr
with a valid CBLKCNT, in detail,

 1) if CBLKCNT starts at the pack, this first valid pcluster is
    itself, e.g.
  _____________________________________________________________
 |_CBLKCNT0_|_NONHEAD_| .. |_HEAD_|_CBLKCNT1_| ... |_HEAD_| ...
 ^ = blkaddr base          ^ += CBLKCNT0           ^ += CBLKCNT1

 2) if CBLKCNT doesn't start at the pack, the first valid pcluster
    is the next pcluster, e.g.
  _________________________________________________________
 | NONHEAD_| .. |_HEAD_|_CBLKCNT0_| ... |_HEAD_|_HEAD_| ...
                ^ = blkaddr base        ^ += CBLKCNT0
                                               ^ += 1

When a CBLKCNT is found, blkaddr will be increased by CBLKCNT
lclusters, or a new HEAD is found immediately, bump blkaddr by 1
instead (see the picture above.)

Also noted if CBLKCNT is the end of the pack, instead of storing
delta1 (distance of the next HEAD lcluster) as normal NONHEADs,
it still stores the compressed block count (delta0) since delta1
can be calculated indirectly but the block count can't.

Adjust decoding logic to fit big pcluster compact indexes as well.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zmap.c | 63 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d34ff810cc15..480197721061 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -77,6 +77,13 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid);
+		return -EFSCORRUPTED;
+	}
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
@@ -207,6 +214,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	unsigned int vcnt, base, lo, encodebits, nblk;
 	int i;
 	u8 *in, type;
+	bool big_pcluster;
 
 	if (1 << amortizedshift == 4)
 		vcnt = 2;
@@ -215,6 +223,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
@@ -226,7 +235,15 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->type = type;
 	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
-		if (i + 1 != vcnt) {
+		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!big_pcluster) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+			return 0;
+		} else if (i + 1 != (int)vcnt) {
 			m->delta[0] = lo;
 			return 0;
 		}
@@ -239,22 +256,48 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 					  in, encodebits * (i - 1), &type);
 		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
 			lo = 0;
+		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
+			lo = 1;
 		m->delta[0] = lo + 1;
 		return 0;
 	}
 	m->clusterofs = lo;
 	m->delta[0] = 0;
 	/* figout out blkaddr (pblk) for HEAD lclusters */
-	nblk = 1;
-	while (i > 0) {
-		--i;
-		lo = decode_compactedbits(lclusterbits, lomask,
-					  in, encodebits * i, &type);
-		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
-			i -= lo;
-
-		if (i >= 0)
+	if (!big_pcluster) {
+		nblk = 1;
+		while (i > 0) {
+			--i;
+			lo = decode_compactedbits(lclusterbits, lomask,
+						  in, encodebits * i, &type);
+			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+				i -= lo;
+
+			if (i >= 0)
+				++nblk;
+		}
+	} else {
+		nblk = 0;
+		while (i > 0) {
+			--i;
+			lo = decode_compactedbits(lclusterbits, lomask,
+						  in, encodebits * i, &type);
+			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+					--i;
+					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+					continue;
+				}
+				/* big cluster shouldn't have plain d0 == 1 */
+				if (lo <= 1) {
+					DBG_BUGON(1);
+					return -EFSCORRUPTED;
+				}
+				i -= lo - 2;
+				continue;
+			}
 			++nblk;
+		}
 	}
 	in += (vcnt << amortizedshift) - sizeof(__le32);
 	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
-- 
2.20.1

