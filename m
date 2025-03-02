Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D2A4B1A4
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 13:53:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5MLl5lZjz3bm7
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 23:53:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.149.199.84
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740919998;
	cv=none; b=PYX+DW4VNQBEUrbF21ubMNf2ocRJRr2KPq8R771lDQsdPl1T9KTmwB274TJa6iMwIvGv622TfwB6XtIg5FLO7PQ3g3A9pK+go5BcrRWVjoNYwN30LzIIe0wmD3f+DG0eP4fW1f9uzX5JXs91JhzUfI2ospEyIPcbrMGB826hV6/ezSQC8tz2F2sdD2fZ+R2aeiXrQk0ghvwqBfXBVNP0D1PTT3ZhaxNnt035td+2eFspCTyM3kFh7EShtgKrPhdIWwMq//xEx6XfwjWxfGAUaiP1Z/c0CEEv1rofPyRext0q4hnjephlierXQuZCEX+O2IHtrpdPJFIwUDYSNBI1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740919998; c=relaxed/relaxed;
	bh=2kCk9L1M5nLgpEnWXF5cxI7FaXOo7IflqASoYLhoPLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md8+5poofw+7fAYep18dBGNXgwgrT3X+QRnOXgmcUaIF82+PG+BGOUS1LTcilA57ualluW/T/9Jr9ckvTUL4nS1NMPS+/K5BL926EWANI4QOugga+3ez5eAS5GbxVFnbXe+jI5dTEfxy4BY7G4XPYodLTYHBTrIo/DLUfRHq/fAA8H/fEYuuDRXVS1PKI+a9JoJfm9HefdTD4djBPph8J45e0Rw2x/Ww+wOLMQJ7DEO8IsO8Yz9j/eF7qqAjLB8NaQlU6W9sjlugLwjpLyUtp2at1INokaWtR8Y9UGwYQJRtRObx16+kOJAmbkZu1CstWJ788fyDNDtfh7gJ4eVqaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=opBRFkNa; dkim-atps=neutral; spf=pass (client-ip=83.149.199.84; helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=lists.ozlabs.org) smtp.mailfrom=ispras.ru
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=opBRFkNa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ispras.ru (client-ip=83.149.199.84; helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=lists.ozlabs.org)
X-Greylist: delayed 3589 seconds by postgrey-1.37 at boromir; Sun, 02 Mar 2025 23:53:11 AEDT
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5MLb51v0z303B
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 23:53:10 +1100 (AEDT)
Received: from localhost (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 231AF40CE192;
	Sun,  2 Mar 2025 10:56:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 231AF40CE192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1740912990;
	bh=2kCk9L1M5nLgpEnWXF5cxI7FaXOo7IflqASoYLhoPLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opBRFkNan+maB5S8Bm6tAv9NjAPFFP37BvfEaTOkAZal9qzErsuhBqBfccffyFwlA
	 2mFYgXOhqLNAjSGWu3G2n2RvRtv8bsP9kFJBWIe8/oXfwUL3MBEBSSVYD7z4uqHuC0
	 Lg9vqWPNJXzDGG6URHHltSsf2/roRq0MMrm6JU1k=
Date: Sun, 2 Mar 2025 13:56:29 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexey Panov <apanov@astralinux.ru>
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of
 crafted images properly
Message-ID: <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228165103.26775-2-apanov@astralinux.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 28. Feb 19:51, Alexey Panov wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> commit 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50 upstream.
> 
> syzbot reported a task hang issue due to a deadlock case where it is
> waiting for the folio lock of a cached folio that will be used for
> cache I/Os.
> 
> After looking into the crafted fuzzed image, I found it's formed with
> several overlapped big pclusters as below:
> 
>  Ext:   logical offset   |  length :     physical offset    |  length
>    0:        0..   16384 |   16384 :     151552..    167936 |   16384
>    1:    16384..   32768 |   16384 :     155648..    172032 |   16384
>    2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
> ...
> 
> Here, extent 0/1 are physically overlapped although it's entirely
> _impossible_ for normal filesystem images generated by mkfs.
> 
> First, managed folios containing compressed data will be marked as
> up-to-date and then unlocked immediately (unlike in-place folios) when
> compressed I/Os are complete.  If physical blocks are not submitted in
> the incremental order, there should be separate BIOs to avoid dependency
> issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
> and BIO submission which causes unexpected BIO waits.
> 
> Second, managed folios will be connected to their own pclusters for
> efficient inter-queries.  However, this is somewhat hard to implement
> easily if overlapped big pclusters exist.  Again, these only appear in
> fuzzed images so let's simply fall back to temporary short-lived pages
> for correctness.
> 
> Additionally, it justifies that referenced managed folios cannot be
> truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
> up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
> difference.
> 
> Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
> Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
> Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
> Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
> Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
> [Alexey: minor fix to resolve merge conflict]

Urgh, it doesn't look so minor indeed. Backward struct folio -> struct
page conversions can be tricky sometimes. Please see several comments
below.

> Signed-off-by: Alexey Panov <apanov@astralinux.ru>
> ---
> Backport fix for CVE-2024-47736
> 
>  fs/erofs/zdata.c | 59 +++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 94e9e0bf3bbd..ac01c0ede7f7 100644

I'm looking at the diff of upstream commit and the first thing it does
is to remove zeroing out the folio/page private field here:

  // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
  @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
           * file-backed folios will be used instead.
           */
          if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
  -               folio->private = 0;
                  tocache = true;
                  goto out_tocache;
          }

while in 6.1.129 the corresponding fragment seems untouched with the
backport patch. Is it intended?

> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1346,14 +1346,13 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  		goto out;
>  
>  	lock_page(page);
> -
> -	/* only true if page reclaim goes wrong, should never happen */
> -	DBG_BUGON(justfound && PagePrivate(page));
> -
> -	/* the page is still in manage cache */
> -	if (page->mapping == mc) {
> +	if (likely(page->mapping == mc)) {
>  		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
>  
> +		/*
> +		 * The cached folio is still in managed cache but without

Are the comments worth to be adapted as well? I don't think the "folio"
stuff would be useful while reading 6.1 source code.

> +		 * a valid `->private` pcluster hint.  Let's reconnect them.
> +		 */
>  		if (!PagePrivate(page)) {
>  			/*
>  			 * impossible to be !PagePrivate(page) for
> @@ -1367,22 +1366,24 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  			SetPagePrivate(page);
>  		}
>  
> -		/* no need to submit io if it is already up-to-date */
> -		if (PageUptodate(page)) {
> -			unlock_page(page);
> -			page = NULL;
> +		if (likely(page->private == (unsigned long)pcl)) {
> +			/* don't submit cache I/Os again if already uptodate */
> +			if (PageUptodate(page)) {
> +				unlock_page(page);
> +				page = NULL;
> +
> +			}
> +			goto out;
>  		}
> -		goto out;
> +		/*
> +		 * Already linked with another pcluster, which only appears in
> +		 * crafted images by fuzzers for now.  But handle this anyway.
> +		 */
> +		tocache = false;	/* use temporary short-lived pages */
> +	} else {
> +		DBG_BUGON(1); /* referenced managed folios can't be truncated */
> +		tocache = true;
>  	}
> -
> -	/*
> -	 * the managed page has been truncated, it's unsafe to
> -	 * reuse this one, let's allocate a new cache-managed page.
> -	 */
> -	DBG_BUGON(page->mapping);
> -	DBG_BUGON(!justfound);
> -
> -	tocache = true;
>  	unlock_page(page);
>  	put_page(page);
>  out_allocpage:

There is a whole bunch of out path handling changes done for this function
in upstream commit, like

  // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
   out_allocfolio:
  -       zbv.page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
  +       page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
          spin_lock(&pcl->obj.lockref.lock);
  -       if (pcl->compressed_bvecs[nr].page) {
  -               erofs_pagepool_add(&f->pagepool, zbv.page);
  +       if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
  +               erofs_pagepool_add(&f->pagepool, page);
                  spin_unlock(&pcl->obj.lockref.lock);
                  cond_resched();
                  goto repeat;
          }
  -       bvec->bv_page = pcl->compressed_bvecs[nr].page = zbv.page;
  -       folio = page_folio(zbv.page);
  -       /* first mark it as a temporary shortlived folio (now 1 ref) */
  -       folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
  +       bvec->bv_page = pcl->compressed_bvecs[nr].page = page;
  +       folio = page_folio(page);
          spin_unlock(&pcl->obj.lockref.lock);
   out_tocache:
          if (!tocache || bs != PAGE_SIZE ||
  -           filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp))
  +           filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp)) {
  +               /* turn into a temporary shortlived folio (1 ref) */
  +               folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
                  return;
  +       }
          folio_attach_private(folio, pcl);
          /* drop a refcount added by allocpage (then 2 refs in total here) */
          folio_put(folio);


These changes are probably not relevant for the 6.1.y but this fact is
still usually worth a brief mentioning in the backporter's comment.


> @@ -1536,16 +1537,11 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  		end = cur + pcl->pclusterpages;
>  
>  		do {
> -			struct page *page;
> -
> -			page = pickup_page_for_submission(pcl, i++, pagepool,
> -							  mc);
> -			if (!page)
> -				continue;
> +			struct page *page = NULL;
>  
>  			if (bio && (cur != last_index + 1 ||
>  				    last_bdev != mdev.m_bdev)) {
> -submit_bio_retry:
> +drain_io:
>  				submit_bio(bio);
>  				if (memstall) {
>  					psi_memstall_leave(&pflags);
> @@ -1554,6 +1550,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  				bio = NULL;
>  			}
>  
> +			if (!page) {
> +				page = pickup_page_for_submission(pcl, i++,
> +						pagepool, mc);
> +				if (!page)
> +					continue;
> +			}
> +
>  			if (unlikely(PageWorkingset(page)) && !memstall) {
>  				psi_memstall_enter(&pflags);
>  				memstall = 1;
> @@ -1574,7 +1577,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  			}
>  
>  			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
> -				goto submit_bio_retry;
> +				goto drain_io;
>  
>  			last_index = cur;
>  			bypass = false;
> -- 
> 2.39.5
