Return-Path: <linux-erofs+bounces-327-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB2AB7C73
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 05:47:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZybkB2chdz2yvv;
	Thu, 15 May 2025 13:46:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747280818;
	cv=none; b=UCoZdtaYPu/cLM34cba2cdgwZVoyHabLEbQJOo2Y7HmTipv30sUNEBPN+raeLy5JCY5fZF+geEJN+8IQWxfEtyUCN2FolJdVTZkxS0xutCGdnR3TyFuEFpGun05U6Tt25xKF701q7I5s74bli3130i0H5VQokaoyy9e3SUmRFuoZ3sAjtoBR5xQabDTnBcHb+5osZEaUilbW3sErUpr42vJPdBI/znwR2MBUZKxGhiA9gHcJ7M5ye/mwuOcJDmcoELj9Wj3OXg7qhjrRblJibEeZHe5LqNWmQMPVpeNWjd2Djb0XzaDtamJTS25V5AtfFx7QednXXdSZT6lfx5Xbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747280818; c=relaxed/relaxed;
	bh=kL5HLF7SySBkDTeFK34YlV5AEeW5hhrhhGSedy+LTCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FqMx+KHLHFHGgWak4aWD/wKcM9UdBIy60VZMIB0f09L212gGzZsuXzZmW1LFybuMPRX+R0nLUN7GE84TNtaLcMEhVDVQ9CMGUichmIBDYXeRHZnWDLrjE0tg/GGkfeqS2tWDnCIuiDUv/Pd8RKwmrrv2m/D20X0r9gN/OnSsAUxIqVyzc9QM9scQvIOYBWlVu410HPQ0kEZVnn0FAbDxLp47jtEOqJFwqXlQOFY3zlT6i+OwtM1YQyLDgykRUSfYavEuciab2FKxEnvRGnshob/wDiUV55y6uRxwc4Wa0tXsqIQypWG0igBxn+RpOWFy4CBkZVXAw27CGuQnY1cpcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zybk862R0z2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 13:46:54 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zybd344gZzyVJm
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:42:31 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 70B22140276
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:46:50 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 11:46:50 +0800
Message-ID: <bec37d9d-191c-4bad-bafa-eed019915e78@huawei.com>
Date: Thu, 15 May 2025 11:46:49 +0800
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
Subject: Re: [PATCH RESEND] erofs: refine readahead tracepoint
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250514115713.2719705-1-hsiangkao@linux.alibaba.com>
 <20250514120820.2739288-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250514120820.2739288-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/14 20:08, Gao Xiang wrote:
>   - trace_erofs_readpages => trace_erofs_readahead;
> 
>   - Rename a redundant statement `nrpages = readahead_count(rac);`;
> 
>   - Move the tracepoint to the beginning of z_erofs_readahead().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo
> ---
> replace a stale version..
> 
>   fs/erofs/fileio.c            | 2 +-
>   fs/erofs/zdata.c             | 5 ++---
>   include/trace/events/erofs.h | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 60c7cc4c105c..94fff404db81 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -180,7 +180,7 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
>   	struct folio *folio;
>   	int err;
>   
> -	trace_erofs_readpages(inode, readahead_index(rac),
> +	trace_erofs_readahead(inode, readahead_index(rac),
>   			      readahead_count(rac), true);
>   	while ((folio = readahead_folio(rac))) {
>   		err = erofs_fileio_scan_folio(&io, folio);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b8e6b76c23d5..29541e0787b8 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1855,13 +1855,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   {
>   	struct inode *const inode = rac->mapping->host;
>   	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> -	struct folio *head = NULL, *folio;
>   	unsigned int nrpages = readahead_count(rac);
> +	struct folio *head = NULL, *folio;
>   	int err;
>   
> +	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
>   	z_erofs_pcluster_readmore(&f, rac, true);
> -	nrpages = readahead_count(rac);
> -	trace_erofs_readpages(inode, readahead_index(rac), nrpages, false);
>   	while ((folio = readahead_folio(rac))) {
>   		folio->private = head;
>   		head = folio;
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index c69c7b1e41d1..a5f4b9234f46 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -113,7 +113,7 @@ TRACE_EVENT(erofs_read_folio,
>   		__entry->raw)
>   );
>   
> -TRACE_EVENT(erofs_readpages,
> +TRACE_EVENT(erofs_readahead,
>   
>   	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
>   		bool raw),

