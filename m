Return-Path: <linux-erofs+bounces-14-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CEA5587F
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Mar 2025 22:14:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z82HV47s3z2ydQ;
	Fri,  7 Mar 2025 08:14:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741295686;
	cv=none; b=AchDOr8+KRcWsBicXc7fczFgDhq1ZaYJw5W8PP2hjN6WiLXmxLfcTloflMGrLiv1jh4WU7xV/3gc7GxiKu00L/MMUM9vDgm2oijX591U8SxWc76BNtUrcoano7E0PK0xgjvjVIAyL9Gvxof6xk3/reCkqEpZMavN5Q3k/Mkc9l96OOUxtt4+BoO/gtgyRo3AG3ga+qnnpCNvHfZk3x7Ad1RA3hq5EUAtO5OjUaYNyNtb2x5yiMcR7zSwzfvhkY2ebQM1A9VfRvT5/7nU+V42fyd9ZRsKXyoEVFmV57Btoa0P67HQ4lPs2r+tsmvdFH+dKBG1GoKvpDyJNhhNh3QxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741295686; c=relaxed/relaxed;
	bh=W8wPE8KKZYE0b2eeWO1d4HM7Dis42luxW+pjVxoJ1rs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YqXu+CSM0ysb2nudO0SrVKqVYyJcAc6PdlxnIpOb09YaLBf33sbR7cIUvizQlVBHBqpdW3IY6+EdvHVIUaNx6nBMwrX6O9plpfisvXbNkmeN8Z/0ZFdmfo8gPRBnkebt4zsWUB/fzO3MW6xKzW8xlNfLawc6IeyQzW5Rywc8g0oB+R1tTQE1rVnHm3vfEIDjba5jY42tfvN9n4On7Vdg0bxWLla37ugyCYp8wDTV9JIaXaB1i+sTxL79eze4yy/1JDmyYy5438nG+QTG3AjpGtDVj8dI9BcEjsylAfhdsj6+xaJmxglrjtpXEWo34qPw/uJmqFqfr68tbcDV0F/IMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tKlJ2CN0; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cuwYJRYL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tKlJ2CN0; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cuwYJRYL; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tKlJ2CN0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cuwYJRYL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tKlJ2CN0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cuwYJRYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z82HS6JRyz2yVV
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Mar 2025 08:14:44 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3BE321172;
	Thu,  6 Mar 2025 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741295675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8wPE8KKZYE0b2eeWO1d4HM7Dis42luxW+pjVxoJ1rs=;
	b=tKlJ2CN0wPg7rRWhJblyU+m6/5JlLhvjqJs9DUQdv95bf35qpGhbrKpwR4L1ubUl6HHzMC
	ojHovccIPbw0DHajEIngncj4h9SzsPp7jcDSVykyVxYvu+K6xi485lt2OJtDUqbxaO8V2q
	1Vt+eGq4eU93co2ldGDFw3X1pdN63uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741295675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8wPE8KKZYE0b2eeWO1d4HM7Dis42luxW+pjVxoJ1rs=;
	b=cuwYJRYLTPadg9cLaIfWHdAJDR33+mWHNeymeUhWYbcZ+XGJ68tR+aeh5VXxvpzyhsQA8a
	TbH2enWt9B0YdnCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741295675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8wPE8KKZYE0b2eeWO1d4HM7Dis42luxW+pjVxoJ1rs=;
	b=tKlJ2CN0wPg7rRWhJblyU+m6/5JlLhvjqJs9DUQdv95bf35qpGhbrKpwR4L1ubUl6HHzMC
	ojHovccIPbw0DHajEIngncj4h9SzsPp7jcDSVykyVxYvu+K6xi485lt2OJtDUqbxaO8V2q
	1Vt+eGq4eU93co2ldGDFw3X1pdN63uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741295675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8wPE8KKZYE0b2eeWO1d4HM7Dis42luxW+pjVxoJ1rs=;
	b=cuwYJRYLTPadg9cLaIfWHdAJDR33+mWHNeymeUhWYbcZ+XGJ68tR+aeh5VXxvpzyhsQA8a
	TbH2enWt9B0YdnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D40E13A61;
	Thu,  6 Mar 2025 21:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MBkAMC0QymdSewAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Mar 2025 21:14:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
In-reply-to: <f834a7cd-ca0a-4495-a787-134810aa0e4d@huawei.com>
References: <>, <f834a7cd-ca0a-4495-a787-134810aa0e4d@huawei.com>
Date: Fri, 07 Mar 2025 08:14:14 +1100
Message-id: <174129565467.33508.7106343513316364028@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,nvidia.com,ziepe.ca,huawei.com,intel.com,redhat.com,fb.com,toxicpanda.com,kernel.org,gmail.com,linux.alibaba.com,google.com,linux-foundation.org,linaro.org,davemloft.net,oracle.com,talpey.com,techsingularity.net,fromorbit.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RL4q5k5kyydt8nhc3xa4shdp4c),from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Thu, 06 Mar 2025, Yunsheng Lin wrote:
> On 2025/3/6 7:41, NeilBrown wrote:
> > On Wed, 05 Mar 2025, Yunsheng Lin wrote:
> >>
> >> For the existing btrfs and sunrpc case, I am agreed that there
> >> might be valid use cases too, we just need to discuss how to
> >> meet the requirements of different use cases using simpler, more
> >> unified and effective APIs.
> > 
> > We don't need "more unified".
> 
> What I meant about 'more unified' is how to avoid duplicated code as
> much as possible for two different interfaces with similar‌ functionality.
> 
> The best way I tried to avoid duplicated code as much as possible is
> to defragment the page_array before calling the alloc_pages_bulk()
> for the use case of btrfs and sunrpc so that alloc_pages_bulk() can
> be removed of the assumption populating only NULL elements, so that
> the API is simpler and more efficient.
> 
> > 
> > If there are genuinely two different use cases with clearly different
> > needs - even if only slightly different - then it is acceptable to have
> > two different interfaces.  Be sure to choose names which emphasise the
> > differences.
> 
> The best name I can come up with for the use case of btrfs and sunrpc
> is something like alloc_pages_bulk_refill(), any better suggestion about
> the naming?

I think alloc_pages_bulk_refill() is a good name.

So:
- alloc_pages_bulk() would be given an uninitialised array of page
  pointers and a required count and would return the number of pages
  that were allocated
- alloc_pages_bulk_refill() would be given an initialised array of page
  pointers some of which might be NULL.  It would attempt to allocate
  pages for the non-NULL pointers and return the total number of
  allocated pages in the array - just like the current
  alloc_pages_bulk().

sunrpc could usefully use both of these interfaces.

alloc_pages_bulk() could be implemented by initialising the array and
then calling alloc_pages_bulk_refill().  Or alloc_pages_bulk_refill()
could be implemented by compacting the pages and then calling
alloc_pages_bulk().
If we could duplicate the code and have two similar but different
functions.

The documentation for _refill() should make it clear that the pages
might get re-ordered.

Having looked at some of the callers I agree that the current interface
is not ideal for many of them, and that providing a simpler interface
would help.

Thanks,
NeilBrown

