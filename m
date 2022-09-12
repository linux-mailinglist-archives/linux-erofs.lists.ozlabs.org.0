Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDAA5B5652
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Sep 2022 10:35:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MR0KG0gl4z3062
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Sep 2022 18:35:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN>)
X-Greylist: delayed 66 seconds by postgrey-1.36 at boromir; Mon, 12 Sep 2022 18:35:09 AEST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MR0K96zC8z3062
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Sep 2022 18:35:09 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4FDB468B05; Mon, 12 Sep 2022 10:35:05 +0200 (CEST)
Date: Mon, 12 Sep 2022 10:35:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <20220912083504.GB11318@lst.de>
References: <20220910065058.3303831-1-hch@lst.de> <20220910065058.3303831-2-hch@lst.de> <bcabe527-7940-8658-1728-28d64bd3cf80@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcabe527-7940-8658-1728-28d64bd3cf80@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Sep 10, 2022 at 05:34:02AM -0600, Jens Axboe wrote:
> >  	/* Start the actual read. The read will unlock the page. */
> > +	if (unlikely(workingset))
> > +		psi_memstall_enter(&pflags);
> >  	error = filler(file, folio);
> > +	if (unlikely(workingset))
> > +		psi_memstall_leave(&pflags);
> >  	if (error)
> >  		return error;
> 
> I think this would read better as:
> 
>   	/* Start the actual read. The read will unlock the page. */
> 	if (unlikely(workingset)) {
> 		psi_memstall_enter(&pflags);
> 		error = filler(file, folio);
> 		psi_memstall_leave(&pflags);
> 	} else {
> 		error = filler(file, folio);
> 	}
>   	if (error)
>   		return error;

I had it both ways.  For any non-trivial code in the conditionals I
tend to go with your version all the time.  But for two times a single
lines both variants tends to suck, so I can live with either one.
