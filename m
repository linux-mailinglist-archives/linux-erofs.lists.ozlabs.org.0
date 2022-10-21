Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1CA607708
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 14:38:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mv3tQ2NnNz3ds5
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 23:38:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dQAb0u84;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dQAb0u84;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mv3tF5Qqhz3bjJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 23:38:45 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 78995B82BD0;
	Fri, 21 Oct 2022 12:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9E3C433C1;
	Fri, 21 Oct 2022 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666355920;
	bh=64uVrSSZwWPzLpCq8Wif119GEfxx4bpfwwV/98dcN8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dQAb0u8462bv4f0DoyWtG+9rRmIhiDxj/hocWQ5lhX9d2Ua2Q4fESY7S7yMo1lEjy
	 DmV+Vxt9MwiIkFTvMRH+Wqs1kDSSni6mocKlDcfeHn4l17r4u9FYhtlKUyBWpkdjvw
	 9YhBLLSsJVzyXExEeaUSrtlZGlmgrYrhlNXIPr+/PHb8Njw1B646UP+QIKKtA4QohL
	 9NfrCkkcsFck1sEQNYIk9pl4agxkBNRLxwvrBNSACIJthgMD3Ilaj+4+s5pcPpGMEm
	 sZWB8IvIiko39ZQNzU5YXatkk9K4nnfsWaXAaJp0NzLnaanGsT2XsLHwMiW6oLTx5Y
	 shHt9vh2deRaQ==
Message-ID: <ce12b5050be31cc15bb84b620b4c21911d99530c.camel@kernel.org>
Subject: Re: [PATCH 2/2] erofs: use netfs helpers manipulating request and
 subrequest
From: Jeff Layton <jlayton@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com, 
	xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Date: Fri, 21 Oct 2022 08:38:38 -0400
In-Reply-To: <20221021084912.61468-3-jefflexu@linux.alibaba.com>
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
	 <20221021084912.61468-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2022-10-21 at 16:49 +0800, Jingbo Xu wrote:
> Use netfs_put_subrequest() and netfs_rreq_completed() completing request
> and subrequest.
>=20
> It is worth noting that a noop netfs_request_ops is introduced for erofs
> since some netfs routine, e.g. netfs_free_request(), will call into
> this ops.
>=20
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 47 ++++++++++------------------------------------
>  1 file changed, 10 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..fa3f4ab5e3b6 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>   */
>  #include <linux/fscache.h>
> +#include <trace/events/netfs.h>
>  #include "internal.h"
> =20
>  static DEFINE_MUTEX(erofs_domain_list_lock);
> @@ -11,6 +12,8 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
>  static LIST_HEAD(erofs_domain_list);
>  static struct vfsmount *erofs_pseudo_mnt;
> =20
> +static const struct netfs_request_ops erofs_noop_req_ops;
> +
>  static struct netfs_io_request *erofs_fscache_alloc_request(struct addre=
ss_space *mapping,
>  					     loff_t start, size_t len)
>  {
> @@ -24,40 +27,12 @@ static struct netfs_io_request *erofs_fscache_alloc_r=
equest(struct address_space
>  	rreq->len	=3D len;
>  	rreq->mapping	=3D mapping;
>  	rreq->inode	=3D mapping->host;
> +	rreq->netfs_ops	=3D &erofs_noop_req_ops;
>  	INIT_LIST_HEAD(&rreq->subrequests);
>  	refcount_set(&rreq->ref, 1);
>  	return rreq;
>  }
> =20

Why is erofs allocating its own netfs structures? This seems quite
fragile, and a layering violation too.

> -static void erofs_fscache_put_request(struct netfs_io_request *rreq)
> -{
> -	if (!refcount_dec_and_test(&rreq->ref))
> -		return;
> -	if (rreq->cache_resources.ops)
> -		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> -	kfree(rreq);
> -}
> -
> -static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *sub=
req)
> -{
> -	if (!refcount_dec_and_test(&subreq->ref))
> -		return;
> -	erofs_fscache_put_request(subreq->rreq);
> -	kfree(subreq);
> -}
> -
> -static void erofs_fscache_clear_subrequests(struct netfs_io_request *rre=
q)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	while (!list_empty(&rreq->subrequests)) {
> -		subreq =3D list_first_entry(&rreq->subrequests,
> -				struct netfs_io_subrequest, rreq_link);
> -		list_del(&subreq->rreq_link);
> -		erofs_fscache_put_subrequest(subreq);
> -	}
> -}
> -
>  static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rr=
eq)
>  {
>  	struct netfs_io_subrequest *subreq;
> @@ -114,11 +89,10 @@ static void erofs_fscache_rreq_unlock_folios(struct =
netfs_io_request *rreq)
>  static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
>  {
>  	erofs_fscache_rreq_unlock_folios(rreq);
> -	erofs_fscache_clear_subrequests(rreq);
> -	erofs_fscache_put_request(rreq);
> +	netfs_rreq_completed(rreq, false);
>  }
> =20
> -static void erofc_fscache_subreq_complete(void *priv,
> +static void erofs_fscache_subreq_complete(void *priv,
>  		ssize_t transferred_or_error, bool was_async)
>  {
>  	struct netfs_io_subrequest *subreq =3D priv;
> @@ -130,7 +104,7 @@ static void erofc_fscache_subreq_complete(void *priv,
>  	if (atomic_dec_and_test(&rreq->nr_outstanding))
>  		erofs_fscache_rreq_complete(rreq);
> =20
> -	erofs_fscache_put_subrequest(subreq);
> +	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
>  }
> =20
>  /*
> @@ -171,9 +145,8 @@ static int erofs_fscache_read_folios_async(struct fsc=
ache_cookie *cookie,
>  		}
> =20
>  		subreq->start =3D pstart + done;
> -		subreq->len	=3D  len - done;
> +		subreq->len   =3D  len - done;
>  		subreq->flags =3D 1 << NETFS_SREQ_ONDEMAND;
> -
>  		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> =20
>  		source =3D cres->ops->prepare_read(subreq, LLONG_MAX);
> @@ -184,7 +157,7 @@ static int erofs_fscache_read_folios_async(struct fsc=
ache_cookie *cookie,
>  				  source);
>  			ret =3D -EIO;
>  			subreq->error =3D ret;
> -			erofs_fscache_put_subrequest(subreq);
> +			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
>  			goto out;
>  		}
> =20
> @@ -195,7 +168,7 @@ static int erofs_fscache_read_folios_async(struct fsc=
ache_cookie *cookie,
> =20
>  		ret =3D fscache_read(cres, subreq->start, &iter,
>  				   NETFS_READ_HOLE_FAIL,
> -				   erofc_fscache_subreq_complete, subreq);
> +				   erofs_fscache_subreq_complete, subreq);
>  		if (ret =3D=3D -EIOCBQUEUED)
>  			ret =3D 0;
>  		if (ret) {

I'd rather see this done differently. Either change erofs to use the
netfs infrastructure in a more standard fashion, or maybe consider
teaching erofs to talk to cachefiles directly?

IDK, but this sort of mucking around in the low level netfs objects
seems wrong to me.
--=20
Jeff Layton <jlayton@kernel.org>
