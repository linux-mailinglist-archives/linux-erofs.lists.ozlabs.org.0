Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605E34C091
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 02:36:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7ttb2cyXz3013
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 11:36:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616978199;
	bh=cFVITCi760b3vdpAiRHDmVCqgoE6EjHSWwTgj7R1KL0=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=EVHnkr5bl422+Qnmm/kMTaWFnTj75HaF45Ovt/WTURRHg9+dJS2mgCtnJLsc48V+s
	 2Fn6qESJScItWgtFourCAWQmlOpXtnOvmur2Sl8kZJFCjkCZEMT35hNTHv0fo5/oVN
	 XYbfixUFoDJvsGMqBFuyxvH+1YCPWBY1SFmi1ihM6Bwl0ZfARdY2HIhk9lh9NtFEQF
	 oBrgGVOZjAhSadUKjZXM6TCJco56YBZ4o4IHuds9VgEKLcT7n51H88puEKR6YGEpq6
	 k6MJSskXi0bxcva5OdQafHVSRctifoT2FL6TjBOQc5pyKYiF+Dja+bhaEm/1oS5xQB
	 8GhWMoZGAQjBg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.32; helo=sonic308-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=QfbeUPIf; dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7ttW6Fjsz2yxC
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 11:36:33 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616978186; bh=GT82rZsw5zlM9dBFtcIA61u962gf+rpaRxQ6IB8M5wZ=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=umgReBCfruKk29qboe+SXRF6yQOLvJXbHQyGLmXu4Xxo7eogWIUrh0f1SVjk5pKOvjxc92xqYpOWUIgr7H/L0XCQvuiNAMUKBgUCPGmSo3nS0REAurjNUTuXufw/VTpVT/O8CFC+hBkDweunA2I2qHt9qTHvBRNSIE0kJejUjrQuYsO0AtTRRn9uhy2Jq/9p3i/YbmqH7NzStyiFi1LNZPTlXK5vFCUo+tVYZSyOpn/V2VXgrwK435H5nzPy6RGdHnL97VWS3LyT9NVgALPq68gRUU3Q+pIQYiTkp7FmmtjnWfmXKbPQI35p3OCIeM5u1fcZzistObJpo3Q03hmjLQ==
X-YMail-OSG: 2xwLyRcVM1muPCCHdU6z8groXzHPxSoPpK6pH7CFLYTvZCQ_Z5cg4LAqQTb3rrE
 gi312Dn1SUHDrIyILJWsQxPaDhtdxXATJvnZmXwKmBSsC7AwgLJW8KRVYLJPV3zNQ0lGUqSlJw7k
 G8SMOzNCL1NNAJeCHDdtLVb4U0oik69A7oXuW0fJUNmvBcjHW0prgO5_uCLzZnnMARF7SNt8ogHf
 xHsKA_.EQq_Cds7q9lcBawMIQT0n5eEMykA1l8hnUovBOHniTzb0mC.y5VGHMGvVbLLwLf0_38IL
 DkJW7eYRjvxTLjYUgyhp5dyFfAdFdW6apZgQOM3nv4sJgPdGfm.1AaEIReTDTdyeyEa09xu_Obwm
 D2Q0gKS0zRLisjEbjACoHPPYm95Po3c0AmSGeWXvU3pHf6LuULWhFiVTfz9LxDVQNCLvpvcWz5Ux
 EOJhNzVQEadtBFWHow43c2pmkDBGCR41sMbjFKLtu63aOUL8_iDN5GmoV30O9R3qFklJZTlYmgNE
 MKlXucM.eodnwa5S4v0kQ69BSqyqtLEhH181259w3AhDVLB4wHOzvF61ZyDJLhkZ1lDfaqD6E8tV
 h9z1iF3X8IVjqtOVlZFWzDMPZ20.5bj.3jYelvD2MwhGen86Tw7co1GIHLjigD3aDmm1CSUl9BXE
 J7BSJjd4gKGb6l4BJ_DB.mYeA1s8UDUGzXp7SBr9A8oz0jI6avlDRI2IGplx95oaY5_tvWcoh0NE
 em5LXXx5DFBBWbn3730qpKYqJZTpZQT4j42TIt83TIQcTk6nT3N3DJpik7cMCzNTaKwSqRJxyYMv
 YufewQh9u90jXDYg3RT.GR9ruff4a32dXpjnQpglUZJY1nS8CvMsgbGJ7F1n0Sm2AqfXpX0bpeYr
 LiInjHMwYlc040azgMa37BVhVVTZ4IyLu1_6jQLE9ErKHKzyoZl9hZPf4FgM_zEq0eiN4K_nHjiY
 IVz0m5SXcSaPRq4m.Xwh78VnR.P1DqK9SnGKAx6Qg4Uyv0G6rAhI32_VN8HM6Xn4t6C2aA8GVFYr
 9In7MyRNH9FO7Z3I.okiz3_uu586sI8i_HRdcw22syNeSMnSiPTI5X_Yfbh_Pdg2qgEXbjIGrure
 z._ytN4GLn2AdQQoN5Du2KKLFBDQEVhVU501T1Febu50tQYUKPgr96QP8uZ49GIBDNDP4EfoAJ_n
 JXCv62V0wWrUC.5yYUZtC_WruYWzmwa2pSyHNrHONl0_NFKHi5ZonwEwjzbWOpy91KucOpytFVmE
 sDZK2T9g2BMIYznysF4QQQ1ZAnqGQ42cISRdVBk.pjpetIlhMJT0ygzUeG5NOquHL1SgoKFzwgbY
 eTOgu1BArtLxQSBHJyrwd87ux5iEi1NnEd2hvCtBG2COEeABY7pS5ecYbXWEgAC_gyoW_n2_bl0s
 6s3WYnx6.PwMjB77pzlX.9IVdoLyjJMH.gRS8_1ir8FJG78q3AQ9clG3lE7PVR8hqE6mIOVdtAPR
 X7wqI2o8Rt72nVSmp_JJQFW5QK5BcXij2vEjH_eLMuYcgpL2M53LnOWJRshignZGuhKYh3p9_QZA
 DcRxWm5Ba0LLDV61q5tA2Q71lPzCDbx_DbQ051j5EFby2qwYgC7gOshB9jd5oGoadDE9vzhL_ePY
 rxSElEFxNNjoAO.LTDLwBynQjNzyfmyqrggHA8iuSrwnxBB.UaeZxgtbSlVDc.HZ9TqLPAjMIqt9
 QmgsZLSsUv72JuDYC8M05e3eVQaT5HaUEIygzHkjIQNwrLMXU7kJwgoq7Cq3T4aVkYyoFXvqVe8N
 OtFqERiQ9vj4Y4XUcMu6IE8nBa_y_pdQ50RKQ5LyYAxYplUE0h11_elywdvlrWE8gueHDuB8Lzpy
 RJJT0DHhf.jY.3AFFpW65XvJgC9B58.KeyNjgy9ZPvPFj_QVUXhJbowO6Qj1OuWj8xAiGKHhIaWN
 3lVZ_ccqk1.tiB5pW6x9zakNJSOc_j4x1dehW677Shi4tV7rYaaINljT8Y.u9iWAOxwxQH6UAslT
 0PDt7bdDkEQb.aqW0Ry1J74Z_3wEyvHIcUXkW2uK.DbFEsy0Cp3J2x3VHNfH7Y46B9GKLbuanRvG
 6DUrSXGZgwD3bqzSUZ1pWFSDGHpa_4.vJYBIUsN_8VdT066ma3_5_vhPIkC5MErnA2AAdLqvQ6g5
 v8GsmB8bHLf4woVNa6P.V1UWxxc3lK.E8MyMcwble7HsL6ovNNWK7yeGndeZ7nTodw1LrNikBsNe
 Gz7x14lpR8y6EU8QfkdqjsFzG4PUpkpubYsvzCrXlymPZtfDAg2oKqmt283NC_qrhdcHXbAZyKi6
 3pQmvv8bIADJ4rbvu8Wky4g8Cq0H4XSlBULgmFfITyYemfj6heVpnOwwuA6I8nl73vVCeFp.n0EB
 7vxp7dL5o7bojymZsRBxstjoT0iq.1HfIKkzMqdSio_jAkxRUooune_5HGz1LyahDlPpLEtLQ47h
 B1uB11re9wl6rcz_JsnQC2ItTqbZ0MnxMSG_QNHgk8cItnaGPhITU3iFAWf5MtiOSJH7Qs2IarxP
 BHDl8cvVuR.jVTpKpWYTpIhk0EbfWi1jjeI64abFtgegApAZTPH6sENybqZJHK4_j4yGt0YEidHe
 ZnMXTBxvt2S.G1YIxJF9XACnPb9aT5aFFtQ4QE2h499Y7WdB65I0JTGe29pJeltL1iR4CcJvoSv7
 .jbvWo3cyvaXOLrd3
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 00:36:26 +0000
Received: by kubenode530.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 3c706409ff0cbcfb3fea207c1cb57b01; 
 Mon, 29 Mar 2021 00:36:22 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: add unsupported inode i_format check
Date: Mon, 29 Mar 2021 08:36:14 +0800
Message-Id: <20210329003614.6583-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210329003614.6583-1-hsiangkao.ref@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

If any unknown i_format fields are set (may be of some new incompat
inode features), mark such inode as unsupported.

Just in case of any new incompat i_format fields added in the future.

Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
new potential inode features can also be covered by COMPR_CFGS & BIG_PCLUSTER
in the next cycle at least, and possibly need its new sb incompat feature as
well so it's not quite vital.

 fs/erofs/erofs_fs.h | 3 +++
 fs/erofs/inode.c    | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 9ad1615f4474..e8d04d808fa6 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -75,6 +75,9 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATALAYOUT_BIT          1
 
+#define EROFS_I_ALL	\
+	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 119fdce1b520..7ed2d7391692 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -44,6 +44,13 @@ static struct page *erofs_read_inode(struct inode *inode,
 	dic = page_address(page) + *ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 
+	if (ifmt & ~EROFS_I_ALL) {
+		erofs_err(inode->i_sb, "unsupported i_format %u of nid %llu",
+			  ifmt, vi->nid);
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
 	vi->datalayout = erofs_inode_datalayout(ifmt);
 	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
 		erofs_err(inode->i_sb, "unsupported datalayout %u of nid %llu",
-- 
2.20.1

