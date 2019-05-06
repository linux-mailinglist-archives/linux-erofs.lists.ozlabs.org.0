Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAAC14965
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2019 14:14:07 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yM985MCwzDqJB
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2019 22:14:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1557144844;
	bh=Q1L13qwMAKJxayxRIv9hW4oQuJq++pvE7izzxnNXMVE=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Z2AiRhvnI6/YPDfiLHiCajLZTVO8yRuZPt8qyX18Mc6UDNIKVi+tLBfoD4PRSZjdP
	 ANv7+Wjnj9xPrBFG3d3x/llAH1+oZiyAibrBbx8lL6BK4bqC1zlK0wYEgrDCzWCOqi
	 rt2iZVIjovGSZFnrFXc4OcH7um6wLwCKc7AZQcC8Aa90FrEvs4trOsW8plUFYIo8PU
	 zM0noX9X2f5/PLZTwhl0NbAh3zc2C33fDIPifzdSVnxkRgUmQmVXn4sMU5Kdh7uH8t
	 bOaVRxaP5Ja45ERVKTBquZLGfobPjM5B/ZQgmLSZ4yh4i68e3+cxEOFLh93KrmZ22q
	 MDNpzavpFxd2g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.146; helo=sonic310-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="SUcz1ccD"; 
 dkim-atps=neutral
Received: from sonic310-20.consmr.mail.gq1.yahoo.com
 (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yM8y4g86zDqH1
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2019 22:13:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1557144826; bh=Gh4v1bmESLY+OTJgbBCltSaJkpQChRCjpSf7KQ4McTc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=SUcz1ccDlIUt41ba0BFQt8LCkFF2ZNL+ASZOe59GrV8VRYf+6ru5t0JdOzOxHnI3xjn926Hhr/REw9TO/SmQkHxtQW3fiEXl4emBr6xfadbw5xmwx/QFNsou2u/6dYSGFpNZqgKVcW1Y8U8GEKeuqi0UzpMnDtvHajzTglKnMSx7PlviWdRwkXYDMmlaw6JuTuAqO6VcPVzG6eZ0IBnG474wP4ODU8X/4hzgZJKhvYpLAckBOGXssqT3W58sOawnv8KnbcIIiEr81kXrVIDWM7PEPtYXCQ9EPEgr4JdeSJXZ6q7ttYShFNI1ClQYoxIaj1C2MTnbWfA+Qm/7x2nn8g==
X-YMail-OSG: kQ91LlcVM1mSSwNMnqpFmOpeKApx1JJV1fhm7er1lZwh7iZ0fZJaOF.RuZV5ifZ
 TZhUJ0MX8Tv.4ggeG_1u6VzH9ObURtLWLypmqheRqdJ76IDnvXNz6A3dMylCSkxV6qra1UoeWm.s
 K4NLrEWfIuKMNeiEFaYaPzD1yYWNp9mm46RJXji8Yfr0JpQyN1xYZ_duUY54abSL5V10yh26NFRS
 X_0bRo2RLmrRCHx3UWp8weNican5BmykAog7B6X_WTbNc8MtF_11wYe_shHMRHIF02hdNTMakCvv
 qhOeFMiReW0cojdH6xfmhxL1NoSwCMigcgG_Z3Q6b9H3FprMK7BsYJN38qA_VDsE6wHjFlvJdv_5
 q6yIzWfdyxxbCEkbdA6eZ.f7Il_JsOywDbOuaOTaLPZgtPJAw7OEK4WaRcR_s0cZVsT1AV6IdsXm
 DOTLBJkuQKVHSOhI81f7zZDMyADnrmz31PYVsd65xF1g.ODxmg2jOGR84y2_o68fyMljop4LcAQH
 haGWzlbnJtIDg77pALRgyFG6O1bI_LEcAqzwA8V_TNtHUiQGlZxuEwRm1ACOaJxlVhgAw5hlgX7W
 FkJA8_CtZG5JFVP.zSMtzPhDZDJ_F6INlKu8em.z3FqJ62unC8Ao2M.F5sJyMOghP81WOcQpVT74
 4555AFJNAauJMvkdc_kwPMwrVXtFqbophVg1b_Y_UmDSiSgLrIb3Gm0lFyUBwWZJmzAiY3HBQHDh
 75QFMJoLbgXpYR4M5LzIGyZBCq4efNAtzQYYxi1FXOHpcWYSb_smtNC4qAHMwlB.HBaJqzETXfcB
 .6hHTtb9oOEdiz8cV5d_RSjN5PFYBzJJ470gMdKmAez1Z8Di0TOmat4a3z.xCCW9NMGEuVfiG2RC
 HzATirw8RvAdV8f83Dn2cW05teKFb7xUlwYMtQ2f8z_V0PQv22A4dEx8FOT4ez2c2hTQ_Ww5_M0x
 sqNaTG.7CHS0wrf8Bfh9a6BXOg6VjOI2.3RE.CWjLS5B21HMVftSVSyQzd.AwFcBVbSvBhdOzx2v
 jY6yQVlDJz15M4jdR.w_QoDnCCBpl4kt_CDRDU6y8EEJsqiKWJ1xxifB83DKPxaFQJ.iKYHjv1TC
 t0wm.vzZ0d7FnmF10Ky1JYPvtmd9HOnWL8UWGEfKqkPcn4o5RTPVFBt1_5QtYcjWL2DM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 6 May 2019 12:13:46 +0000
Received: from 115.192.86.85 (EHLO [192.168.199.101]) ([115.192.86.85])
 by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 468dc3c63f568f8311b633c0d3f7915c; 
 Mon, 06 May 2019 12:13:45 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: set sb->s_root to NULL when failing from
 __getname()
To: Chengguang Xu <cgxu519@gmail.com>, gaoxiang25@huawei.com,
 yuchao0@huawei.com
References: <1557140462-22578-1-git-send-email-cgxu519@gmail.com>
Message-ID: <e8252540-53db-f327-199f-1e1c67027515@aol.com>
Date: Mon, 6 May 2019 20:13:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557140462-22578-1-git-send-email-cgxu519@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chengguang,

On 2019/5/6 ??????7:01, Chengguang Xu wrote:
> Set sb->s_root to NULL when failing from __getname(),
> so that we can avoid double dput and unnecessary operations
> in generic_shutdown_super().
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmail.com>

Thanks for catching this issue and it makes sense.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 15c784fba879..c8981662a49b 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -459,6 +459,7 @@ static int erofs_read_super(struct super_block *sb,
>  	 */
>  err_devname:
>  	dput(sb->s_root);
> +	sb->s_root = NULL;
>  err_iget:
>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>  	iput(sbi->managed_cache);
> 
