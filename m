Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D116351C
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 22:33:32 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MYxj60f6zDqVT
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 08:33:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.143;
 helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=f5Iuo6bl; dkim-atps=neutral
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MYxd11ljzDqTj
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 08:33:24 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4c57d90000>; Tue, 18 Feb 2020 13:32:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 13:33:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 13:33:20 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 21:33:19 +0000
Subject: Re: [PATCH v6 02/19] mm: Ignore return value of ->readpages
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-3-willy@infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ed5b3635-be1b-c290-0e19-b516e7af2aca@nvidia.com>
Date: Tue, 18 Feb 2020 13:33:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-3-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582061529; bh=RXve5/fUA3oBILhUm8o+y+17c7pBmRijpBQPJAnmP80=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=f5Iuo6blIXbcDZrM05UIgCY8ANT5xW9HB6FXMMGQCfaHMfBnR1DfaWLTMAYIE7XBP
 B9QOW8wSO4ij5j+4bCfhLlUR2LpeSTGJV0y8tnLGhP+d4at2LBMPXmcd1007q6GV+V
 F6nXmc1d8pgAlmrCaaR8bklkj+n7DiCZH8Mj9XZsOl6SUYvt06XEAlqdCtbjrJAqsO
 JEKRbCwBCkx6iNbCJyyfXN8/DDeOTx/qKgkY7yedkT+Pn0V+QFJNvk6ybzosDhS50D
 pgn5lvAGlEV280+lBsRM1YfSDahNeoARNWUSdQ6PSTGWm5OdOjiCPRr9K7h5I26KXq
 jvW6k1ji+T2MA==
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We used to assign the return value to a variable, which we then ignored.
> Remove the pretence of caring.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/readahead.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Looks good,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8ce46d69e6ae..12d13b7792da 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,17 +113,16 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static int read_pages(struct address_space *mapping, struct file *filp,
> +static void read_pages(struct address_space *mapping, struct file *filp,
>  		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
>  {
>  	struct blk_plug plug;
>  	unsigned page_idx;
> -	int ret;
>  
>  	blk_start_plug(&plug);
>  
>  	if (mapping->a_ops->readpages) {
> -		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
> +		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
>  		goto out;
> @@ -136,12 +135,9 @@ static int read_pages(struct address_space *mapping, struct file *filp,
>  			mapping->a_ops->readpage(filp, page);
>  		put_page(page);
>  	}
> -	ret = 0;
>  
>  out:
>  	blk_finish_plug(&plug);
> -
> -	return ret;
>  }
>  
>  /*
> 
