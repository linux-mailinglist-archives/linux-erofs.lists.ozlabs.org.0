Return-Path: <linux-erofs+bounces-3654-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qcK1IIxpMWrrigUAu9opvQ
	(envelope-from <linux-erofs+bounces-3654-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 17:19:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC8690EB1
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 17:19:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C3KHeFMf;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3654-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3654-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfrJ63wkZz3c4M;
	Wed, 17 Jun 2026 01:19:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781623174;
	cv=none; b=AxVo8wn9iR2LN3WCQuroKeOU33N78VaA68O6xqUDKvT6FS08ylKd3Msu+yNxfBQjd7hd4xLDfj4qD+sqySCDaXBmN2uNUZALvR974CSyoRo5AsIVGLUR3N97Tf27Tb2a8Nhta/wD0hrrApGdXmrQdEIyPsHd/hnXOlGemVENccYZkS3nQvxJyTH6Cu6d0JANIorxWlPX0D8Qx73WGf2Z60gOIsMjuYkGqSBW+2WjG7zcI1OPOB45pZNG/6o2knqlzH0sSWbi65dBGAdxHJ61Z7bOq7s047MDsICZYlWszhUDRlBj6ra4BXt84BnfyAN/R2/AX+7iIY582iAvXj8AKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781623174; c=relaxed/relaxed;
	bh=juOgUzeXy3XGsInNpe15bufLEDlOx+XQzIp5A397JkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ7iW7dbqh/cbKIN8VwMfyXqWwgCU4z56ph7rQgHTDtciWte1DdJvbSwlrGpfFXgEXg4D1HatmLhJKX9BGTIfunNlnoMrKCaBEAGF2Ri8cE1H5UqP1kDZzWMkiQ8TdmBKoiTwQ8k9WEYWQ/U3h4TJhBfvUyRHllY6knpytAD5SfSyG8CMq+KCGYBrDes+7NsbT8S3eL87fPbYk6KoQ19vaZjk6FTnC1AVmomzlMb6MHCRG53tM3iTdeAzZ9h8M2ZnT7zaWIeSVPOWKsW5MmJYpC/H8q+l/pf48INl1eMfrk88T/buNvboyBd9mNzJcP8caI/Oi+JueZSjsPc3NNZ0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3KHeFMf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfrJ552LCz3c3v
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 01:19:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 113526014B;
	Tue, 16 Jun 2026 15:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A73A1F00A3E;
	Tue, 16 Jun 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623170;
	bh=juOgUzeXy3XGsInNpe15bufLEDlOx+XQzIp5A397JkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C3KHeFMfPC+yAaSzIg0d95m3I0xEpDsWlEwoaPTaoJYfJNDKmTv0cKSZzfbbqc/Wu
	 d8akawUi2BghCvAvmcEZuhA3kfz3EKR5coklh4zJ3VKagdyvPjIftRaVpdj913u1s1
	 K3nWzCRQGfqvcgJH3rQlu5kPL3I3tsC12bpvccsgaixq/ewzcDBZaNKj7UEjUIcS/V
	 0whVK+dEe/g8IyC4ymEkWjZ1nKTeBmsQ+TpuUxZ7RR5tY0sUiLwcJ2g88pAwV9kzeM
	 CI9cdL91HodKXSF6pakZ+9nvoRMoav0GjecnDRdjd31LHvVLTYwCQH0xPigTZ7hKpv
	 T5OvUAgdpT3fg==
Date: Tue, 16 Jun 2026 17:19:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC 2/8] fs: add a global device to super block hash table
Message-ID: <20260616-gepumpt-gemischt-verblassen-b4cec29c7a6e@brauner>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-2-bb0fd82f3861@kernel.org>
 <20260616123443.GA21024@lst.de>
 <20260616-fragil-duktus-nachverfolgen-60f54584c206@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616-fragil-duktus-nachverfolgen-60f54584c206@brauner>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3654-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3AC8690EB1

On Tue, Jun 16, 2026 at 04:59:53PM +0200, Christian Brauner wrote:
> On Tue, Jun 16, 2026 at 02:34:43PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 02, 2026 at 12:10:08PM +0200, Christian Brauner wrote:
> > > fs_holder_ops recovers the owning superblock from bdev->bd_holder, which
> > > forces the holder to be exactly one superblock and prevents several
> > > superblocks from sharing one block device. That's what erofs is doing.
> > > 
> > > Introduce a global dev_t-keyed rhltable mapping each block device to the
> > > superblock(s) using it. The holder argument becomes purely the block
> > > layer's exclusivity token (a superblock, or a file_system_type for
> > > shared devices) and is no longer needed by the fs specific callbacks.
> > 
> > Err, no.  block devices need to have a specific owner.  If erofs wants
> > to share a device between superblock it needs to come up with an entity
> > that owns the block devices which is not a superblock.
> 
> It already did.
> 
> > IMHO sharing devices between superblocks is a bad idea, but that ship
> > has sailed, but please keep it contained inside of erofs.
> 
> We need a simple device number to superblock mapping anyway and that can
> simply be centralized in the vfs. And it can work with anon device
> numbers and block device numbers uniformly.

Plus, after we're done we then also have a centry place where we can
intercept what devices can be mounted by a filesystem uniformly.

My first approach for this was of course to just add fs_file_open_by_*()
wrappers and move the relevant security hook into there. But while doing
this - ignoring the ton of bugs I found - I realized that having a
mapping so we can go from device number to superblock is very helpful.

We could of course keep the mapping just local to erofs but I see no
reason why the vfs cannot just provide this ability natively given that
it has all the required machinery. I'll let Jan chime in as well.

