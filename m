Return-Path: <linux-erofs+bounces-1386-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237BC6244D
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 04:49:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8tyg1Wvbz2xS2;
	Mon, 17 Nov 2025 14:48:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763351339;
	cv=none; b=h/8mnnORw1AK7E7s1rUcV3VuDWc8jDxAJEHHRQLduw/sZ92GtoRxG26lrJSMep/B0FIMmnVgdBCNgi/qEgWmRHtS7M0k1dmmTcFvE11SJ6DYKXq4K9z/LKneAA5v3Qz2ZzEjPyhkWJMCLlv3nIoiCN0qS0EUHLaUeEt+NFxketS1JeMeTE6OPIrLRRdLkSzgjACtGX3CQvX6TfWOLWsHPZHd1ymLBaXb6oa7LgvtwGl68HlT+t1SPUEciwqcVzLCKzAk5tbU6vklt4HYx36FeclqAnMXR23wIW5f3HYLBnVvWFOm4UGowtpaLVT2xfnsMFLYYdxkkCY8uyw65Eqhww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763351339; c=relaxed/relaxed;
	bh=53C1WjuCoiCOx/J1UsSfsFlmqf2a5Sh9391jCoDbQ6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6vI6vNKOxdv00GdqhZp4jfBtHYWL/CbJ4BEELMz2l0Q97ZGLoL/o06doFfEJfa5GGlm46oUmwmSxF1NJ3m+Icv1B/wv/w+bpiyHOGgo7EfSVWYtR4jdlsy14DUvvaHy3It2CHLHRuAw0tVkYsIpEGAaRUCbkXMSckCFC39kndZQhlg1sEjS7yZD+upmJtl2/YpP1sPUe+RJqJAZwXZ3dhWvVxx24OvT8BerhaE1wYvGKGtoyz+c/LYt8KaaKPHg3yencp/EdERWctLdr79xwzNt8rUcflICtG6EO+DPAXMIa8gW0Sfi1lnFUwHHei3ymgV0Qd947QgB4l1OU2KCKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VXcn5ku1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VXcn5ku1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8tyf0hpPz2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 14:48:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763351332; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=53C1WjuCoiCOx/J1UsSfsFlmqf2a5Sh9391jCoDbQ6s=;
	b=VXcn5ku1Gzdegg/prKJKtUPzdZLN9d25SbtGcOm+2uIRKEXJ+ORHvGLY64v86ojhGZoYMua/TEBL9JLk6jBJILIq+1W+s0kxFry/iBiu9hFXB1FXuOdutExiwPkJW2f980DSQOMQ5ymmCZEcu6TZfXnOCx7761wgQ7wzAOJD4BE=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsUAZG7_1763351330 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:48:51 +0800
Message-ID: <1cdc1de7-2a77-4c3f-b877-f71d672c7470@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:48:50 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/ishare.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 14b2690055c5..88c4af3f8993 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -239,6 +239,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
>   	return generic_file_readonly_mmap(file, vma);
>   }
>   
> +static int erofs_ishare_fadvice(struct file *file, loff_t offset,
> +				      loff_t len, int advice)

s/fadvice/fadvise/

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

