Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B36C23FB
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 22:40:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PgSp51C9Pz3cL0
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Mar 2023 08:40:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1679348429;
	bh=b9zEtHDic9UqpNQ2nmRpZrwUWVXEUTDBm4dZnh94WWk=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A1uXRRWghf65SljayxdFjY7UYbGy/clnDFdhWM4wHssRRCo/Ocm8fRktOjoGecfDt
	 K9aGSI0e/uvIxW6i8wAiJkc6COcM+t55/6zzKKRgHqwVP4XSqTH+mYO9tnZk3crvH3
	 q303sP6Ea7ORUGMqiJlsAnEunrGQSs/HcA38TwR8VMfgWWv3cxexodJqCo8N24Qk5k
	 hziYctialR1xP7InrK35j0Tk/MRa3KsAAlKd4IwS82O7Dak+NokwjWTb3kR0BGGlCV
	 FVRYZPmM8Trssfrp6LHXqze2xSYyY+rdE+AaCS1WrINVABmBnPdKleO8s8QTFvfsOP
	 6cWiH1Qyi1LbQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.wdc.com (client-ip=68.232.143.124; helo=esa2.hgst.iphmx.com; envelope-from=prvs=436eb87b3=damien.lemoal@opensource.wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=q3evL9x4;
	dkim=pass (2048-bit key; unprotected) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=EKxs8rpU;
	dkim-atps=neutral
X-Greylist: delayed 63 seconds by postgrey-1.36 at boromir; Tue, 21 Mar 2023 08:40:19 AEDT
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PgSnv3R7pz3bT0
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Mar 2023 08:40:19 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.98,276,1673884800"; 
   d="scan'208";a="330490367"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 05:39:07 +0800
IronPort-SDR: IycwjYmQN+Q7SUxm5zMkPwsMpgx/56CFGVSy3jpcRDJEIv/XcXv1JEycDSpST1Qq7GW0eINdGl
 lj5ToSIaAj6tV05SqJV01Y1ghzheABR0EsFQhSEYgYW5lqobqUx7ZyttV+fHfid8ZOBYKrIjM6
 jM4KjO13BcbN7FZyV9oFI1womHnqL2dqM25ZY+5DATWh8MNNO2PELwX3lC4JGBBs6AGt4bvBX8
 /xCM4aRFaGtNSQw2AO/jWa0C6tVBHdogUUD7iSV2xhbp1hwGErcLaNZBDe5kZUpfAZHq/+t0co
 l/k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 13:55:27 -0700
IronPort-SDR: S2KJOeBtxdUcUmzlOXr7trPAopIcSPgtl5menYr+iKfd87pt5/JLke/U3rpjCZWlXK0ykwgU97
 e7QUxXV4yNlZwG01alCTeN4XVxRdSbY3gakTqII8WgM+28/p//FXR7oXrbld2ICmOAkoqHJ1pE
 WmdEgo2LKjXRffJn72U5q+5f29/a2GYHXxgZbNDJiAbnyDjFzod6Ub8vlmyrOcoaGi52BclGdN
 hx/zTuBXtNdQ/a3gxO9X/+kjyRy1TcwlX0NCGFe3xvZIZUiKq/aaizCLWZRzbsQ+GnzxUG4Z44
 eB4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 14:39:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PgSmV6zvMz1RtVn
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Mar 2023 14:39:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pGWsvYYTxSPZ for <linux-erofs@lists.ozlabs.org>;
	Mon, 20 Mar 2023 14:39:05 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PgSmM4CNrz1RtVm;
	Mon, 20 Mar 2023 14:38:59 -0700 (PDT)
Message-ID: <2229e074-d78e-3bd5-bf06-a53e9ad57d02@opensource.wdc.com>
Date: Tue, 21 Mar 2023 06:38:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND,PATCH v2 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
 trond.myklebust@hammerspace.com, anna@kernel.org, konishi.ryusuke@gmail.com,
 mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 richard@nod.at, djwong@kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org
References: <20230320184657.56198-1-frank.li@vivo.com>
Organization: Western Digital Research
In-Reply-To: <20230320184657.56198-1-frank.li@vivo.com>
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

On 3/21/23 03:46, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -add kobject_del_and_put() users
> resend patchset to gregkh, Rafael and Damien
>  include/linux/kobject.h |  1 +
>  lib/kobject.c           | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..782d4bd119f8 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -111,6 +111,7 @@ extern struct kobject *kobject_get(struct kobject *kobj);
>  extern struct kobject * __must_check kobject_get_unless_zero(
>  						struct kobject *kobj);
>  extern void kobject_put(struct kobject *kobj);
> +extern void kobject_del_and_put(struct kobject *kobj);
>  
>  extern const void *kobject_namespace(const struct kobject *kobj);
>  extern void kobject_get_ownership(const struct kobject *kobj,
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 6e2f0bee3560..8c0293e37214 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -731,6 +731,20 @@ void kobject_put(struct kobject *kobj)
>  }
>  EXPORT_SYMBOL(kobject_put);
>  
> +/**
> + * kobject_del_and_put() - Delete kobject.
> + * @kobj: object.
> + *
> + * Unlink kobject from hierarchy and decrement the refcount.
> + * If refcount is 0, call kobject_cleanup().
> + */
> +void kobject_del_and_put(struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +	kobject_put(kobj);
> +}
> +EXPORT_SYMBOL_GPL(kobject_del_and_put);

Why not make this an inline helper defined in include/linux/kobject.h instead of
a new symbol ?

> +
>  static void dynamic_kobj_release(struct kobject *kobj)
>  {
>  	pr_debug("kobject: (%p): %s\n", kobj, __func__);
> @@ -874,8 +888,7 @@ void kset_unregister(struct kset *k)
>  {
>  	if (!k)
>  		return;
> -	kobject_del(&k->kobj);
> -	kobject_put(&k->kobj);
> +	kobject_del_and_put(&k->kobj);
>  }
>  EXPORT_SYMBOL(kset_unregister);
>  

-- 
Damien Le Moal
Western Digital Research

