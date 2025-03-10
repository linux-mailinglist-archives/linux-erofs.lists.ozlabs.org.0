Return-Path: <linux-erofs+bounces-24-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FAA5898A
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 01:11:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z9y3m0kDWz2yHj;
	Mon, 10 Mar 2025 11:11:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741565476;
	cv=none; b=FrQMrg/m/bnYQbTpKfDuanDamoxlxoVt/Xucncocjz3wZZ93PQot7EYa3nDHxVdhaGQW2pqhCbx/AmEVsbquTlAGXBIltec11tTqERHJMWHRqo3brVJFnbbX35sq/Mi2HcrI8NnCVecK77ED4Ae3VxiK6Z5ip4YLrk7k7jrzkD9+5vLG2/8cvg5P+3cAWUz/Hs5VzspstbGSia/IaQ4dlp89fEcFfkrC0czMNsH6fhCJaKXbMfiluO17Z0tEmmj2obx18WxXKtIkKmlr8TfmxMXlKvlS+HfBvcs/ML5MXxZb6o9qv9e6RNypXH0aj/dw90zT4rKwKpwe/0Y0Fm/lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741565476; c=relaxed/relaxed;
	bh=VKyzFF9sqmXYhDyE0Ctknq3rDxkaHE2kfW5qcx4F3Vw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R79A72T+EcmzDzH+aD/e2Hg4uQHM7HO0VZ80s2rcaDUlkGYyHdC12AVT0m05qTSiXVHGb3AYADTfw6tBlbCqPgtDoYgN7AaHC6dZ26SC0HO5uIAb7zO7Ub9giEgUvSnppAYc0U3K2xX3Q4s2Lzn+D3wMNWGnan1daMVZzPzqmnjbpEgLPOpgKHfEFUVAaEfqpdUdEyOyQtYjcs+HK82LfQGOXbgvw3uiKUuMdvTbciPHynYofFI9CkxfrMLbmGnV1axDsb9YQDArNiqGXzkDVfYLMWq43HDzkV57vUlB56wtEiE9qlRItNU5YNygwcrx2Bo5A4wdJn3Q4cg54gl0Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KDwNqFoQ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CKCBvC+q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KDwNqFoQ; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CKCBvC+q; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KDwNqFoQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CKCBvC+q;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KDwNqFoQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CKCBvC+q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z9y3k2shBz2yGN
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 11:11:14 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37A3D21165;
	Mon, 10 Mar 2025 00:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741565470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKyzFF9sqmXYhDyE0Ctknq3rDxkaHE2kfW5qcx4F3Vw=;
	b=KDwNqFoQ1OfaFxm4+cFRAPQG/9lynj1ynPLvXyUtW/eDH0KUuIYqPg5O72cpxP/Zk1C/Y+
	mehlBAkI9r02PjZFfCVLIG6S//j5OTq2c8ulSv29hm21UuGi+iN+usKAhsqGTGV0XBYiJa
	mmhD6HUTTzVjz6QdBRenk6UuDxAESdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741565470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKyzFF9sqmXYhDyE0Ctknq3rDxkaHE2kfW5qcx4F3Vw=;
	b=CKCBvC+qBGhb131WpP1iP4N9DXwY1T6wcW+5i8EpcqALKXBl5exCvK3fTYcuJC9NtT9axO
	1sE6tGKLUorcLgAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KDwNqFoQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CKCBvC+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741565470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKyzFF9sqmXYhDyE0Ctknq3rDxkaHE2kfW5qcx4F3Vw=;
	b=KDwNqFoQ1OfaFxm4+cFRAPQG/9lynj1ynPLvXyUtW/eDH0KUuIYqPg5O72cpxP/Zk1C/Y+
	mehlBAkI9r02PjZFfCVLIG6S//j5OTq2c8ulSv29hm21UuGi+iN+usKAhsqGTGV0XBYiJa
	mmhD6HUTTzVjz6QdBRenk6UuDxAESdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741565470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKyzFF9sqmXYhDyE0Ctknq3rDxkaHE2kfW5qcx4F3Vw=;
	b=CKCBvC+qBGhb131WpP1iP4N9DXwY1T6wcW+5i8EpcqALKXBl5exCvK3fTYcuJC9NtT9axO
	1sE6tGKLUorcLgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22EDB139E7;
	Mon, 10 Mar 2025 00:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vGLtMQ8uzmfhQQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 10 Mar 2025 00:10:55 +0000
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
To: "Yunsheng Lin" <yunshenglin0825@gmail.com>
Cc: "Yunsheng Lin" <linyunsheng@huawei.com>, "Qu Wenruo" <wqu@suse.com>,
 "Yishai Hadas" <yishaih@nvidia.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
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
In-reply-to: <7abb0e8c-f565-48f0-a393-8dabbabc3fe2@gmail.com>
References: <>, <7abb0e8c-f565-48f0-a393-8dabbabc3fe2@gmail.com>
Date: Mon, 10 Mar 2025 11:10:48 +1100
Message-id: <174156544867.33508.5386967459254083056@noble.neil.brown.name>
X-Rspamd-Queue-Id: 37A3D21165
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,suse.com,nvidia.com,ziepe.ca,intel.com,redhat.com,fb.com,toxicpanda.com,kernel.org,gmail.com,linux.alibaba.com,google.com,linux-foundation.org,linaro.org,davemloft.net,oracle.com,talpey.com,techsingularity.net,fromorbit.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RLodizb9et8yqpuyyezexhwnjp)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Mon, 10 Mar 2025, Yunsheng Lin wrote:
> On 3/8/2025 5:02 AM, NeilBrown wrote:
>=20
> ...
>=20
> >>
> >>>    allocated pages in the array - just like the current
> >>>    alloc_pages_bulk().
> >>
> >> I guess 'the total number of allocated pages in the array ' include
> >> the pages which are already in the array before calling the above
> >> API?
> >=20
> > Yes - just what the current function does.
> > Though I don't know that we really need that detail.
> > I think there are three interesting return values:
> >=20
> > - hard failure - don't bother trying again soon:   maybe -ENOMEM
> > - success - all pages are allocated:  maybe 0 (or 1?)
> > - partial success - at least one page allocated, ok to try again
> >    immediately - maybe -EAGAIN (or 0).
>=20
> Yes, the above makes sense. And I guess returning '-ENOMEM' & '0' &
> '-EAGAIN' seems like a more explicit value.
>=20
> >=20
> >>
>=20
> ...
>=20
> >>
> >=20
> > If I were do work on this (and I'm not, so you don't have to follow my
> > ideas) I would separate the bulk_alloc into several inline functions and
> > combine them into the different interfaces that you want.  This will
> > result in duplicated object code without duplicated source code.  The
> > object code should be optimal.
>=20
> Thanks for the detailed suggestion, it seems feasible.
> If the 'add to a linked list' dispose was not removed in the [1],
> I guess it is worth trying.
> But I am not sure if it is still worth it at the cost of the above
> mentioned 'duplicated object code' considering the array defragmenting
> seem to be able to unify the dispose of 'add to end of array' and
> 'add to next hole in array'.
>=20
> I guess I can try with the easier one using array defragmenting first,
> and try below if there is more complicated use case.

Your post observes a performance improvement - slight though it is.
I might be worth measuring the performance change for a case that
requires defragmenting to see how that compares.

Thanks,
NeilBrown


>=20
> 1.=20
> https://lore.kernel.org/all/f1c75db91d08cafd211eca6a3b199b629d4ffe16.173499=
1165.git.luizcap@redhat.com/
>=20
> >=20
> > The parts of the function are:
> >   - validity checks - fallback to single page allocation
> >   - select zone - fallback to single page allocation
> >   - allocate multiple pages in the zone and dispose of them
> >   - allocate a single page
> >=20
> > The "dispose of them" is one of
> >    - add to a linked list
> >    - add to end of array
> >    - add to next hole in array
> >=20
> > These three could be inline functions that the "allocate multiple pages"
> > and "allocate single page" functions call.  We can pass these as
> > function arguments and the compile will inline them.
> > I imagine these little function would take one page and return
> > a bool indicating if any more are wanted.
> >=20
> > The three functions: alloc_bulk_array alloc_bulk_list
> > alloc_bulk_refill_array would each look like:
> >=20
> >    validity checks: do we need to allocate anything?
> >=20
> >    if want more than one page &&
> >       am allowed to do mulipage (e.g. not __GFP_ACCOUNT) &&
> >       zone =3D choose_zone() {
> >          alloc_multi_from_zone(zone, dispose_function)
> >    }
> >    if nothing allocated
> >       alloc_single_page(dispose_function)
> >=20
> > Each would have a different dispose_function and the initial checks
> > would be quite different, as would the return value.
> >=20
> > Thanks for working on this.
> >=20
> > NeilBrown
> >=20
>=20
>=20


