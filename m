Return-Path: <linux-erofs+bounces-3769-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s8fONVEZPmpU/wgAu9opvQ
	(envelope-from <linux-erofs+bounces-3769-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 08:16:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE06CA984
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 08:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3769-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3769-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmln97441z2yYf;
	Fri, 26 Jun 2026 16:16:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782454605;
	cv=none; b=EgWyslxwNbegGJzF3Qp3dQQQZTvMtDOnHtqVWst+h9wTEZEfMx//Bry1CJY4cRCaWqi1JyZ2DkgYQNxnNs2xraxFjDyeCmrydfYTY6W0il2TlXLYFHbvthMPoJjFCNDwJOnwdQeAcaTfhRCuuWlgbcHhh4XqzL9hz4xLbX461yK2L+Sd7D33NGLCB4jF6+HiE9QBwIYHskVlSPUftPjyVoNqGkBWcWauvXab90/+9CcXGOU0LUjX99mVLqC9FkoTmTv/QuHa1wcd6U8JeR1cBEd2f9mVZQZebBarsooaLFsGbCWTLBaSImPqVnODVDpyEjXqlx33hci59qKrXt8D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782454605; c=relaxed/relaxed;
	bh=DnWW2B02tJo8s3QUwD8/aXFmynbEd9S+n8wSCnsIiSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLnEFghFLHALohT11YSjRcsTKxBJtyuo2s8RHZRvtu3uoaPIeZthdelLuM+DzbH/pFobZDhLn4D0uj4fhrA8wdlERGjXAQ1jy8iDa6U5jh9ehQt7c+cD4B1noK5IojKALR3ATtvyupUvn38W75o+G0Ggpi4b3ESQqeCJaDUvqtWhaSufUeK+gF4gVu1MLuYk1BLUqKtaBRTkmGkKcv0YV2rRMXiMc51dA+qsPNtrysAEpW3n0YvWw7M0Gm1LXjNnju748her66dX6xN0ZneY1TX2WalxSa+s4nE2jAD+lJDavgc8EHzFJOvH2KrUMBg20evIU2G52VHsCiat6eU29A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmln76zr4z2yYd
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 16:16:43 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0352068B05; Fri, 26 Jun 2026 08:16:37 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:16:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Kelu Ye <yekelu1@huawei.com>, Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
Message-ID: <20260626061637.GA10337@lst.de>
References: <20260625120803.2462291-1-hch@lst.de> <20260625120803.2462291-3-hch@lst.de> <20260625174758.GE6078@frogsfrogsfrogs> <CAJnrk1YFeirQ4g7qcVsda-8qPLeAtoiyW6ZBuJb2qDsGpxi-tg@mail.gmail.com> <20260626043319.GC8078@lst.de>
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
In-Reply-To: <20260626043319.GC8078@lst.de>
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
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:djwong@kernel.org,m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3769-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FAE06CA984

On Fri, Jun 26, 2026 at 06:33:19AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 25, 2026 at 11:32:40AM -0700, Joanne Koong wrote:
> > Yes, that works. I think that's a good idea. fuse only needs
> > submit_read logic for readahead. The change would just be:
> 
> A nice, I'll fold that in.

Btw, can I get a signoff from you for this?  It looks like splitting
this into a separate patch actually works better.  If you have a
preferred commit log I'd take that as well instead of mine.

This is what I'm currently testing:

https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/iomap-read-submit-bio

