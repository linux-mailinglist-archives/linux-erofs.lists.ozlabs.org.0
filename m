Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 93763356236
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 05:51:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFVnF1hNPz302m
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 13:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iO1Hdxzw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ic8CU+zX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=iO1Hdxzw; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ic8CU+zX; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFVnC4mNpz2y81
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 13:51:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617767482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQPBNK6da0W8o7+qyhfpn2E8sGg/rV6yzaqbg8AGzeU=;
 b=iO1Hdxzwv1t5ofjQ9cn80EoSao9W0QKgrGzRESHygVjwAQbpOQ8dQZ1AMokq7mf1D4/pHB
 P2niDrD/bHxxXp/w5ManhYy+zLA1h0/anRtDEjXiRyVfohc3vQ0b9JE//tJNyRwTbsPVVE
 1yTgIdYlRfnU/H4cXNznNOvPg3XvmKg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617767483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQPBNK6da0W8o7+qyhfpn2E8sGg/rV6yzaqbg8AGzeU=;
 b=ic8CU+zXMEWy00178nMKgA6o7vS3Rkm3cZryFm3lprb98gIFQLnbQrIx6XC1Vqk4vMbC3h
 ozDAryPZNRaCPuNO9u84/AaUM4VFZ0xQgcnfi277LGfRNxhV9IkJolNlullxLkL6Ai8huL
 n4lrPsjbcuDVNYuWOF0szxE1C2iy+D8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-wZ1KKALGP_eI0DUUp4JIog-1; Tue, 06 Apr 2021 23:51:20 -0400
X-MC-Unique: wZ1KKALGP_eI0DUUp4JIog-1
Received: by mail-pg1-f197.google.com with SMTP id p64so11979929pga.10
 for <linux-erofs@lists.ozlabs.org>; Tue, 06 Apr 2021 20:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dQPBNK6da0W8o7+qyhfpn2E8sGg/rV6yzaqbg8AGzeU=;
 b=TC+wBc2MH7OyIwFZyDAyiob8NS0/ve64QVSILHWUz1yKDNnt+DSAwR9rHW1g364iDj
 qZCieNa7CD1CKuNHGXvBsuUtEcAFPjLZI5yLVoqxko2gLfQT4aSH52RfJLaiRKLHE2kj
 rVrJnhs8cayScKwUSUQD3kn++clnRZxW8ajkAT8THU5CPcC+KSrYoRu5VBnENHhZkBwy
 Ybn2SA00fI5fEteNf3nLPpqmzMijLrndNcrzU5VwLfJHmwWWnwaVGqcaaeBu7k70KwXU
 75aSrPOvNPNHxdynsrBljhM5GEfzZypQYtacB1RbKt4DeV0g2BAoT7CQMlp4z3axKlW4
 Id+w==
X-Gm-Message-State: AOAM533szz/FaU8he7RZ67tCiCYBq4xxoShN/QubEMAIfToSZkWiSjG+
 prRJYECfJiQ7OCt7pb9AVW9TpEFUHzu6IRoda2wYOiGKWayinTHqvzPGGUNLo+OtlluCHgAx0go
 5OHz0U1ve7AObpNuO73bNhYUO
X-Received: by 2002:a65:5bca:: with SMTP id o10mr1411729pgr.248.1617767479155; 
 Tue, 06 Apr 2021 20:51:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFb0fes/+Orgn9Ga+gUHJeR50ztaEz9kmi0J99mHcpoWtP5bM501fDxtSxuJi0rBF2OwzkfA==
X-Received: by 2002:a65:5bca:: with SMTP id o10mr1411711pgr.248.1617767478926; 
 Tue, 06 Apr 2021 20:51:18 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q13sm3234459pfc.86.2021.04.06.20.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 20:51:18 -0700 (PDT)
Date: Wed, 7 Apr 2021 11:51:07 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH][next] erofs: fix uninitialized variable i used in a
 while-loop
Message-ID: <20210407035107.GA239118@xiangao.remote.csb>
References: <20210406162718.429852-1-colin.king@canonical.com>
 <20210406235401.GA210667@xiangao.remote.csb>
 <b56a44542a338583279893870ec819d4b1b4e23b.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <b56a44542a338583279893870ec819d4b1b4e23b.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Colin King <colin.king@canonical.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Joe,

On Tue, Apr 06, 2021 at 08:38:44PM -0700, Joe Perches wrote:
> On Wed, 2021-04-07 at 07:54 +0800, Gao Xiang wrote:
> > Hi Colin,
> > 
> > On Tue, Apr 06, 2021 at 05:27:18PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The while-loop iterates until src is non-null or i is 3, however, the
> > > loop counter i is not intinitialied to zero, causing incorrect iteration
> > > counts.  Fix this by initializing it to zero.
> > > 
> > > Addresses-Coverity: ("Uninitialized scalar variable")
> > > Fixes: 1aa5f2e2feed ("erofs: support decompress big pcluster for lz4 backend")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > 
> > Thank you very much for catching this! It looks good to me,
> > Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
> > 
> > (btw, may I fold this into the original patchset? since such big pcluster
> >  patchset is just applied to for-next for further integration testing, and
> >  the commit id is not stable yet..)
> > 
> > Thanks,
> > Gao Xiang
> 
> I think this code is odd and would be more intelligible using
> a for loop like:

Thanks for your reply/suggestion.

> ---
>  fs/erofs/decompressor.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 27aa6a99b371..5a64f4649414 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -286,28 +286,24 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
>  	}
>  
>  	ret = alg->prepare_destpages(rq, pagepool);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		return ret;
> -	} else if (ret) {
> +	if (ret) {
>  		dst = page_address(*rq->out);
>  		dst_maptype = 1;
>  		goto dstmap_out;
>  	}

I agree with the modification here, thanks!

>  
> -	i = 0;
> -	while (1) {
> +	for (i = 0; i < 3; i++) {
>  		dst = vm_map_ram(rq->out, nrpages_out, -1);
> -
> +		if (dst) {
> +			dst_maptype = 2;
> +			goto dstmap_out;
> +		}
>  		/* retry two more times (totally 3 times) */
> -		if (dst || ++i >= 3)
> -			break;
>  		vm_unmap_aliases();

That is not quite equivalent, since after trying more than 3 times,
(I think) no need to do the final vm_unmap_aliases(), since it's
only used for the next vm_map_ram(). Similar logic also see:
fs/xfs/xfs_buf.c: _xfs_buf_map_pages():

		/*
		 * vm_map_ram() will allocate auxiliary structures (e.g.
		 * pagetables) with GFP_KERNEL, yet we are likely to be under
		 * GFP_NOFS context here. Hence we need to tell memory reclaim
		 * that we are in such a context via PF_MEMALLOC_NOFS to prevent
		 * memory reclaim re-entering the filesystem here and
		 * potentially deadlocking.
		 */
		nofs_flag = memalloc_nofs_save();
		do {
			bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
						-1);
			if (bp->b_addr)
				break;
			vm_unmap_aliases();
		} while (retried++ <= 1);
		memalloc_nofs_restore(nofs_flag);

		if (!bp->b_addr)
			return -ENOMEM;

but yeah with some modification (and extra vm_unmap_aliases() here
as well...)

Thanks,
Gao Xiang

