Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C96C5A68
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 00:31:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Phl9k2ZKLz3chB
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 10:31:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1679527914;
	bh=KQSDAMaTzmE9XBa8j1VLibejVzOAwkcT9p0rqOH9+2w=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=K9OLSbAtErEp87Y86TN5Fb2EAm7NZtgUp1Nuq7ZOTEJk/oAHLmOOUEYh5h/w9dAip
	 mg7qf/zIETU2HnXIwiSzSQXIoGbmcwGH7SCyNpMrMZXajROkpKI/Lvh8Vn+PNfBdYw
	 r57oAp+NG4lZt74uIgYpgfy6F0lpYFChodkJvKxP2HFQO9+4nP1cdIKflgN/wlRKSA
	 zqyJpce2HHHVdxv8GpRqP3uT2zWts0uFiUHxUlvegmkSJXUH66qEyBjeLPaM/w6CG/
	 /yyAbOJsPxOB2bhmVfcxMixCEnvGc8w8HsYlMXTse9ODIsSEiBZFCLjCeyo0qA09nc
	 TVwqeoiIiFF5w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.wdc.com (client-ip=216.71.153.141; helo=esa3.hgst.iphmx.com; envelope-from=prvs=438b69c7b=damien.lemoal@opensource.wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=L3AV8C1i;
	dkim=pass (2048-bit key; unprotected) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=JGNufdCw;
	dkim-atps=neutral
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Phl9X5fJSz3c6v
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Mar 2023 10:31:43 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="231247822"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:31:39 +0800
IronPort-SDR: yoMuf+oiOXszADkzjMtUfUtYE3rHIyaQqqlENNLrN3Gz/VeGdPLxjana9u27JooWvquJxSEyo1
 EaBtbe5DpNekSxTcOExit27CKdHU5AXKako2FWMyPkcaSKCJfNaQhFU5wNEksdDMIZM634RHu5
 MxJ8r1woCCo5I60AoUhucQOTLvR9vGM6vBZ4qqlsKiCZc1xMz+4v7B2hZKHPov7CPmDnAXpZJQ
 VT0sSenMVLBFqPEy0E7SlH4D+2Qvh97Ar9eoQltDutIkd8/YOSAys9JiS+brTaT/E1Hd9JVCca
 5Aw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:42:16 -0700
IronPort-SDR: 77jpZ3WWY++0YyzHjZMnH7hfT7Z7cmVSIfKu/pqAEI1yItgKWTf6EoSGf/LMz+eLBFYTFs4VRG
 HkygaOJC6KGBCuGjYFX1bsGgwUl79smZs2qUG8w0ZGylPdFyR/HcBM/org4jy/2xwpHFbfCDAy
 JlqdR5XoaHn/gBKrzfQkxCHmGvpjPSdXxGvfjaNrqcBazXG1fUPna0SNhHTxV5zqBDEE0PsM72
 rUe0dgWJ3CY0mc3gLyScmHw3JtaXE4dRC2GcWuh5dlWxk8dPPxZEEE49uL28OtRW+ZRX/VDvf4
 REY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:31:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Phl9Q2kvQz1RtW5
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Mar 2023 16:31:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Sjo396wHTmTN for <linux-erofs@lists.ozlabs.org>;
	Wed, 22 Mar 2023 16:31:37 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Phl9H74fjz1RtVm;
	Wed, 22 Mar 2023 16:31:31 -0700 (PDT)
Message-ID: <5e7e8187-f514-c65e-2615-26762a329590@opensource.wdc.com>
Date: Thu, 23 Mar 2023 08:31:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
 trond.myklebust@hammerspace.com, anna@kernel.org, konishi.ryusuke@gmail.com,
 mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 richard@nod.at, djwong@kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org
References: <20230322165830.55071-1-frank.li@vivo.com>
Organization: Western Digital Research
In-Reply-To: <20230322165830.55071-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
From: Damien Le Moal via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 3/23/23 01:58, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -convert to inline helper
> v2:
> -add kobject_del_and_put() users
>  include/linux/kobject.h | 13 +++++++++++++
>  lib/kobject.c           |  3 +--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..e21b7c22e355 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -112,6 +112,19 @@ extern struct kobject * __must_check kobject_get_unless_zero(
>  						struct kobject *kobj);
>  extern void kobject_put(struct kobject *kobj);
>  
> +/**
> + * kobject_del_and_put() - Delete kobject.
> + * @kobj: object.
> + *
> + * Unlink kobject from hierarchy and decrement the refcount.

Unlink kobject from hierarchy and decrement its refcount.

> + * If refcount is 0, call kobject_cleanup().

That is done by kobject_put() and not explicitly done directly in this helper.
So I would not mention this to avoid confusion as you otherwise have a
description that does not match the code we can see here.

With that fixed, this looks OK to me, so feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> + */
> +static inline void kobject_del_and_put(struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +	kobject_put(kobj);
> +}
> +
>  extern const void *kobject_namespace(const struct kobject *kobj);
>  extern void kobject_get_ownership(const struct kobject *kobj,
>  				  kuid_t *uid, kgid_t *gid);
> diff --git a/lib/kobject.c b/lib/kobject.c
> index f79a434e1231..e6c5a3ff1c53 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -876,8 +876,7 @@ void kset_unregister(struct kset *k)
>  {
>  	if (!k)
>  		return;
> -	kobject_del(&k->kobj);
> -	kobject_put(&k->kobj);
> +	kobject_del_and_put(&k->kobj);

Nit: You could simplify this one to be:

	if (k)
		kobject_del_and_put(&k->kobj);

and drop the return line.

>  }
>  EXPORT_SYMBOL(kset_unregister);
>  

-- 
Damien Le Moal
Western Digital Research

