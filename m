Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FB34DD2A
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:43:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8VzY13t1z301N
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:43:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064985;
	bh=Gdd9kVS6rzd+xtQiJ3iHeO2uYoVDv4c3v1sfNFBt1+8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hWh94e2iEOQcJG5K1azTK7q0RA8s5aiWbBOfWhIH7gq/cJHng4kMjn4LTbQSk0maJ
	 L8pDMpKte9PMRYafpXNUmluObJgTGLEd7pUG3cglosUKtOlNYFScF8fCBvhh4bqwWf
	 b3eN00Y3MFgDu/NJwGAJFsUSGPwQS5WxL5tel/8u3qXbY5cSDBXjsyoKXux+visgRZ
	 DCcMG4U8cH/d1aPD3ToC1O4SDovxIxEMCjoaV3i/H7Vuu53VCUiaNg1FSD7U80C1yp
	 nOlOosHeOBAtEYcSTys75NUxYm0qdMRlh6tlet0MbpALLzL6sGmntHbj2f+cNh3k1Z
	 k2d1AWHFrvg6Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.148; helo=sonic302-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=RDxjVKgE; dkim-atps=neutral
Received: from sonic302-22.consmr.mail.gq1.yahoo.com
 (sonic302-22.consmr.mail.gq1.yahoo.com [98.137.68.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8VzV6Wswz2yRK
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:43:02 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064978; bh=05llN5yqMn2jA9lhvbTyHfmG3RQzbldQ8L28kJALK1Z=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=TaVq+A7YUj8MAJfmJrVwyApqzgR3WfHZZTBd53qNRgNWK82zwkWSgGvL/SQMY+Hp3s83lHUrdaUw5pNf7P2KW29LkEr+djzxgOJeTEOp/aShIwaXjMjmnaw9baEdof8aTKOMhuNopqrKvZBii7bwo8yPOaXRbmA6E0HDIdFp6whz+P7rmXHeKH0vdbCUB+lcwkrlv6W1/N6wBYJAzhsyXm4zc0+iqIQEqXnsuKfleUslsYzJMITe7JYHQc4pO6ehdr/SJSWnO5HXyJGpWkN1OpG2Sp21awnIk/V5U+nSC+ophDaVneM80FWwV92D3hh6+qx5AM3LKQ+KEPt87PfVZg==
X-YMail-OSG: FlQcq8oVM1l1RsAfsO0iyE_FIDEwsFUoB.MoJt9m2I2ao.zBr2vGTbg7.SQDunk
 A5UHPvr2S8WfLvRMbtnvhJLj7yH_DEg4aSQouXJeMYJr1Skh2elzKHbEvg7GMSOGgMCDncYw85Jp
 4i9eFWzX_OfEVNWFCHtmufY8osJsiiKKFStbgcj.QSXGe8Z1.eZJZf0qCHyhUKdo6IH.XxmwMf0V
 06gasoRFh1ald5MRzGg0KZK9P.Jo5XBzniEAAxeWYAzt.YyuufVEcG9EBsv49ySH6q9DZcNH2m4G
 VuDIYs_P6XEL10D2GVMwzdI4WlItZ4cZrXuQ0xkjGW581rGP_NaGQiM7kxpOxzCXsPrCGBjuVUdH
 DYidDaiZVhZs87Pe1xTK8U1TT5BmjuCoFn6Gk33_M6FIri.Qru11JoKb0Ff313itXtEaHPEKb.0i
 YK2tnt8SBsoq5FDIwlpYVHPhiG8ToG6TL0Eor5bb8tHx9pRMwh7ZqpIh6IL6kz9Jvk3Cwy252QI6
 C4nZjPbkSAR6cITIYcFO9Vqo04R6H5E4rTh2TwJxiHZR0nb2gvBeN72KOKHopiMuX1lZnaDVn7dF
 t3zUeL_Dw9rbhEMnOCGqo_mobEdya9Ns_nafnMDjyjTwgSvIWwH8W8Vbw5IpaPnyPoaxrB3a8ViM
 iczbx7Bgz.xcxVTj8Zgka8JV93OAnBBZEkmhCKdyK3Bd6lKPDezr7SgSo4pWhjUFc_KoFF5rDPli
 b_cCVzC3ISHiD2z0OQolDmTInV_FTLniW6jwoJl.7jAL0hqKqfXN1SVHnpF_UK.H1b1k0CxBFgyR
 Ay4dPmUlPemQpVAVUg45FpgDgNGJIq5rFcdzubfokRnjeBHQHwDooyK3Cwuz_D307Okujw9uV4Mo
 Z2wRbIxWLOykVMbXW3UsPS1vuaOR6.FR.IUVjNWx6ghlIwGgXS1RaVRv1TEYcVGzdpzX9WO5y1WD
 ObuFTLy6ysaL9DgI5bPIq2LtxMCXttmpiIMJK7F21aKvWCiGy.f4sa_ve.OgQA0UJZRsSrX1HcvL
 Hl8GNRp2NulSSF5I0W7J.iXL.eNRO4cpCSX_uZLLoNyyCfGO2MmXo43f8dOzTn57YuhdRhXrgmxR
 15oAo6OnOniss.rO_OBcki5MeWBhh4V1QeiHLwillYeNUGyZCoqNDhQYERq.MN6fIvneenl58EbY
 0ZQyj0RxKLT3fo0HuLRAASckiJyrInG6h0Vkydiws8oe64kQ1JOI7G6hDNpm7MgUtrlD4oQOZqXV
 OY4tMGet2oqUo66Pq31D0C4hwvu7zQ578hzzthKAddWm.utN4R6MB2ZqG.ESsyvr7c0dw2AtaTK4
 ki8hup1kMleip.1oe0fMNl5vQpAbgaxZYSCWeiE8AU4CjvhYCbdV5mw7uCdeZamtR_OAUZkR8vGV
 IR0uWHukoUB.BfDNFL80tBEQbGmM9RYkoTJj97GFa1aeQjQsX20CbGtZkX_dsITJP0fd_O_xjTLG
 nPxzpsTBsqb9z7NMhC7ZXtIwUZVtlA5yGrc8boMnlCAb5M9ljsM8fszeDerxSYITvYZthekOCRUB
 qmI5M7suNcsdbJ4ctSKr5x9KOKxt9scuPI8Vwdv2fNlKlM2jAqtjz4BHGRc1bVbEj3Im5.r17wNe
 j9krxnh_h1SkFa2F4V9CQFDUgxayz4SBO6Sk7TYUybK62j.r5C3QwT9YCUj60vYx5nnh8Estss5e
 iZbUkmWWEN7cqitOoBx1l8soGaMKl_YhUZs_LQdHue3zxTHpswl.n8ePooHJ0pj5iB3p8QgeobGH
 o2Ok9vxIxACNoNPC7PmXPWX4bZcebhtRUmwHX3xd2QNdbAOZ08yvOWLXSdoY927s.sqgTVloZX54
 hv62HG_kGgJ1ZwFTKyoA8XbqxRwPcQ9GyW_8xNttIoJUV1fpbre70hiB.M8KE8nlVfVe38fzyvsL
 823B0AbBrLzIbcLWMsd.NtU6vd4YQjDJ9XSIE608vBkXwXhsuoUmdossk0D.GP1tBOGo5t56vM2U
 H75M7YozpOufpcqZVFoMp9XHxD5XM8GUXTY_blIMwYvZYKgxj3_JfAAv2mmI3M3MA1xBjbC3wlNy
 KvYIxfQpT1PCDeu90zndv4FcqmHJznFD1Zjg1.YXUk6Tj01UGDYbTqKxEHkawTEA2M02DcaFQMHJ
 CyJdEZT5WGUIqppGM0UsXoq1mJFQhWp7OKDciH11jl.qoYzlIu8dcL1H6R_S6mRbeyt3nLppBLzC
 7Ttme2D9nXef_uY.wX1wtRlBO24vnnXyXtfFX5HTauSyiLqwBWnHDsrKvxXvQvVeLZqUu_LkFws6
 mq3mWUBx0UsDpQKVng4VFN2f8deS4cJb_7W8goZam7.6niLWVh8nSnHsUwD68.w4wNKb3xKzbTjv
 kwDG9lydMSLvM6NGpi89LvqPdcM4AbCCvx1IKOpTfAkoIZTl.1JL18ZcpJC6Oqi5_qM5ANZPKdvw
 2d9eu996EKs7pJyzAK_vSGNCPw0gLjOGCTLUEtchben.F7XO5k8QpPL.snJt2ejLzycRrXcsPWIf
 grMGtF3msqARfajweZmlI7psF9w39EeVwtMZue9dfwcqLG9Gsbo7Eot4z8dibwjZERVdXll1TcQ2
 z65OJBYwDAc6wHMULw87f8Uv29RUTMCMDk2cxf8L1fxa81i42PCnj1CD_3zNWkotSJRsCFoppaJ9
 pEJXNdQQX8vpZWl834u3tvEtp3Npn9dvda5g3nDd8oOfveB1DYU82qVsAffyDYNNA8roG0Nj3YuZ
 Q9IsPb0IcWkJWDWIv3j9iVGo6eQeOUTdZNCz9uOwmpYfiH5uzx03RhfLkJNa0aXohQkLkWz136Mc
 tHTYUsqJOjqKHdMUMsvylV5_ZBT0OKUHGbagtPzS4xhf8auPoAoFgLvVTfKsfXUeuWf83kChk6t6
 .Z.0sNFTJLzUwlHzqHc27vUSjz7nWrFuvduVEGs7Sqomgp.w00rdBWue1T63mRM5OkH5EgWxDNPR
 _OC_dfZKl7QuTdDbalzl.NeLwN9EZrrNx_P1Qibm3EIcH0xt_Sf8j.tUTKVD61o0IyBVjShWFyjk
 0iy32gWqgil6aQLycgKeQbUMLjdX2xZw23c.1EsRkVyBxghvo0wVdFI01QTtLDjAb8LllX54tmdM
 CF5e._rx4R7hQwe56ImEfv8LEKKJ0SoHZEzriW9r7Ewi56EX66vaESJ2KkCCj0_Z_JYWTf8Y-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:42:58 +0000
Received: by kubenode509.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID ccaba9b4cc1ad2882368be99338dcdc6; 
 Tue, 30 Mar 2021 00:42:53 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 10/10] erofs: enable big pcluster feature
Date: Tue, 30 Mar 2021 08:42:32 +0800
Message-Id: <20210330004232.23361-1-hsiangkao@aol.com>
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

Enable COMPR_CFGS and BIG_PCLUSTER since the implementations are
all settled properly.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index ecc3a0ea0bc4..8739d3adf51f 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -20,7 +20,10 @@
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
-#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_ALL_FEATURE_INCOMPAT		\
+	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
-- 
2.20.1

