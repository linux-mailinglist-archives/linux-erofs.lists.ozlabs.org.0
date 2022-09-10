Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D495B47EA
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 20:27:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MQ1YS1TXWz3bd5
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Sep 2022 04:27:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hm0jlUjj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hm0jlUjj;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MQ1YH56vKz306l
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Sep 2022 04:27:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HzbaF/w2gu/Kp3W2KzeU3D5B1emioVuvk2oKXIlN0co=; b=hm0jlUjj5UPTktuEEfUHRHbtOL
	h5E5opUGiLigsiUuo00mrPc/A4xSEK8VCx+Yx+3vbGl8ODfANdUXogLnu7f5zh29M33K+0qsQ/es7
	0xTIeKa1vqEKoFetp/WoYtCPF63JIlhvk76Rm/3uAW6SG6gLhu1HtMF1559ykvfauNUIOqkPbJCfj
	SIoFYzlt82k3xuVcsZtHS43gi4yUwtW69NwP0xZHAbA5vyoTXRt5vhNkTe5yeDQjOohy7QJmhScaI
	aDGg00fQdrkBdudzVC5CiEHwVo3HXgsI09f4qFaQknUW4ND6l2DYCkrfLZYuIEhUDs75cOwkuqbmG
	2b9Uyy1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX5Bb-00EFd2-Lx; Sat, 10 Sep 2022 18:26:35 +0000
Date: Sat, 10 Sep 2022 19:26:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <YxzW2wZzhaDvjS1c@casper.infradead.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Sep 10, 2022 at 08:50:54AM +0200, Christoph Hellwig wrote:
> @@ -480,11 +487,14 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
>  	if (index == mark)
>  		folio_set_readahead(folio);
>  	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
> -	if (err)
> +	if (err) {
>  		folio_put(folio);
> -	else
> -		ractl->_nr_pages += 1UL << order;
> -	return err;
> +		return err;
> +	}
> +
> +	ractl->_nr_pages += 1UL << order;
> +	ractl->_workingset = folio_test_workingset(folio);

I don't have time to look at this properly right now (about to catch a
bus to the plane), but I think this should be |=, not =?

