Return-Path: <linux-erofs+bounces-3738-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fI2cBsaPOmptAAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3738-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 15:53:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B756B79E8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 15:53:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3738-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3738-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl6370VLjz2y71;
	Tue, 23 Jun 2026 23:53:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782222787;
	cv=none; b=fJqZvsj0KjbujcKW8eYI6dpP4R30dWRZ1/jCdxkiDh96onHntvdMW8gc9E2pWHSLT/SvLPm1ampK7K/Y07ZYUoCBBR8JHHuOrLLoiS1ZqWsCCFryaG3mUdBX73yDK830G8vcnvNjT4gNPITqlWePTd6xTnGaHscZkFqPvP54Ri1m0BT+ay/7HTpaVqK5dAhA+GlSJvlhFgURPVsOt7FBa4J98akB1goJjJ7LVIDzeYJ/RiMlh+2HudM0lION6qhtms3QWoQsqntfU0w4WtdkurZfuKMNBdEJDiRLL4uGOws17r7O4NyIgYaL0NAOt4v5DR9K155RtYb/xxsNXQnt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782222787; c=relaxed/relaxed;
	bh=IU35pXaCxbba6lk74nkqid4mkn3LULJzvPghf/ZGitY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks1RGR12B/FpYlzpcxpjvHKCF7//avc7WRa6LiFSeHfTQX9WYpHZRmnlOvtj8F2Ie88WANf4j2/VB0yfnEXNUR3dVeT6aYB3HIgF5v+PBQlCCTVcJFVQM/BW8HFOgp6byLE9GlQXztj/ZLnUVC2JOgn/ptb9yskaaEZxgPtPWcL0kgc1cbYAfQthc8gI5+u0EczKvxoWNbGYYES5eNhPNZZ8V/q4ztSa0RMFNBhDa+mY2PYd/z6w8lSyyf3zmVZGmgm7GbFz9OMg1kNEZjjl4gb4i6RE7WX3guONuym+NIc/4wBYcHf0A4JC+RW3cKFwOd+qVFdOxkn2x7yG9v/pgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6362kJnz2xM7
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 23:53:05 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54A3968B05; Tue, 23 Jun 2026 15:52:59 +0200 (CEST)
Date: Tue, 23 Jun 2026 15:52:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: submit read bio after each extent
Message-ID: <20260623135258.GA8720@lst.de>
References: <20260619050105.439956-1-hch@lst.de> <20260619050105.439956-2-hch@lst.de> <CAJnrk1ad7Wxr9CB4P1=VZPUS_BRmHTTmRVXVgRjM628iFCZh0w@mail.gmail.com>
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
In-Reply-To: <CAJnrk1ad7Wxr9CB4P1=VZPUS_BRmHTTmRVXVgRjM628iFCZh0w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3738-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,huawei.com,gmail.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47B756B79E8

On Mon, Jun 22, 2026 at 02:51:36PM -0700, Joanne Koong wrote:
> Does it make sense to move this line to the bio submit_read callback
> instead of unconditionally clearing it here? If we clear it here, I
> think this makes read_ctx only able to hold per-mapping state instead
> of also being able to hold persistent state across mappings. fuse
> currently uses read_ctx to hold per-request state (though this patch
> wouldn't break anything since fuse only ever returns one mapping
> covering the whole request).

I've done that for v2, also we also need a new argument to
->submit_read for that to be useful.


