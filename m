Return-Path: <linux-erofs+bounces-19-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D70A57342
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Mar 2025 22:03:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z8dzm1dLRz304l;
	Sat,  8 Mar 2025 08:03:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741381396;
	cv=none; b=EzAQklN5UASkWRzzqemYVuqPZUt+nsIY7JN4CFLJuMSk6GeIfGxAgPtwUi+yY8dt/4pM1B1Vm9uGlK2yfsU3U/BoTV7LUHmbmMBHyYlGbFtNK+As+VL+K9m42oU573fVKS57ZJu8+gMEdPsTkjYGkJKDP49jl3/BVujMbxGpkher1Wg4APiQCDPqfDq16CN4a/X86NWbPVLsv1qCuPBZsk/zcq0EtWHDkWGJFJCL0ExxPFe+fcL9KmCer5qE0fBysLd6JzLyTNrApsULFhIBYXGBtk7NgGgPILX0PTLx9DbBZUJ+NtM6/y5DVSusMD+Ex6pc6fyjv33ca77CfDgPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741381396; c=relaxed/relaxed;
	bh=SeeNN8WijZM3sVfCjyeRNRQLGOYyO7I+SwMdGI2UCi0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TfjlNtV1gR1+ZQTIu5uF4b3/brTeSx+saReaf7iUhx9r47qmQ/hbZ9x+U6fMDbUC5uchcehwVL0kH6gZox2fh29vWEgQ3sYMpcXNvgLUvdcQUVaNE3iY9ZkFxgTLP4GAGrx7IiRPWIGDAALTbz9p/t6tCDCJ7gN6mWrJ6cQJ0E1+Bl/fOhliANqSq0B1MU1RlkX1Zcn6PsZ3PFDfzbZ6eC1qcX+tURbV6nqEcnHw3YHXZxqORzSEWnm/HTR8WZtFgSWDKYvB+A3eq+Cv2LQHMw6FbJoLRnEoTKXlg6HaLZ7t9VSBuJbfvCeQjWbl0LMRSk7mfVA0oagTjN9KXoF1/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MicE/ni5; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8A54Cpgc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MicE/ni5; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8A54Cpgc; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MicE/ni5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8A54Cpgc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MicE/ni5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8A54Cpgc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z8dzk4fvZz2yyR
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Mar 2025 08:03:14 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 423291F38C;
	Fri,  7 Mar 2025 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741381390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeeNN8WijZM3sVfCjyeRNRQLGOYyO7I+SwMdGI2UCi0=;
	b=MicE/ni5QVZNboYLfbQqJojSAmZSE4YbcSZ+jGSbBWfh8IQF829y2DeHc73Ukv/tF7wGKQ
	oGtJck1+L37gBJVIBCHp6bvc5/VIZYUHIpstYW9yZYF5LloPATpYlmL3cj2QsRVqc+zlLk
	pJWy0w2SRWEarT/ZVxSL/xPPfRRvb60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741381390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeeNN8WijZM3sVfCjyeRNRQLGOYyO7I+SwMdGI2UCi0=;
	b=8A54CpgcbZFo2WBEOShK6vmH7gpvXhEUUupqa8xg1StwWAgAylSdVixz5SmsSlIRrg0Kzd
	irQSLzmu3PpSKYDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741381390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeeNN8WijZM3sVfCjyeRNRQLGOYyO7I+SwMdGI2UCi0=;
	b=MicE/ni5QVZNboYLfbQqJojSAmZSE4YbcSZ+jGSbBWfh8IQF829y2DeHc73Ukv/tF7wGKQ
	oGtJck1+L37gBJVIBCHp6bvc5/VIZYUHIpstYW9yZYF5LloPATpYlmL3cj2QsRVqc+zlLk
	pJWy0w2SRWEarT/ZVxSL/xPPfRRvb60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741381390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeeNN8WijZM3sVfCjyeRNRQLGOYyO7I+SwMdGI2UCi0=;
	b=8A54CpgcbZFo2WBEOShK6vmH7gpvXhEUUupqa8xg1StwWAgAylSdVixz5SmsSlIRrg0Kzd
	irQSLzmu3PpSKYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307A613939;
	Fri,  7 Mar 2025 21:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oTgBNf9ey2doIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Mar 2025 21:02:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
From: "NeilBrown" <neilb@suse.de>
To: "Yunsheng Lin" <linyunsheng@huawei.com>
Cc: "Qu Wenruo" <wqu@suse.com>, "Yishai Hadas" <yishaih@nvidia.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
 "Kevin Tian" <kevin.tian@intel.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, "Chris Mason" <clm@fb.com>,
 "Josef Bacik" <josef@toxicpanda.com>, "David Sterba" <dsterba@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>, "Carlos Maiolino" <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Luiz Capitulino" <luizcap@redhat.com>,
 "Mel Gorman" <mgorman@techsingularity.net>,
 "Dave Chinner" <david@fromorbit.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
In-reply-to: <180818a1-b906-4a0b-89d3-34cb71cc26c9@huawei.com>
References: <>, <180818a1-b906-4a0b-89d3-34cb71cc26c9@huawei.com>
Date: Sat, 08 Mar 2025 08:02:50 +1100
Message-id: <174138137096.33508.11446632870562394754@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,nvidia.com,ziepe.ca,huawei.com,intel.com,redhat.com,fb.com,toxicpanda.com,kernel.org,gmail.com,linux.alibaba.com,google.com,linux-foundation.org,linaro.org,davemloft.net,oracle.com,talpey.com,techsingularity.net,fromorbit.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL4q5k5kyydt8nhc3xa4shdp4c),from(RLewrxuus8mos16izbn)]
X-Spam-Score: -4.30
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Fri, 07 Mar 2025, Yunsheng Lin wrote:
> On 2025/3/7 5:14, NeilBrown wrote:
> > On Thu, 06 Mar 2025, Yunsheng Lin wrote:
> >> On 2025/3/6 7:41, NeilBrown wrote:
> >>> On Wed, 05 Mar 2025, Yunsheng Lin wrote:
> >>>>
> >>>> For the existing btrfs and sunrpc case, I am agreed that there
> >>>> might be valid use cases too, we just need to discuss how to
> >>>> meet the requirements of different use cases using simpler, more
> >>>> unified and effective APIs.
> >>>
> >>> We don't need "more unified".
> >>
> >> What I meant about 'more unified' is how to avoid duplicated code as
> >> much as possible for two different interfaces with similar=E2=80=8C func=
tionality.
> >>
> >> The best way I tried to avoid duplicated code as much as possible is
> >> to defragment the page_array before calling the alloc_pages_bulk()
> >> for the use case of btrfs and sunrpc so that alloc_pages_bulk() can
> >> be removed of the assumption populating only NULL elements, so that
> >> the API is simpler and more efficient.
> >>
> >>>
> >>> If there are genuinely two different use cases with clearly different
> >>> needs - even if only slightly different - then it is acceptable to have
> >>> two different interfaces.  Be sure to choose names which emphasise the
> >>> differences.
> >>
> >> The best name I can come up with for the use case of btrfs and sunrpc
> >> is something like alloc_pages_bulk_refill(), any better suggestion about
> >> the naming?
> >=20
> > I think alloc_pages_bulk_refill() is a good name.
> >=20
> > So:
> > - alloc_pages_bulk() would be given an uninitialised array of page
> >   pointers and a required count and would return the number of pages
> >   that were allocated
> > - alloc_pages_bulk_refill() would be given an initialised array of page
> >   pointers some of which might be NULL.  It would attempt to allocate
> >   pages for the non-NULL pointers and return the total number of
>=20
> You meant 'NULL pointers' instead of 'non-NULL pointers' above?

Correct - thanks.

>=20
> >   allocated pages in the array - just like the current
> >   alloc_pages_bulk().
>=20
> I guess 'the total number of allocated pages in the array ' include
> the pages which are already in the array before calling the above
> API?

Yes - just what the current function does.
Though I don't know that we really need that detail.
I think there are three interesting return values:

- hard failure - don't bother trying again soon:   maybe -ENOMEM
- success - all pages are allocated:  maybe 0 (or 1?)
- partial success - at least one page allocated, ok to try again
  immediately - maybe -EAGAIN (or 0).

>=20
> I guess it is worth mentioning that the current alloc_pages_bulk()
> may return different value with the same size of arrays, but with
> different layout of the same number of NULL pointers.
> For the same size of arrays with different layout for the NULL pointer
> below('*' indicate NULL pointer), and suppose buddy allocator is only
> able to allocate two pages:
> 1. P**P*P: will return 4.
> 2. P*PP**: will return 5.

I guess the documentation for the function is wrong then.
They lends weight to the suggestion that the current return value isn't
ideal.

>=20
> If the new API do the page defragmentation, then it will always return
> the same value for different layout of the same number of NULL pointers.
> I guess the new one is the more perfered behavior as it provides a more
> defined semantic.
>=20
> >=20
> > sunrpc could usefully use both of these interfaces.
> >=20
> > alloc_pages_bulk() could be implemented by initialising the array and
> > then calling alloc_pages_bulk_refill().  Or alloc_pages_bulk_refill()
> > could be implemented by compacting the pages and then calling
> > alloc_pages_bulk().
> > If we could duplicate the code and have two similar but different
> > functions.
> >=20
> > The documentation for _refill() should make it clear that the pages
> > might get re-ordered.
>=20
> Does 'the pages might get re-ordered' mean defragmenting the page_array?
> If yes, it makes sense to make it clear.

Correct.  Defragmentation is an option for implementing refill.  We
shouldn't promise to do that, but we should define the API in such a way
that it is allowed.

>=20
> >=20
> > Having looked at some of the callers I agree that the current interface
> > is not ideal for many of them, and that providing a simpler interface
> > would help.
>=20
> +1
>=20
> >=20
> > Thanks,
> > NeilBrown
>=20

If I were do work on this (and I'm not, so you don't have to follow my
ideas) I would separate the bulk_alloc into several inline functions and
combine them into the different interfaces that you want.  This will
result in duplicated object code without duplicated source code.  The
object code should be optimal.

The parts of the function are:
 - validity checks - fallback to single page allocation
 - select zone - fallback to single page allocation
 - allocate multiple pages in the zone and dispose of them
 - allocate a single page

The "dispose of them" is one of
  - add to a linked list
  - add to end of array
  - add to next hole in array

These three could be inline functions that the "allocate multiple pages"
and "allocate single page" functions call.  We can pass these as
function arguments and the compile will inline them.
I imagine these little function would take one page and return
a bool indicating if any more are wanted.

The three functions: alloc_bulk_array alloc_bulk_list
alloc_bulk_refill_array would each look like:

  validity checks: do we need to allocate anything?

  if want more than one page &&
     am allowed to do mulipage (e.g. not __GFP_ACCOUNT) &&
     zone =3D choose_zone() {
        alloc_multi_from_zone(zone, dispose_function)
  }
  if nothing allocated
     alloc_single_page(dispose_function)

Each would have a different dispose_function and the initial checks
would be quite different, as would the return value.

Thanks for working on this.

NeilBrown

