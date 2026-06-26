Return-Path: <linux-erofs+bounces-3766-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTJOBV0APmpC+QgAu9opvQ
	(envelope-from <linux-erofs+bounces-3766-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 06:30:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF56CA1C7
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 06:30:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3766-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3766-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmjQG2XTKz2yYd;
	Fri, 26 Jun 2026 14:30:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782448214;
	cv=none; b=MSGQOglegkENp/2e1NrRKbRBqnEa5+1M73CP2QSPRmHJMIby65G2SIRBey3bXfheA7ENAyu/rk9/okF/ELUlpsYvCYavqMLLhbNTCyu5YrrER0FQfnPLRzN/ZBCzteQsWJ3hn2q0MyQmeoJVVlo6IKhZp5dHD/UnEg7oaKCJABD6rslIE8yagUJukMIegFgwD/b9xKmfJcqry8T2R11ZiD0sMOaZuHQUh6ri4kVLCAiB4fc253rYXD8wqY23G7YoRRAEk0jw8T5glGhPCvRcgniYzD1HXHPDZA27QLoIu40pc81vmNXKemIQvuMuIclXs+Nk8W3Wpk6YDiJ3txzO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782448214; c=relaxed/relaxed;
	bh=2uvhb3zm4kPVUkIzWb5T3Cc199RzjAm0jrmzp6qhilg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/rBw5JiciFMuJhWUtJQ90g5oMCZRly/AnJqhSKEx6XvtUOpRP0MipwY9OGEo0sYKjUmBYgS24XyNXUmxxZ1pHCQllxPrYekYNoUIX7JkYRKvC38QdZl3XTc+lOK3qVf5EzDR2oq4i3cRCKdoxwab7sA4NhRJTIX10ZviOqCRJWq0yxEYBGC3koJ3Ga5pDb0n582uLyuH+bbRQzGRMXoniXVX5d1VWJFhK3rQSfU06bFxfVQuhaO6kNsll5USYjPRggt8SpyezBFG/yBLmjfpskhHRqrMWvwGowfF6SjGUAs4gP+odvzgoxQcAdcslBYSlzzfuh0GJ59nkJtnAWBLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmjQF1179z2yVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 14:30:11 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0259B68BEB; Fri, 26 Jun 2026 06:30:03 +0200 (CEST)
Date: Fri, 26 Jun 2026 06:30:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Kelu Ye <yekelu1@huawei.com>, Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: consolidate bio submission
Message-ID: <20260626043003.GA8078@lst.de>
References: <20260625120803.2462291-1-hch@lst.de> <20260625120803.2462291-2-hch@lst.de> <20260625172740.GD6078@frogsfrogsfrogs>
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
In-Reply-To: <20260625172740.GD6078@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3766-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12AF56CA1C7

On Thu, Jun 25, 2026 at 10:27:40AM -0700, Darrick J. Wong wrote:
> >  
> > +	bio->bi_end_io = end_io;
> >  	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
> >  		fs_bio_integrity_alloc(bio);
> 
> Ah, so the bug here is that all the pagecache readers should have been
> allocating integrity information for the bio before submitting it?

Well, all the ones that set IOMAP_F_INTEGRITY, which really is just
XFS at the momen.  And because if the iomap refactoring for fuse XFS
is now using it's own submit callback and does not get it..

> And
> because it doesn't, iomap_finish_ioend won't do the read verification?

Yeah.

> So the block layer does it for us, and that's why we don't use the ioend
> chaining?  And (I guess) the future userspace interface won't have any
> means to get at the integrity data?

Yeah.


