Return-Path: <linux-erofs+bounces-1559-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E4CD8765
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:38:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db7hQ6Ys5z2xlP;
	Tue, 23 Dec 2025 19:38:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766479126;
	cv=none; b=XuuCtkOjQo+UASKMezpKyko/buOTC2kjJnuWls9Cc520JSapAS+ZTg8nA3+Hg/mr6mT8ol7JU55mX0m8V3Ic7wNPVY7+AFpJXdGKL5LBEbPCExs50INWodIhOCI2IpPNYv0nn1WtGXoQ8fbMqKPJIGJ1KmpafCniN824Wpj98C2MWLLc18+dxDBkxleeUlItrqRQr/YVIctHKXzatpr3iaIb4Yp0iTuLNFIWFP6mVry1dEeAB4NImkkSSwhKAy/oQAB5hMDBdgOBoCZfENbThSB+cTdz+ljJOcCzmm8A+BsA9oS+Zaeho6JiEVNwLEw2gHVb4fRkY1p72pd5jinitw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766479126; c=relaxed/relaxed;
	bh=+DP/2H+xQ/7iGwEiUHefMl7ZgQSgQwx2Uhv6QHxu8mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAJ8rRDI/US0Np+RzCvzvP7RzCXXk9BFKk9PtJU+XDX8Lvxz3NDRO2WlgYGvt+XVzSd4kesB2Nq1zGTwr/tKAGkThONbSVvJ9fwuYfN5E/1RmCQMg/pvLBd3hGu8rko+syFlMh0ewqX9DiBWmaW8MhxwP5rzGlW1aRqPy3S1M1KgQqzl1yPJr105HalsRmiswc04n1RT7+sfpM5ivNICz1q49R6jFV7U9JmRG3wJmKKxugotnaUaYjUtt+nj6gHyotdn1HaUJru3fKWLx311B6ULN4xpiGlDQ2nJzZsQ2UpxRW32jxtH0bLTZSX+Vtg20DL5WUQA053eDRelGSs2mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=alz4HkQf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=alz4HkQf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db7hN5Vcmz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:38:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766479118; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+DP/2H+xQ/7iGwEiUHefMl7ZgQSgQwx2Uhv6QHxu8mg=;
	b=alz4HkQfEs9I8/e9IZUAtfi9dz5bkd3yvC7nn17lC5EhS2ASDgh8UjvJs2G52FHECJ84KsrzlYtyv24Mgz6rGoVknYiwfd1FxxMMCpZ6MRCZwM/87BUpbjrY4SLo8Scbl65pf+eA0P9T9i2t5fY4pDWGNiOBayQ4+E05uU/3pZE=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX383x_1766479116 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:38:37 +0800
Message-ID: <5140f1e6-a669-479c-9e59-7bbf2191f546@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:38:36 +0800
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
Subject: Re: [PATCH v10 10/10] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 hch@lst.de
References: <20251223020008.485685-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223020008.485685-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 10:00, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

This should be sent out together within the series next time.

> ---
>   fs/erofs/ishare.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 269b53b3ed79..d7231953cba2 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -187,6 +187,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
>   	return generic_file_readonly_mmap(file, vma);
>   }
>   
> +static int erofs_ishare_fadvise(struct file *file, loff_t offset,
> +				      loff_t len, int advice)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	if (!realfile)
> +		return -EINVAL;

BTW, when file->private_data == NULL here?

I think it can only happen if buggy, so just:

	return vfs_fadvise((struct file *)file->private_data,
			   offset, len, advice);
Thanks,
Gao Xiang

> +	return vfs_fadvise(realfile, offset, len, advice);
> +}
> +
>   const struct file_operations erofs_ishare_fops = {
>   	.open		= erofs_ishare_file_open,
>   	.llseek		= generic_file_llseek,
> @@ -195,6 +205,7 @@ const struct file_operations erofs_ishare_fops = {
>   	.release	= erofs_ishare_file_release,
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
> +	.fadvise	= erofs_ishare_fadvise,
>   };
>   
>   /*


