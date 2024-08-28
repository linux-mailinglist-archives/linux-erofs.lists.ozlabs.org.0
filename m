Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5D962649
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 13:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724845622;
	bh=M9H3cmWIhxcYHesHqGjL9yLjjaE0Sjuz4VP0wEL0R1w=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=B5S1qN3MEOK/IxSGESIwPX1oP62OUZ3HQpruHtdr7HDFgVuA9T12fpb8UFeQFtezE
	 Pm5SXi7DQEDiiukKBa6wCv+NU2NsS5Lnp4xpGWLpGnxgAhp/mod2yNLxLHfRmmLt08
	 oud0XKzwn9ApntGvRirJySoE55VQnZINbD0dAGdvnwffdBJ5lqWMmlqmAd9s4KdLyo
	 VpJIx8pW0agCl0EXKrAr17kgpnv82E/DWvrykPAV81I9mUJY2x7JKhfZSZjc/y0eUz
	 3FO2Kl7HRBw3SWnoEkKTmucfIvp1u/585mV/oywwmjx095+X7FZIyAte2s87xSMib/
	 OtSl9ZzzJ7lsw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv2h65WKKz2yk3
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 21:47:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724845621;
	cv=none; b=ModNSCkrXvizz7JiFy9M3GQ7CXsdx/LzwNyHP/Wc7yP7TfPPdqsWOPRTe2DWo5VvfvPrDm+fFGwspe2oYxSak/DCq2ElAalQnNzYO0DpY5SMArvRZWx8YpzHyCzd7342iDKaT7gY7Y6jQ3Kh/8/auirEbbAobsjB9mr0iV/iuNsjAgiZ+jwZ7AEVFFNiLkrTDU0X13UBL5eXvf9tmClJn1FT+fOknyIgEz4iBvOHFfJgNgu73ZX+UbOhT9YQTcvtj3edbqN5hCa2wpUBbKEGFyCz3hKwdr7z8jfKt0qngxReEhBZw+UZAN5HjBcIAXhlMtqaoC0uf7ZfHaFOj8z+og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724845621; c=relaxed/relaxed;
	bh=M9H3cmWIhxcYHesHqGjL9yLjjaE0Sjuz4VP0wEL0R1w=;
	h=X-Greylist:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gYpVTXF2MjrP3sOcwKEZLiuvQhuZfAGHBkdXAqFnd/2oB8WjKD2RpJ+Wpq6QZaVo2bqgJyHnTMsgSFvykbAGbYdiCKMQVfdGKbmUpsnzjZaGa1gAVzbrkCSQ29jrGWBarGx0xOK5CIQ2IN3uC49JD1W8f7F7VnH3j6J7CAMKEkABFUL910Zn/it26gkz6XpeGDQiOHJMDTv33V6Oc+lW8TxR+ukGMm0AwDsN1SePNsYy3zGi69bHMIw2T1hOXy06TG3TOfkNv/Aw1QnTOxrBJ14QDXTKu6YerTsh8dsL2BEal3U0b3JC5u6GnHmRB64zS6l/as8IMQlWvr3aN8NJuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; dkim=pass (2048-bit key; unprotected) header.d=pankajraghav.com header.i=@pankajraghav.com header.a=rsa-sha256 header.s=MBO0001 header.b=mJLhydL7; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=kernel@pankajraghav.com; receiver=lists.ozlabs.org) smtp.mailfrom=pankajraghav.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=pankajraghav.com header.i=@pankajraghav.com header.a=rsa-sha256 header.s=MBO0001 header.b=mJLhydL7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pankajraghav.com (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=kernel@pankajraghav.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 517 seconds by postgrey-1.37 at boromir; Wed, 28 Aug 2024 21:47:01 AEST
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv2h50FC5z2xH9
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 21:47:00 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wv2Tr0lJSz9smc;
	Wed, 28 Aug 2024 13:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724845088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9H3cmWIhxcYHesHqGjL9yLjjaE0Sjuz4VP0wEL0R1w=;
	b=mJLhydL76GrRuW737D6RbtsIACkQniYpae63FPhyPs9Pee+QHLNrfzj/Dn6gSl2+qVcAck
	MVhc292Hk0qoYqRGPD9zpnjIJaX8d5O1yrEGSsYMHhB1+EF4LynKehX/Qv4NwsOAORThkP
	k5bWZcHdv0PyZBZcaqlBvqgtANUpntIsXofOCzDNTvyXHhr67zhJgWGQGo5atd0XckJdjA
	rR8WlNWo6KNpCx03tSIETgCaJaWlHH6X25OSelFFa9ulW6U63lsK1ZpkkPI1xPEYndn84+
	YFzGD2FOYgW6xaGMmQg8fuRa8gQKRsMbN/YCojlBlhbfJL6rkfQG9gO0UIpgVg==
Date: Wed, 28 Aug 2024 11:38:02 +0000
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/9] mm: Fix missing folio invalidation calls during
 truncation
Message-ID: <20240828113802.xw5wzlq2hxrquclb@quentin>
References: <20240823200819.532106-1-dhowells@redhat.com>
 <20240823200819.532106-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823200819.532106-2-dhowells@redhat.com>
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
From: "Pankaj Raghav \(Samsung\) via Linux-erofs" <linux-erofs@lists.ozlabs.org>
Reply-To: "Pankaj Raghav \(Samsung\)" <kernel@pankajraghav.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 23, 2024 at 09:08:09PM +0100, David Howells wrote:
> When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
> ->invalidate_folio() calls should be invoked even if PG_private and
> PG_private_2 aren't set.  This is used by netfslib to keep track of the
Should we update the comment in pagemap? 

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 55b254d951da..18dd6174e6cc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,7 +204,8 @@ enum mapping_flags {
        AS_EXITING      = 4,    /* final truncate in progress */
        /* writeback related tags are not used */
        AS_NO_WRITEBACK_TAGS = 5,
-       AS_RELEASE_ALWAYS = 6,  /* Call ->release_folio(), even if no private data */
+       AS_RELEASE_ALWAYS = 6,  /* Call ->release_folio() and ->invalidate_folio,
+                                  even if no private data */
        AS_STABLE_WRITES = 7,   /* must wait for writeback before modifying
                                   folio contents */
        AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */

> point above which reads can be skipped in favour of just zeroing pagecache
> locally.
> 
> There are a couple of places in truncation in which invalidation is only
> called when folio_has_private() is true.  Fix these to check
> folio_needs_release() instead.
> 
> Without this, the generic/075 and generic/112 xfstests (both fsx-based
> tests) fail with minimum folio size patches applied[1].
> 
> Fixes: b4fa966f03b7 ("mm, netfs, fscache: stop read optimisation when folio removed from pagecache")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: Pankaj Raghav <p.raghav@samsung.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
> ---
>  mm/truncate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 4d61fbdd4b2f..0668cd340a46 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -157,7 +157,7 @@ static void truncate_cleanup_folio(struct folio *folio)
>  	if (folio_mapped(folio))
>  		unmap_mapping_folio(folio);
>  
> -	if (folio_has_private(folio))
> +	if (folio_needs_release(folio))
>  		folio_invalidate(folio, 0, folio_size(folio));
>  
>  	/*
> @@ -219,7 +219,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>  	if (!mapping_inaccessible(folio->mapping))
>  		folio_zero_range(folio, offset, length);
>  
> -	if (folio_has_private(folio))
> +	if (folio_needs_release(folio))
>  		folio_invalidate(folio, offset, length);
>  	if (!folio_test_large(folio))
>  		return true;
> 

-- 
Pankaj Raghav
