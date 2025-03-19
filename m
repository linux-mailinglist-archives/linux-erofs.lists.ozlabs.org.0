Return-Path: <linux-erofs+bounces-93-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE1A68B6C
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 12:25:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHmbg1w7Dz3dWW;
	Wed, 19 Mar 2025 22:25:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742383535;
	cv=none; b=T+PFRkgHaXgVqkSNw7sNrWkPFwY9TxrFNKet6UYbBFmSDhjYYxJx70XlqtzLAf/VbW1bQ1dNVDgLcPp0aRcFURn0OHEVHP1mvnUzlKdOgWWW09t8KoJNLwZ0+FCeqQ+wz/lcBLwEJZn5Qi4u2NqqKRb5bQ7RGQMxch2WFV58dxRCIB7GFJJ6nEtU8TrbD5Q1+19qv2HPRf52tnmJYrH5IInitCTOwEjTJQutGVgw1BQsTN8fi1h5tp7nGlsajDWP1qZAfMXz+NWgQWCFpoJPNU+sdSmJpG3LcE8x8+BLPgHJ0X0DN4QY5addqa1GGf5RFQxT4+kQonE/J02YN3YTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742383535; c=relaxed/relaxed;
	bh=YUnzkbtrwZH0stapapghGEgR80hWuxX8nLtU7XZASAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT6TWwZ6AJDPtdBiku/r/3JwPXFZimnC5x/iK94CFy1SGjyZY/M1dSRSGILTIEYkYmYUY8q3Z5ePeGG9gAu8FLCD6sbAePRdmLVB4+3OvNU2hX1sGEd8Vn6xNuf7YDtlACJhlK2fJcrlL56ZQBqyRcSlqGSU+63VbSMKcJCWOGERqapIczArFe1++CvWiye3+su7nmB4kLEW4/5QfxiXo10rZ4zACdV4BNw6CGhatwWgzM5RTaYA+SLZpIG+Pl9cbaafVrGS0lq7xtJixLTXU10rszjtjEumZfXBECJyAn6yxsbNNhibpO2QnQm+royGPYcDKntQK7fibwo8gl8GFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UnTEm+vv; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UnTEm+vv; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bfoster@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UnTEm+vv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UnTEm+vv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bfoster@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHmbb6DdFz3cYb
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 22:25:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742383524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUnzkbtrwZH0stapapghGEgR80hWuxX8nLtU7XZASAw=;
	b=UnTEm+vvZWaayapSN04w0DC69ePaPTBPpwTYa51w4rfTZDNtk63FOqgc4d/z3CvrISwZkE
	VY12ml9hbNvglFB3N4VTXw26HdL+WXy+VYQhE+EeCU5a0QakEYYS3f3rnFXRoknC9oCwMd
	KHbAqU1OoJU38PdPOzVqkP/kNRIMHwQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742383524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUnzkbtrwZH0stapapghGEgR80hWuxX8nLtU7XZASAw=;
	b=UnTEm+vvZWaayapSN04w0DC69ePaPTBPpwTYa51w4rfTZDNtk63FOqgc4d/z3CvrISwZkE
	VY12ml9hbNvglFB3N4VTXw26HdL+WXy+VYQhE+EeCU5a0QakEYYS3f3rnFXRoknC9oCwMd
	KHbAqU1OoJU38PdPOzVqkP/kNRIMHwQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-5Rm8FN8UN4KtBfIoD4hPiQ-1; Wed,
 19 Mar 2025 07:25:20 -0400
X-MC-Unique: 5Rm8FN8UN4KtBfIoD4hPiQ-1
X-Mimecast-MFC-AGG-ID: 5Rm8FN8UN4KtBfIoD4hPiQ_1742383518
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A72219560B2;
	Wed, 19 Mar 2025 11:25:18 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.174])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D57D180174E;
	Wed, 19 Mar 2025 11:25:15 +0000 (UTC)
Date: Wed, 19 Mar 2025 07:28:08 -0400
From: Brian Foster <bfoster@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	Bo Liu <liubo03@inspur.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
Message-ID: <Z9qqSHlItlWJCPJz@bfoster>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Mar 19, 2025 at 04:51:25PM +0800, Gao Xiang wrote:
> Previously, iomap_readpage_iter() returning 0 would break out of the
> loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
> relies on.
> 
> However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
> buffered read") changes this behavior without calling
> iomap_iter_advance(), which causes EROFS to get stuck in
> iomap_readpage_iter().
> 
> It seems iomap_iter_advance() cannot be called in
> iomap_read_inline_data() because of the iomap_write_begin() path, so
> handle this in iomap_readpage_iter() instead.
> 
> Reported-and-tested-by: Bo Liu <liubo03@inspur.com>
> Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Ugh. I'd hoped ext4 testing would have uncovered such an issue, but now
that I think of it, IIRC ext4 isn't fully on iomap yet so wouldn't have
provided this coverage. So apologies for the testing oversight on my
part and thanks for the fix.

For future reference, do you guys have any documentation or whatever to
run quick/smoke fstests against EROFS? (I assume this could be
reproduced via fstests..?).

> v1: https://lore.kernel.org/r/20250319025953.3559299-1-hsiangkao@linux.alibaba.com
> change since v1:
>  - iomap_iter_advance() directly instead of `goto done`
>    as suggested by Christoph.
> 
>  fs/iomap/buffered-io.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d52cfdc299c4..814b7f679486 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -372,9 +372,14 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	struct iomap_folio_state *ifs;
>  	size_t poff, plen;
>  	sector_t sector;
> +	int ret;
>  
> -	if (iomap->type == IOMAP_INLINE)
> -		return iomap_read_inline_data(iter, folio);
> +	if (iomap->type == IOMAP_INLINE) {
> +		ret = iomap_read_inline_data(iter, folio);
> +		if (ret)
> +			return ret;
> +		return iomap_iter_advance(iter, &length);
> +	}

Technically you could use iomap_iter_advance_full() here, but since
length is already defined for other purposes it doesn't really make much
difference. LGTM:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  
>  	/* zero post-eof blocks as the page may be mapped */
>  	ifs = ifs_alloc(iter->inode, folio, iter->flags);
> -- 
> 2.43.5
> 


