Return-Path: <linux-erofs+bounces-51-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBDDA5D2C5
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Mar 2025 23:55:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZC8HT1tTVz3bpx;
	Wed, 12 Mar 2025 09:55:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741733733;
	cv=none; b=e1O74j1X1aNLv28wktpXaZhbzXsu3rAeP9/AH6ZhjuqQo+x5vN9k0UsrInJ4FoUgTvkZg5niXjSeO3uj/QBT0D0EtTcL/EC3SVs84jBK2ZRQ0ridwMxqdJTc5nVZIOXvSHFw8YmMWDE6frxYE1VUGwTdIbvJSN5d8bHIALyLZ+I1Qa7WCahX1o9yjdF4PPuAFaVGMFJetMezxh7nrR8PzOeV9jqL7IjfeIGWXfZO4oZqSwe2gN6ELgFdTzEK5oA3e5TB93D3fWPGKtPVP+3/uXzsINOsHy4Gn5wkwYheELyIuklJa3KDaEJgrudHwtHw5u/4rivWYYZBjMjebmbJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741733733; c=relaxed/relaxed;
	bh=ab13EvIK2DPk+TBDxxWWO5yYyOOgqUiN0tHfZ4wqv0g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XdT8sp9pshKIbozV4Zwq3T9j4bZla9E3qn1r20cSzZRywsKmS5hn5gvEGYE+BpYr1gRCUwKgFHV8wX71bH+kkaW27XOQ/NhmZGvNzsSFChuzz9KaG7fwYCIz7TWK23ykCC5A/AwWWQytqiWT0TjdGIucw7uQiWvZguVpgIXVLoEDgWcKh1ixMJouyqsdZ+e3rs04P5fH1X94nqKcLZGGUGuNP6B3l/mdMFi9Mrq5RwjrGg/DyvgeereLgPwHiuH/adOdMhN2HSvGfkzL3VjDzm93dHytLVGQs5CKDpe1z4603iVYnHXgcjvbmH0a/2+m6VHb9hAM+evSZKZUjOOCFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jYtoE6uI; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jR9e7HS/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jYtoE6uI; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jR9e7HS/; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jYtoE6uI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jR9e7HS/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jYtoE6uI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jR9e7HS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=neilb@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZC8HR56gZz3bmf
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Mar 2025 09:55:31 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 225FA1F388;
	Tue, 11 Mar 2025 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741733728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab13EvIK2DPk+TBDxxWWO5yYyOOgqUiN0tHfZ4wqv0g=;
	b=jYtoE6uIP2QmHhlIevBJBy94LG/dhVBif5XAHK02z7vMO1n1PR7yXi+ccMMo1XZ3ZPUQ0G
	hMSYEN7fZzB1vqcZbeZdivDAZmrB06jnJFlEM9HeDbQYBny9TG1I5PfYZWQvNUAjeUmjhi
	coztQJYmMIrhjK+Edi1yDiuULs3R618=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741733728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab13EvIK2DPk+TBDxxWWO5yYyOOgqUiN0tHfZ4wqv0g=;
	b=jR9e7HS/sosD5H1RhhkjMoj2AuTPAQpY8bmxSIybhptRMzYQt3Fpxhu8Q9h1mc63D+eBky
	sIuBv7xJik9Rq6DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jYtoE6uI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="jR9e7HS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741733728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab13EvIK2DPk+TBDxxWWO5yYyOOgqUiN0tHfZ4wqv0g=;
	b=jYtoE6uIP2QmHhlIevBJBy94LG/dhVBif5XAHK02z7vMO1n1PR7yXi+ccMMo1XZ3ZPUQ0G
	hMSYEN7fZzB1vqcZbeZdivDAZmrB06jnJFlEM9HeDbQYBny9TG1I5PfYZWQvNUAjeUmjhi
	coztQJYmMIrhjK+Edi1yDiuULs3R618=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741733728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab13EvIK2DPk+TBDxxWWO5yYyOOgqUiN0tHfZ4wqv0g=;
	b=jR9e7HS/sosD5H1RhhkjMoj2AuTPAQpY8bmxSIybhptRMzYQt3Fpxhu8Q9h1mc63D+eBky
	sIuBv7xJik9Rq6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15FD9132CB;
	Tue, 11 Mar 2025 22:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADdaLlG/0GevaQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 11 Mar 2025 22:55:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>
Cc: "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Yunsheng Lin" <yunshenglin0825@gmail.com>,
 "Dave Chinner" <david@fromorbit.com>, "Yishai Hadas" <yishaih@nvidia.com>,
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
 "Mel Gorman" <mgorman@techsingularity.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
In-reply-to: <316d62c1-0e56-4b11-aacf-86235fba808d@linux.alibaba.com>
References: <>, <316d62c1-0e56-4b11-aacf-86235fba808d@linux.alibaba.com>
Date: Wed, 12 Mar 2025 09:55:10 +1100
Message-id: <174173371062.33508.12685894810362310394@noble.neil.brown.name>
X-Rspamd-Queue-Id: 225FA1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,fromorbit.com,nvidia.com,ziepe.ca,intel.com,redhat.com,fb.com,toxicpanda.com,suse.com,kernel.org,linux.alibaba.com,google.com,linux-foundation.org,linaro.org,davemloft.net,oracle.com,talpey.com,techsingularity.net,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RLodizb9et8yqpuyyezexhwnjp)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Mon, 10 Mar 2025, Gao Xiang wrote:
> 
>   - Your new api covers narrow cases compared to the existing
>     api, although all in-tree callers may be converted
>     properly, but it increases mental burden of all users.
>     And maybe complicate future potential users again which
>     really have to "check NULL elements in the middle of page
>     bulk allocating" again.

I think that the current API adds a mental burden for most users.  For
most users, their code would be much cleaner if the interface accepted
an uninitialised array with length, and were told how many pages had
been stored in that array.

A (very) few users benefit from the complexity.  So having two
interfaces, one simple and one full-featured, makes sense.

Thanks,
NeilBrown

