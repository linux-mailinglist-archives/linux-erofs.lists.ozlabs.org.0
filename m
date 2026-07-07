Return-Path: <linux-erofs+bounces-3853-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6esfLbHdTGq+rAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3853-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Jul 2026 13:06:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045871AC98
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Jul 2026 13:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gyMp04QI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3853-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3853-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvdhF56bGz2xKh;
	Tue, 07 Jul 2026 21:06:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783422381;
	cv=none; b=HitYjPG5EYguddQRMm0Otpo8IfvYHf02860RqS1zojigtSCAw8HE8sVBfbUUM0aBLWvWH+cShFFUk1kGXPfoHrh5/IyTpqd6aJP6AKwlmI/IiG1bHWMB3IX3UdTakCxQFV1pBAc+dYrUMychCFUKo4+CThNtpr3DoRhdW5cUPdrjF0y765lUC747z3+tcnD7yASCWAZyvSYoB0TDOY+vAddxmGLx1NejX/BbORlcFieHw6/Hcru44uc4pE2NmzWvapr9/TBhEvILDjGPgwnrQRoGzttL0HMPQ19zKlLqizbbqfX8m3VvcEvi6vzQcC53K1DrvGVMSSSm+kJzOB7NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783422381; c=relaxed/relaxed;
	bh=JKxHYicutn9lHYVVegEG1F9eKWFhJlIjTLa68GjK0l8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ECy+5xWEgkGe79ki1ZyazvMWJxE7ArqwZClqngHeIO+4pG2ujn/q8WDovz1UspEtAScCzwbAGRO6Tfm7T2YvTtR5pScnPvUbETiQNCYJ2knzkHsereQWbaJFj5LAImbZYv0AwXr6xAfRH3/8FFy9AJ4aMdswPd9MgkeDeKObNdh6kVgRQrH2dzc8qEJSiFspegZ+2bS1c3PrAEANaSZuy+mDYjCjstAn7A+Jl1/wQbLlAvOsE4u0cghXQdSsFYrqbXurqCoItIMTb0FKq6hrJDujk6tyKYv/02i/7gFIM8F7waM1dwoS5nKyiLWn2kYxKf7WFLVSYEPatd0v7eLUtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyMp04QI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvdhD5MPlz2xC3
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Jul 2026 21:06:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9A78401CA;
	Tue,  7 Jul 2026 11:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ACA1F000E9;
	Tue,  7 Jul 2026 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422377;
	bh=JKxHYicutn9lHYVVegEG1F9eKWFhJlIjTLa68GjK0l8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=gyMp04QITLFRFc5jTjaImw4fF6NT0FHjfTsZpl3YhjEEX+9DzUkH/tskh23b9e6WW
	 LouAB5fIU6xJ+gd/8p8XpuLtntt+xWzybr3l5cb9jM/MxrB9bAjVkdjgn9t4ac4mwF
	 Dh899/mDheHU+6MkH9kTdbEBUj1YKv6BN7KhTP3L60xhM7LUjFLB2M/IpF13ZBGXtN
	 V8NpCTqN5KKS3aKBB+Wi/QEVQzqQCmLOb640Tyk92cE3Z26ncZmpHBdIEwH6imqUAu
	 VbHMZVrr86CCcfS0u50bf2IEcLV9W4elOrfc/ECmdvpr5JjSP5VJvAmYh7N/agUuUU
	 eiwfs3SF7GxkA==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] iomap: consolidate bio submission
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
 Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sungjong Seo <sj1557.seo@samsung.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260702102705.GB6252@lst.de>
References: <20260629121750.3392300-2-hch@lst.de>
 <20260701-davon-kniegelenk-gedehnt-96476b242a09@brauner>
 <20260702102705.GB6252@lst.de>
Date: Tue, 07 Jul 2026 13:06:12 +0200
Message-Id: <20260707-geleast-bemerken-zollen-dbee3cf1939a@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5oQBslVXVyGoBt+yGH7KL6hP/GNNUnSmmKKmAhRb7hc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53F166Ypbtvjzjw9+WiVKHlG+m/XX6FyTmpj5sce8O
 nnTXzPzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdiojw6wZ5x8nJ71QqAj8
 9VjoeHBFpkEC35eNX9f8zVJvWLzkyGmGf/ZC2Sk2qmXmf45YsK/f37Z5xoTH/OtXd3wKqdp7/+l
 cXw4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.80 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
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
	TAGGED_FROM(0.00)[bounces-3853-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2045871AC98

On 2026-07-02 12:27 +0200, Christoph Hellwig wrote:
> On Wed, Jul 01, 2026 at 03:27:40PM +0200, Christian Brauner wrote:
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Hmm, both this mail and the merge commit in git reference the first
> commit instead of the cower letter.  Is there an issue with your
> automation that made it miss the cover letter?

Yes, your series aren't picked up by b4 correctly - I always take care
that your cover letter is actually used but the tooling trips over it.

I thought about telling you but then I thought it might be easier to
first try and fix the tooling. So a week ago or so I sent:

https://lore.kernel.org/tools/20260701-work-b4-naked-cover-letter-v1-0-f651c2ffb63b@kernel.org

The issue basically is that b4 expects 0/N for the cover letter whereas
you send "naked" cover letters.

Konstantin is on vacation though.


