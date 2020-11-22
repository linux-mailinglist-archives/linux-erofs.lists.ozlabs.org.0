Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F35392BC396
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 05:44:00 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdyNZ16HJzDqbC
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 15:43:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606020238;
	bh=KRsdfO/wCwz+cPfpj487M5FrL/MWuqowHVjLxUt6MWg=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mTnGY78hcgP65hELORCaNcn9woBiVZinXSe9wpTFVHpeOAMtGWwkxD0iO77hA5H/d
	 5cRo5/PoRlarLp+jCb/BmLTWPl+tCWVp5N/19dRys1b3wgJeSYBYAeuPFPAC+3Fc6o
	 z2AK7Bmcl7zIjHP9ivcSj+z/kWJI/7a8Yu+LyV6ll5WzwiiBgr3RMYe64PvryOBTHD
	 GpuUUtisysaeFn4HF9x2vu+KLXJ1Zvu15trQSe1PDIas+opbA7wmJBc1vkWs+bYV1h
	 4m84XBgDvVqnAoHuOou/l1reFJFzm60VIUN7h23h5Xuc6TXxip2Y674Qit1rJS2phN
	 iq997OtLwZZMQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.4;
 helo=out30-4.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=mIZlhjzd; dkim-atps=neutral
Received: from out30-4.freemail.mail.aliyun.com
 (out30-4.freemail.mail.aliyun.com [115.124.30.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdyNP12yjzDqZQ
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 15:43:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1606020212; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=HWOUKCt6PlWGgZ1zejY++4jp1BPN7DhFd+y2VAnko+A=;
 b=mIZlhjzdmjRxnmRg34AtMWVMzNXenuvhopsgfjZmU60W+od5m0uPPZziwu/GheoNWkn1uqs52DwMOzIVlujRmbcCxVSqcfFHmZ7FfrIKv+qVhGVzgqpQuvJX/wDKQI3+6DXInXItBmH9sb2V41+KEnMjDQBLC9fHEuuOjs+KwG0=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357816|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_system_inform|0.247998-0.0154515-0.736551;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04407; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UG6dIp6_1606020211; 
Received: from 192.168.3.30(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UG6dIp6_1606020211) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 22 Nov 2020 12:43:32 +0800
Subject: Re: [PATCH 1/3] erofs-utils: introduce fuse implementation
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201120174146.18662-1-hsiangkao@aol.com>
 <20201120174146.18662-2-hsiangkao@aol.com>
Message-ID: <8c768a92-3126-006c-1272-8c8022e8c792@aliyun.com>
Date: Sun, 22 Nov 2020 12:43:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201120174146.18662-2-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Gao Xiang

It run good, some codes format need to be adjusted
Please re-send to make more readable

On 2020/11/21 1:41, Gao Xiang via Linux-erofs wrote:
> From: Li Guifu <blucerlee@gmail.com>
> 
> Let's add a simple erofsfuse approach, and benefits are:
> 
>  - images can be supported on various platforms;
>  - new unpack tool can be developed based on this;
>  - new on-disk features can be iterated, verified effectively.
> 
> This commit only addresses reading uncompressed regular files.
> Other file (e.g. compressed file) support is out of scope here.
> 
> Note that erofsfuse is an unstable feature for now (also notice
> LZ4_decompress_safe_partial() was broken in lz4-1.9.2, which
> just fixed in lz4-1.9.3), let's disable it by default for a while.
> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---

> +
> +static void signal_handle_sigsegv(int signal)
> +{
> +	void *array[10];
> +	size_t nptrs;
> +	char **strings;
> +	size_t i;
> +
> +	erofs_dump("========================================\n");
> +	erofs_dump("Segmentation Fault.  Starting backtrace:\n");
> +	nptrs = backtrace(array, 10);
> +	strings = backtrace_symbols(array, nptrs);
> +	if (strings) {
> +		for (i = 0; i < nptrs; i++)
> +			erofs_dbg("%s", strings[i]);

erofs_dbg change to erofs_dump to make all log printed, "\n" is needed

> +		free(strings);
> +	}
> +	erofs_dump("========================================\n");
> +	abort();
> +}
> +
> +

>  
> +static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
> +					  unsigned int bits)
> +{
> +
empty line is not needed

> +	return (value >> bit) & ((1 << bits) - 1);
> +}
> +
> +
empty line is not needed
> +static inline unsigned int erofs_inode_version(unsigned int value)
> +{
> +	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
> +			      EROFS_I_VERSION_BITS);
> +}
> +
> +static inline unsigned int erofs_inode_datalayout(unsigned int value)
> +{
> +	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
> +			      EROFS_I_DATALAYOUT_BITS);
> +}
> +
