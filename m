Return-Path: <linux-erofs+bounces-3004-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BSJD3gLxGk+vgQAu9opvQ
	(envelope-from <linux-erofs+bounces-3004-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 17:21:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 47874328DD2
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 17:21:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgsbS3zH1z2yVB;
	Thu, 26 Mar 2026 03:21:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774455668;
	cv=none; b=bBFyS9Jjx+1OJS57uj5Hwg0+WEVlDApfsWPo1hX0njyVnh/an9GsHaQ4cnb2eYr5oYzQ76iZFj6bsXX7UPnrOHhvBTmLpuocSv0+d7D35+pW6Q9C9dcZajMIPlnUHwTVWf64sKZVnfHxuZlF9xDsbgvCxrJBU97wchsh1fZnXZ9qWRqTUN6oM8MkcQD7IbIWrTjoLwhDKb4BuJwGzqHeIzZ9zhIwu70ugItyNObaQYsbR52AUyiZe/C/lce4JmtnSX/5xUwpEMn6JkJjcWNWKOwZbprnJujWU03LV31NqefLitQgwuuE2L4AjwEeqqP/Wkq8YU/vOGd4Hjo3/i8YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774455668; c=relaxed/relaxed;
	bh=30sEGPYmo4wjL7Oo7ljbsi2DNSmoaKkA5yEONMUty08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqa72KnPUQN9xZ+iUA4sAyPMCf54siryPiREmGsY+ikzYHytl+Sw1hUpNBkffmvAMod5AVUChnmgC7tZUGQQF34aqYQPSGeU0zr/ktY8UaVJR4XEPiaIhdna9tx9LpPRO6D8jSzrKkUuS6lO5hcflc3A5v1JnCB2nnxTjWasKuy2zCTt2Lv7Uc0M1syr1Yc3O3Sox39qviK42KZoOmgvmARYWXm0n+ucxZ1dR9D80lS/nG2IfxixX53iZ39MvBeua/FPDvHiJgEWKYa8JiP48of4ovk09wwMspWfRBkRBfIgFGEFZvNwVUzjf4SKVXRP81QF4Gh5f0nBxj1DMdUw8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DCx2cd6z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DCx2cd6z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgsbR3cXrz2yTK
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 03:21:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CDAD1438E8;
	Wed, 25 Mar 2026 16:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44374C4CEF7;
	Wed, 25 Mar 2026 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774455664;
	bh=Mp1C8uMxxYv3PANUHWINKbqxycLFn539lBbC90jp5lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCx2cd6zdjs5WTU0Ci34/oFQ5wXmmkfSsnBz8cMDfEve+sYMCeXPhZU1jOQ/lqQ6J
	 K4fkBqOO0AYOHqX8kdOutVBupk+dZ4inVj6O/4xS800zVfx9V5aJBWzRMhP4QeyEj7
	 dFL7a0cGWZMFi7C3k11k5mMb804D14ZLSuN5c4fUUJiZDNW6RSxOstKalegopwBm1F
	 QPS9KU6uR+nSOcUitxRacDeRokQQd62w8D1jSPIPoEV6V4iHwbFPoCuFPZr0PWaKrZ
	 rzICz3Ro0D4xW72Cz4CSSfywCrOmJ1StSpNEjTTlf9N+GbSJT6ISjmIxo9uRhYdXMM
	 4GvoqkIw17B0g==
Date: Wed, 25 Mar 2026 16:20:52 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, 
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: add vma_desc_test_all() and use it
Message-ID: <ef1e4362-4922-4857-8211-fca47031b63e@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
 <568c8f8d6a84ff64014f997517cba7a629f7eed6.1772704455.git.ljs@kernel.org>
 <20260324161212.4b0a6f4fd5eb57ff2ffa7ea5@linux-foundation.org>
 <24163ac9-bb0d-402c-a028-d1af7f56caa1@lucifer.local>
 <20260325073054.490f2e9658cbd75312732fbd@linux-foundation.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325073054.490f2e9658cbd75312732fbd@linux-foundation.org>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3004-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:pfalcato@suse.de,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@
 lists.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 47874328DD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 07:30:54AM -0700, Andrew Morton wrote:
> On Wed, 25 Mar 2026 07:08:22 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
>
> > On Tue, Mar 24, 2026 at 04:12:12PM -0700, Andrew Morton wrote:
> > > On Thu,  5 Mar 2026 10:50:15 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
> > >
> > > > erofs and zonefs are using vma_desc_test_any() twice to check whether all
> > > > of VMA_SHARED_BIT and VMA_MAYWRITE_BIT are set, this is silly, so add
> > > > vma_desc_test_all() to test all flags and update erofs and zonefs to use
> > > > it.
> > > >
> > > > While we're here, update the helper function comments to be more
> > > > consistent.
> > > >
> > > > Also add the same to the VMA test headers.
> > >
> > > fwiw, we have no review tags on this one.
> >
> > Based on the discussion we had about this previously I was under the impression
> > if submitted by a maintainer that wasn't required?
>
> Well, it's a gray area.  Obviously it's better if people's stuff is
> checked by co-maintainers or by others.

OK that contradicts the previous conversation we had where you had to
convince me that this was ok (which I ended up agreeing with), rather than
being a grey area.

We had quite a long conversation about maintainers are in a trusted role so
a co-maintainer would have called it out it was wrong and etc.

But sure it'd be nice to get review, obviously I agree with that.

>
> I'm not inclined to make a fuss about it though (hence "fwiw").  Quite
> a lot of unreviewed maintainer-authored material ends up going upstream
> and I don't think that's causing much harm.

I think you need to be a lot clearer in communicating these things while
the process remains undocumented.

In this case for instance, I took that to mean that you required review,
the 'fwiw' doesn't really make it clear that this was optional, especially
given this patch is so trivial.

>
> In a lot of cases this is pretty much unavoidable because the patch
> comes from a sole maintainer (SJ, Sergey, Ulad, Liam come to mind).
> But when the author has co-maintainers, perhaps those people could step
> up.

Right.

>
> > I'll nag people, but I'm a bit surprised if this is why you haven't moved this
> > to mm-stable, given how trivially obviously correct this patch is.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/pc/devel-series
> shows my expected merging order.  It looks like this one will be in the
> next batch ->mm-stable.
>

I'll definietly need some decoding of that to understand where each batch
is?

To me it reads as a bunch of inscrutible #'s and file names...

Thanks, Lorenzo

