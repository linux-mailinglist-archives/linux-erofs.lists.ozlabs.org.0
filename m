Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 03810309B52
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 11:34:50 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DT6s326fBzDrB4
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 21:34:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612089287;
	bh=+A1UI11bu9nqRWMWkyEQW/5hajVz+Mo6iWxUQXpT8Fo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IEU9J8dWv//13MNcd/hhtUas2r3s7uQF47IYxEfZ8xHiTvMoeDGw/Ih4zje2Senwj
	 1I2aT7JjcCMTOW1GLpYcW7HxAB6JiiHxCMCQbMsQ+ENVQkHA5ilucnRmaw7ewoz2du
	 9d4HmRyrrzDWHGg4MBKCNzajj7sVSD4IcQV0jLxB4lLoZo7EKKHjBrHY9g7eXa/oBl
	 nMZ//H+mRnAH6mFKD8ET4d5B/X0UQIHVrDFujDDaXMOTIQR1DXCb30kWI/pv8x6vEF
	 YX3vUUIAdsaK3FkUZvf99CmsXkqfk2WlisllrXP+lO2uWU+y8NrrX30BD66ZkAm1zQ
	 lhL93VJ2HZcxw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ZEg2MW9g; dkim-atps=neutral
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DT6rw4rtGzDq63
 for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jan 2021 21:34:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1612089274; bh=orgixe4lvj26C+BLwH3/Azv/wfkboAJWIQ4wh015elQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To;
 b=ZEg2MW9gPvQ1/Pj1O7ES16CQLN0ACgiuHW93Qyi1eAfYnWCjdZj12FeyHASLsPsKpOwpuA13J6kzK9+KED3Py7blcJqIYGyPQuhZFIKp9dfeK+YqbalM/rYEOB/T+kOsGX6hf/KqUmxzZB+RduaiIWK6cXZEOF13uSDTLrRvuizyzjVolx7s+tx+VMG7nCRhhxTiYWQPXYiVXR1HpirIQv1hABDUWGvqbnUHE6ZE53iKpAlNEB+7fxJk20C9AA4VIJNxKO3TJnTylRAdlkxptWK0y1isQp0ZhqsIe3io86/+BYws2oYrJUUx29G198WxUoXK6U8MPR15nb6v4rfocw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1612089274; bh=oOvGb63/JJ/5C4lpbLOFdtQwenuwz8g3ooCe9aCsUZA=;
 h=Date:From:To:Subject:From:Subject:Reply-To;
 b=Bg9v3dR3n6hrzK4TLneyhaFUtdzY0CbMUStsDWV8hNeMKILmSaMVG/yAbtIMmFI3cpMBqjse+io71OkMnrDQ7+HTr1UIxWXxG6ib7GyOXIEwymTWng9eTu8Oe/iGPFGSuc+fUrHGGYneJqedS2aucyIRDk5ByZ2/5507i3wvMDLd2cHpaDRb+v3c4SFg2B55EhRmfW1qwUedA/MIWZR0uiAOUxByvkUugD0dZUqAOtR+Eke8PKRYwHEGL/Famjhp1pYQ9VzQ8dOH4UuXd7oQT1UlVikxivJf5XrOU3w+S1dieBULF7WqS3zt4mP6hlfCDYTxWSt2RyaXb1KLWyNSPw==
X-YMail-OSG: mCgASGIVM1nYyr_EVdNFVMTi8dBxInfLpODg2avFjtlvBcbzSIEer1NfdtberWz
 ay2_2oXHYgO27lSSN8w560oeCpo8tyxtvVP68uTes4fNja4.QzwSMwzpvrG_rAZxmtBOLAd4bTKg
 6hZdip6logr3TZkylT_B6EdORSxH7Iw0iic_goVr5t8yaAkYFM5ouz64PqHPBh.f4Iq1jjPzHy5M
 emfOWDltP6mSsiFAAukDAPtsRrC_0awpmvEv3YyMZcU_fkJ_z2yed8.RMyYPmskm8VBOoxWC4G3u
 VkW3jhDY34yin1J7l_Mz1lcxfoIhMjY2D5U1K0gdK3vuOFNVNOPDQz2meN2B5pNBdrT5W0RBKtOG
 M7gyjLnHQzmRSsdr7HdjxKmgwLG_7qCMMXl7kN_LcBm7Qu5JKCgceTv.W0oSGjsEz5I3GgIAbC_j
 JFZW_Aogd2xtLCgLxojAz9tiNtRxttMCn384f6E1stBEDY2fSkB9l7ZZpynyHBQw.7LwLKWk.21W
 vlsCCYBFxGtMSC0oYOt31Em4LT9ViiPNSvijptHZuhoXZFnQBCcX8ydoD_UcrHpjeEPUK9GCe.Va
 bRwUCB313Ak7aT_FqTa0JMBOXTjuGy2neI42ZIj9IwL0kG4LCAunw41wO9zdr2dx94iU4lWVy6B7
 gd4L64kmM8tB_CtPJrD1dJD4pdKcx9Go6iuxsxrb61RnLpmxQKpyyc6GUY3R8Tt7UEs1FJAgtI08
 LtilPl8KQ1SUKDIIAAa7Y5uzWsXA_PlqWsRijWXhzRbnLYbOgp4s8n_qFAaEiVTOaIcvkyKyBm0n
 EN_E_P65VzTg4Qt.UvPqyn4X0EFqnfxyALLapNO6hC2WzK2EdFMAbT0mnIsBPj0PDkXTSarkYXgn
 9COlPRRZNbiNCBBF5ACzE0BHCk7K0WqpStBO6TP3PEg5d9J7edJWN8KxFCzB8vO4yenkLgSWV3XE
 h0PSh9TvJdjivLig10uLBiyCTKf91HDRTE9hGrkMEtfjlhdNBadCbnTo3PKjnLepTsZ32MhrmNBB
 b1XYTFIVI.inX3nRu7t1RvgZyXu5KYTmlXl4yfozL5eUcP9JR2wYHlSanuvJp8B.JFG7HnJUIodU
 95Od4TxVd.jwvJUj0JF3mpa8Hq.QnalTEhz7FKUUYmUcl0ZI1W6T.A0ilIp5p0PGIOrGEYY_G5o9
 NDOv7dGENWCV3_zCnK39p.2QzMtHO_CrOszOod1zrW2XZ7nKiVWm2J1VkNguA.ukK4mv9ulp1oxG
 iySIr1lTWTD6LS635kKwHx96OPDCLtD9CG1EfOgtwGBVVIHW91Nh1x1B0hYPDVeoyAvCFhQkP13V
 ZqEyRs1t4maNO1DVgaaMDlcEI4p5g.M3qbI5q_GDorjYRfXuvwQVgcW8CiMophoTacwOqgcuQJnE
 Fs2abQGGiN2B8B6VwrDaLy6VvFKfEeopbVlIOrl2B2nr_81bV2OXUHNGyzfEh6JsMpD2CpU3BmVN
 GyeZS9XKY1XUR2splt9gX0BA1JpYh9RHUhegoiKWgkGS.z54YtrlA13kWxCkf.30f1Odq32plUHY
 Oo.5_qJPI2P_oB1sBSThXzeIS3qtkSs2ATd8VQC_LI.qHs6mxJClghdxXWZcXJUHwdrjW2I5vKSZ
 .4MSIV5XW3GaTQ6SHpUKNHcuWh4Iu3SNBw.5WHfmA7BFW66j698AobC4sh.g25CEpY94P2JTwJRG
 ynuyBQmAcVgC5GB9dXy8Y0XHcowTBzpJI4.8.NKSxfakV.5Nul7gfkEHLNj3E1cWwArp1kwGP494
 EdFAz79vpiRL19NmL6uYTe.4kKrxxm.rJVxwtg4g4wSYewC3Sh3NrnJ0Dt4I5k4M4hj8sF.Iqdbt
 rmUy0plSpWCMEL8itfmdjDyiQUu0P.cYALSFsaRwlPv.Hdoo9Af9_zQY9wQNx.Uix8zZa6HvCBT8
 4e2DsziK2oAutxvaX_DF4PSkWHw5WGaqNC13VXuEKuFIZ7P8pdmG2chQTWbsJ_xABvXPbfNuNj_i
 Kn1LY4o4N188D9Ct7XF2bN9bCd7nWLkhgqEWAN6pz96dQKuJs3WYubrbx29Rd4__ufmkK5FnlcZG
 lBcynDczjBJFk_yw96E6L_p4Cx.gqwFI3oQDNaFtavXVXBd0l2dpzl80b61u2U32uWBaH2ElcLP.
 FGYGgW4GQ3b_6H2v8uenLJKIf2B.KbKNPzG87SfS7KWv5hcgad648QsEgitgK1ntZ5qg0mK2ZznQ
 XxT9Q8XhuQdfIprT46BtB7vhSW9rlIBLk7S9.MdrGOpiQMqQl6kMtqYdbD_Sz0R7tmP5np.aBAvq
 h2iualTYkqhttOLG9fLHnulUcnufdV8VnwLKs_B_opKqw.5tucImw70XedPIAJKQ2q41QaQlDSpc
 KjWmJuJ.jdQ1q8YNtcgcUCWsGG9FyFzMu0Q5zCm3VwpltrO4n7xgcYAVPMbShrktIw5f2R4nzQiz
 jbpQIKllopUjU22EP.KFfXdfQn5_aRZpxfGDGLSYxjnjYE.y8lH10N7feQPvN8gxUoSl67xURlEp
 LSfg31B2ysWKxnsCUGENFeHP6yvk8IwT05UU7
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 31 Jan 2021 10:34:34 +0000
Received: by smtp402.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 86fba71c5b616e35ff08c29c51cf0239; 
 Sun, 31 Jan 2021 10:34:28 +0000 (UTC)
Date: Sun, 31 Jan 2021 18:34:21 +0800
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix mkfs flush inode i_u
Message-ID: <20210131103419.GB21719@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210131094525.168251-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210131094525.168251-1-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.17648
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
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

On Sun, Jan 31, 2021 at 05:45:25PM +0800, Hu Weiwen wrote:
> When choosing which field of i_u to use, it should be `inode->i_mode & S_IFMT'
> 
> Previously, the default branch is always taken. Fortunately, all 3 field has
> the same data type, and they are in the same union, so it happens to work.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Yeah, thanks for catching this!

Reviewed-by: Gao Xiang <hsiangkao@aol.com>

Thanks,
Gao Xiang

> ---
>  lib/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 73a7e69..0ed4264 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -412,7 +412,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  		u.dic.i_uid = cpu_to_le16((u16)inode->i_uid);
>  		u.dic.i_gid = cpu_to_le16((u16)inode->i_gid);
>  
> -		switch ((inode->i_mode) >> S_SHIFT) {
> +		switch (inode->i_mode & S_IFMT) {
>  		case S_IFCHR:
>  		case S_IFBLK:
>  		case S_IFIFO:
> @@ -445,7 +445,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  		u.die.i_ctime = cpu_to_le64(inode->i_ctime);
>  		u.die.i_ctime_nsec = cpu_to_le32(inode->i_ctime_nsec);
>  
> -		switch ((inode->i_mode) >> S_SHIFT) {
> +		switch (inode->i_mode & S_IFMT) {
>  		case S_IFCHR:
>  		case S_IFBLK:
>  		case S_IFIFO:
> -- 
> 2.25.1
> 
