Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB22861C1
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Oct 2020 17:02:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5yHv5JJMzDqP9
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Oct 2020 02:02:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602082971;
	bh=r6op+UkE2SWAlhtzccG48MHxQRM1/vXcqzZ6aqbS+O0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mHQUY2DPICQzpO4YYZx91XyBY9Wf61PKA3hcYFqpdLo2/hLrdqsT8hwbPza+jgFXj
	 Zhp+eCYlio8WYX9cK2NeV8JUs8LbF7BI8AjcGK+8XSCP6uty0c9K08d7OfbPKJngPz
	 TRgLkJFvFgz4IXrAD4nLmPOySKJls2BFzIMq3Rjcxglcw/J1AFIM7Aj8g4Ukf2o790
	 nHK1IxzR8EygFidBy3s+4mzKWeUyi4kjBgU+x6D2NexxwRJcYJPbQ5Aen3GsvvlPkp
	 nxwjrC2D++mK2x2WpaSV96HSjz+1RX/zDGkWw/AfoPgK8xOhWOSNv/lHB5bWwAXFNb
	 UGpWPSlwBx2TQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.30; helo=sonic316-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=T0bCeixp; dkim-atps=neutral
Received: from sonic316-54.consmr.mail.gq1.yahoo.com
 (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5yHh4khqzDqLP
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Oct 2020 02:02:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602082951; bh=NiKMz5bUvFAF6Z+oR2PCu6jZrSk9kRb0bFEOtars/Fg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=T0bCeixpkWCuLwwnrhL6NBMpItzcpK4bGWS1xHT3Ri51jVoVCV08dXU4Qy6NmPIEHJ1g8u6ReM9tmyEjxq3sv29SkYGBDkmUysisq4ZjDlaWsWCCdsGzAbUm2AQteC5iIiE6J2td6+dACSG3fI7ZYw4hwutwERtbozuqJBqNH1/EbiB7tNM2KR+aUGOI1C0QJpB/ZzcZckvXVhlKJTjSVYg+aNNABF/fokKEcpGURPn0Y1ttjP5oQWha9bqYu3BnN11h/F7jUbUpky0deEHNtf0wioCIMYKiGmcmEVu13PYoJkObMVcQFli1QuAK9JQfUt6gy/J+fSmeud9oN9tU7g==
X-YMail-OSG: SKYTpBwVM1lryDUGpRQMx1X0tYQhayQ_uL5F.31KfKIKbL_z0dHMynrmqAEt8XA
 5Cs.RR.U4mb74OoRm0x8v6xltkcyubkv8yfAf546QEMipDlXq7gAt0siKN8DFmVqU2bCBzFdPiuE
 H0TyXiI4YMTWd7VY4smj5N.d0y6OXAv0H8z.xK76Utl5LVxwdR5IU40mRCr0yIpZXkXd2iKxoFG.
 04yejkS3ZWGEXVFJ9Vg2Zxs0v_8LPxGnZzf.fYRnQX77ALXEasVS.e56.Z2aWemVwBS3tJUXSuPM
 GCr69j5fjJwi4Bu6LgCzb46jfTjrj5NQbFg5rr8qKpXZ4j4e.bJnl8tamVfmouHRCKvXbcn1L5yW
 bTzNweC2xYIQfTWN1J3KkjJ2UeDwp1JEhqiiGRZztUnwYvFj_xq7R1Q9O_dkKLDgt.KCjLvOQNg1
 vm02T.8RFo4F7an4FfoyFhh12oN0nBfvQiEDKExfAwJg5e1h2NnQLWyqYx23e0Twfdd5SNH2saCp
 bGpi86XhxUt2DBGZsOzY1Tkph.69VVr.VMuUxKI7NDlEofDraDxK7vtlVIUhZsSiDyl8bxtQcSCH
 wAx9vj770eRDdnYNhUuEcAcHwpl.iuYTRsHuuvsLZv78TeS96LHW._80uUTXPpVv7EYHiYVCA6GE
 S91_vauRe8D0GoDOiAxdnAV.006JK3AacHGDz_DbpWHgl.C2Yrw9YolsR9bR7UgdepsQYfBgy0XQ
 2bwdmuwc1N2QZYnZn8JSTwkiGN16n39.XMWSH2XHiJvrUSIlh32SQWw9CYUf6wUtaE.XZk_z681I
 qM6iPnG2WY9SXkDIfXoZfmxFgFCx1kxKcmgJl9hwLu4Z5Q_aPkMTGmDFIfYzswfNff.4SB_uzRgX
 6bb9moNd5T08.TiI5qk05VzzD10BCACqB8Ou.gwxBf9no2vD23O65195Qz0_pFqpn4cH_CC3_y1i
 XyuRaszyOCJLXnmZAqCSKFCNA67Bp04ycMyZhsmIOSnJFbCuOdQiIO72NlD7Irn5TdNFYOcVngRl
 J76j.o9JzUCNlCgBFsPgw9sPOzS42eXEZMb1juONDbn8ZcP4Q3OHSlvRj71iMCUlF7D3VRwSBfAX
 7f1VR6uq6AMB8O78YQqJtt8BqQyE_GUkKT80_LTirMqBhkNH_Z3ziNDW7nPXw9_Apm6KCJ_LO2Wk
 C5JRi6cYBBkMLlSIe6XGXzsIgdMLP9P7L.aMbssjSVxqlxdbYgiuXB7x3DwrdfPrN5LSV2XbNIk.
 nqaiYXQm0.ZUXAI7dAGlXbyQkcciLFn0Pjvd_0RaBwPIWBP2b22Vp6JLEMLQWfz.DZgVLV301We8
 c15BwSZEPmflXOZT7.gb7fNjTf4JBAKlEBOIf244lgybfDDC4iFSMriipGguW.06lEwfxy4Kx62c
 wAvPeBvQoy7TNziggrLr3iOPNqB2C4tUVgeL6XUh5WuwKEeSi7AOtbBqOSoMMB5xdrP3h7QmTqm.
 toFw47h061GgaQpwwblEsTkakETSfXMSIFez_8i5TnUFVBaaDmPlnrt7NChUVoCoiWCCVMRKBxQU
 h8IyYgKZJEJu5ZlkFYwLMhRE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Oct 2020 15:02:31 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 5c8c66204a2f9e2d5c56b16b446305e3; 
 Wed, 07 Oct 2020 15:02:25 +0000 (UTC)
Date: Wed, 7 Oct 2020 23:02:18 +0800
To: Li Guifu <bluce.lee@aliyun.com>, Li Guifu <bluce.liguifu@huawei.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: add fs_config support
Message-ID: <20201007150215.GA30128@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200928213549.17580-1-hsiangkao@aol.com>
 <20200929051302.3324-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929051302.3324-1-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16795
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 29, 2020 at 01:13:02PM +0800, Gao Xiang wrote:
> So that mkfs can directly generate images with fs_config.
> All code for AOSP is wraped up with WITH_ANDROID macro.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> changes since v1:
>  - fix compile issues on Android / Linux build;
>  - tested with Android system booting;

Guifu, some feedback on this?
I'd like to merge it for AOSP preparation.

