Return-Path: <linux-erofs+bounces-3581-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id liZvFv28K2pCEAQAu9opvQ
	(envelope-from <linux-erofs+bounces-3581-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 10:02:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1148677973
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 10:01:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=MjstcFXd;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3581-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3581-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcBn12pcbz2ykX;
	Fri, 12 Jun 2026 18:01:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781251317;
	cv=none; b=HebPTpd4Tw4F3AuipYf2F0mTsvHmt3GffOTIJwDgTbqgoUfGugcQnXcWd2AIXeeZ78CJdbAWCpmnsIHxWzMnv10+POCv5tORJkVTXjqXOR4CpDO6jZ3qGNO2if+EuL6tkyL3DmWzU6RfVqdqpjdnPIA58MuTx3Gebe3YRjIYCTfCp+Miwc0bJO36D0I9OzMJrfVveHXHlT8qo8UIvLy9if7h/hLAHpK+RCEVPQyhxlo8eghLuicaPLemIXr99fFjsDiz3d0e9MTbK7ubPa+r59wdj6XUeI1AN67qGprxoMrWGwDOOkGohCENjdAO1o18qR6Lau9qj5x+JTDQSNcRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781251317; c=relaxed/relaxed;
	bh=7jD/MDoTJEp59NIG3rOHJIeJwr7qwvbaSlX946skE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7ddgQF2rBlCRjjmvzyr6muFnkb9gRcHkp66gFT+p21yOQu9Wbrz9IRdfcG7UKsnSbBS8dTrzjzEN+IZ+ccn4dJFiCfDCiA2iU49Q7TewmBrDQjPMF4pQFWq6KOvlETvB+UdpWht0Z6hZUndTY7cU5X+eR2L12vMdqY5bFmQhp73kw6FLP4LKKqNnRGPghx4WNU5ErShbd60qBLnXQr8ykyMr+03mIyUWvDMx2SBMZSJ9/y3QMWfNIveq9FwN4d69Kw0u+14blzEqbzWho8y9/a/9WbIFUaVcmIuzJ7/U9NfclQ24QB6uryQ7CamZ5NTBNtsrVYtZwh4bb2t7NKgPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MjstcFXd; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b893ed6302a0b05caa02+8328+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcBn01Hlcz2ySC
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 18:01:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7jD/MDoTJEp59NIG3rOHJIeJwr7qwvbaSlX946skE5M=; b=MjstcFXdao1aRwyyZFKF/fflDR
	lS8zRrZghT1BIJVSgucqKLuxpgXsG51cbowL7H/i5TPiMX+lS24R8Hhv4bLFZRyH4D5UHo/oqHFnL
	9rHXGaFZ3mNjHKBJN0YUHK5NpAho622YfZCAKT22BxYNNsUjbNuOYOk+n0j2riY6HIJ6QKQREcvDx
	2bLjMEDy80oALtrFdQ5cbb8mSCd7wzNOi4LUgNKb5nLU0UTY3GW9iHH5nt7P+pbfQPN52dc9OKRl1
	pvJmARgZmdMVlnKnNYOnRQzsrNyRb1Ntr+IJ0VoLmjzTm3SORmeEyfibamTf9JZi5CWdNAauoBU3/
	+zbe4eoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXwps-0000000AXKq-0u6x;
	Fri, 12 Jun 2026 08:01:52 +0000
Date: Fri, 12 Jun 2026 01:01:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, yekelu1@huawei.com,
	jingrui@huawei.com, zhukeqian1@huawei.com,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
Message-ID: <aiu88BAe1EqxpeOB@infradead.org>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
 <62f6e9bc-cfb3-441c-a3b7-301b8649f0ae@linux.alibaba.com>
 <aiuw0QvFIhEWUPG-@infradead.org>
 <04d8ea84-1955-4f1e-b5f2-f142fa1971ba@linux.alibaba.com>
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
In-Reply-To: <04d8ea84-1955-4f1e-b5f2-f142fa1971ba@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,huawei.com,lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3581-lists,linux-erofs=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[lists.ozlabs.org:query timed out,infradead.org:query timed out];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@infradead.org,m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[infradead.org:query timed out,lists.ozlabs.org:query timed out];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RBL_SEM_IPV6_FAIL(0.00)[2404:9400:21b9:f100::1:query timed out];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1148677973

On Fri, Jun 12, 2026 at 03:19:30PM +0800, Gao Xiang wrote:
> 
> 
> On 2026/6/12 15:10, Christoph Hellwig wrote:
> > On Fri, Jun 12, 2026 at 02:54:47PM +0800, Gao Xiang wrote:
> > > hmm, currently erofs could return block-sized iomap (if the chunk
> > > size is 4k) even it can be merged with the following chunks.
> > > 
> > > Previously it was fairly good since consecutive chunks will be
> > > added to the current bio if possible, but after this patch,
> > > there will be a lot of 4k bios.
> > > 
> > > But if iomap goes into this way, I could make iomap_begin maps
> > > more chunks in one shot, but that needs more changes in erofs,
> > > it's fine anyway.
> > > 
> > > ... I was thinking the following diff (space-damaged):
> > 
> > That should work too for your case.  But we definitively have various
> > cases where merging over iomaps is a bad idea.  You'll also end up with
> > other efficiency gains by merging consecutive entries, especially for
> > direct I/O and when using large folios.
> 
> Yes, optimizing erofs chunk mapping would be more
> efficient, will work out one soon, but Yifan can test
> your patch in parallel.
> 
> Also, if "iomap: submit read bio after each extent" is
> applied, I guess some merging condition in
> iomap_bio_read_folio_range() can be removed since they
> won't be reached in any case. (deadcode)

I guess we can't hit the sector check anymore indeed, assuming
we never get non-contiguos readeahead requests, which I think is
true.


