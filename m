Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB318D5D9
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 18:31:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kW5j1ClCzDwbP
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 04:31:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=EGKIuDKu; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kW5V3ZN3zDvP7
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 04:30:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UGITiyVmaO8X73R6wVMfMGWLW2W7neAq/9meuj1VHqo=; b=EGKIuDKu0tjZuVECGtavPDxi0D
 O6qg1HxEZ5HTL6SQ+HnHGiXg3uMjLMXJy/QxU+RUtVkogm3OV1OoYySDKdd0TNCl75RNBRD/yIw4o
 r5B74nN9dCjwBJMpXdmIQPMo0Dtd++oHnpRNcQiIMtN+2/YTHKBLp/Yz4yXCj69SdRRm0YxhO6rSh
 QXAUKzLbScpAtIooOgBnixq+3fxkEPx9tp3sn8jy4Vs+FM4MKzh0fM6tnnEsYlBa1E1lxlobx/VwW
 F43ky5cdb9YLYKc01lCcZou/2CPPrIQSZW4GwTB3CgHdAptXVKYA1oettmTxaZQrltP3u3grDMdAI
 dACn5xZg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jFLTk-0003g5-Sd; Fri, 20 Mar 2020 17:30:40 +0000
Date: Fri, 20 Mar 2020 10:30:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200320173040.GB4971@bombadil.infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
 <20200320165828.GB851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320165828.GB851@sol.localdomain>
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 09:58:28AM -0700, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> > +	/* Avoid wrapping to the beginning of the file */
> > +	if (index + nr_to_read < index)
> > +		nr_to_read = ULONG_MAX - index + 1;
> > +	/* Don't read past the page containing the last byte of the file */
> > +	if (index + nr_to_read >= end_index)
> > +		nr_to_read = end_index - index + 1;
> 
> There seem to be a couple off-by-one errors here.  Shouldn't it be:
> 
> 	/* Avoid wrapping to the beginning of the file */
> 	if (index + nr_to_read < index)
> 		nr_to_read = ULONG_MAX - index;

I think it's right.  Imagine that index is ULONG_MAX.  We should read one
page (the one at ULONG_MAX).  That would be ULONG_MAX - ULONG_MAX + 1.

> 	/* Don't read past the page containing the last byte of the file */
> 	if (index + nr_to_read > end_index)
> 		nr_to_read = end_index - index + 1;
> 
> I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
> 'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.
> 
> Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
> since otherwise nr_to_read can be increased by 1 rather than decreased or stay
> the same as expected.

Ooh, I missed the overflow case here.  It should be:

+	if (index + nr_to_read - 1 > end_index)
+		nr_to_read = end_index - index + 1;

Let's say index comes in at ULONG_MAX - 2, end_index is ULONG_MAX - 1
and nr_to_read is 8.  The first condition triggers and nr_to_read is
reduced to 3.  But then the second condition wouldn't trigger because
ULONG_MAX - 2 + 3 is 0.

With the rewrite I have in this message, ULONG_MAX - 2 + 3 - 1 is ULONG_MAX,
which is > ULONG_MAX - 1.  So the condition triggers and nr_to_read becomes
(ULONG_MAX - 1) - (ULONG_MAX - 2) + 1.  Which is -1 + 2 + 1, which is 2.
Which is the right answer because we want to read two pages; the one
at ULONG_MAX - 2 and the one at ULONG_MAX - 1.

Thank you!
