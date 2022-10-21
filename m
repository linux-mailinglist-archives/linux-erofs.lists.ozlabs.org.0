Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3A607335
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 11:04:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtz7M4X81z3drW
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 20:04:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtz7H67lQz3c7L
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 20:04:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSikrQi_1666343077;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSikrQi_1666343077)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 17:04:38 +0800
Date: Fri, 21 Oct 2022 17:04:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 1/2] netfs: export helpers for request and subrequest
Message-ID: <Y1JgpEfsKH0vYbw0@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
	linux-erofs@lists.ozlabs.org, jlayton@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
 <20221021084912.61468-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021084912.61468-2-jefflexu@linux.alibaba.com>
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
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 21, 2022 at 04:49:11PM +0800, Jingbo Xu wrote:
> Export netfs_put_subrequest() and netfs_rreq_completed().
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/netfs/io.c         | 3 ++-
>  fs/netfs/objects.c    | 1 +
>  include/linux/netfs.h | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index 428925899282..58dd56e3e780 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -94,12 +94,13 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
>  /*
>   * Release those waiting.
>   */
> -static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
> +void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
>  {
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
>  	netfs_clear_subrequests(rreq, was_async);
>  	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
>  }
> +EXPORT_SYMBOL(netfs_rreq_completed);
>  
>  /*
>   * Deal with the completion of writing the data to the cache.  We have to clear
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index e17cdf53f6a7..478cc1a1664c 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -158,3 +158,4 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async,
>  	if (dead)
>  		netfs_free_subrequest(subreq, was_async);
>  }
> +EXPORT_SYMBOL(netfs_put_subrequest);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index f2402ddeafbf..d519fb709d7f 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -282,6 +282,8 @@ int netfs_write_begin(struct netfs_inode *, struct file *,
>  		struct address_space *, loff_t pos, unsigned int len,
>  		struct folio **, void **fsdata);
>  
> +void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async);
> +
>  void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
>  void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
>  			  enum netfs_sreq_ref_trace what);
> -- 
> 2.19.1.6.gb485710b
