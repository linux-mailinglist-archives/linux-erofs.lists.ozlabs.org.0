Return-Path: <linux-erofs+bounces-2813-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFJeI3eKuWkjJwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2813-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 18:08:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FAA2AEFFD
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 18:08:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZz1F51Z1z2yhV;
	Wed, 18 Mar 2026 04:08:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773767281;
	cv=none; b=QwtjVD2CKCw2MeQ0EtX8UR9wuA0xDjnlJbhsXOfJqrVHfFia0XUuBoNWK2oPGC2MD2b5oFYxE1Eta7WIXMGVlO4d/ZZrOUfZQw/gRs0ZNoK0PIP27uOoFVOyZ24kjWHH/xeGvn1jtup21trRwV7BsXJqSPD0SnWZGqC6rX2+meaepZPm6gHifr9HYQ7Du94BmIKwUT17q4KCYT6TaXsFyiMBtYAw0PeENN5r80zxUJ9XGa7N896oFFmgNv4JEWJh5XxBifNnjZNlfKqEff+jp2oSZtrHIlZqMc7pBcijtGZBIicsHyPTfhKlRWUXfKWvVAMRIU09KK3l69aEUWo/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773767281; c=relaxed/relaxed;
	bh=mOa0Z+FMHGlUDFKeNu1yPtuxObIBCZ/tCqFJWZwNt6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzQ9awYwNw6yj76G57udr9fn93dGLxlfAQddmo9Nk6rYCGHjFerenv8i1nLwI72jTVxm+xKVnpF3HhAfThESKryL6Nnl/Ds6hNCOAvBAh6NGEQ2vBFEU5d0P0tN8/UwSNWH4+McWQvXOTIhOdS1GRuEVT2vO5E8YCtJb45wiar0W5CxQTDgGF9dxV4FTRLrTwg5RDsQkXExkUy2XkXeVx3NB8BxwrvLeZiYQvjNhJHv3DHuG7n0dcEd9UHgKFMEfJgdhbpuJ0uBp02192Zd0bHwE39HFgnJcECkHlKpUtPnIk1SHbZx/YxhVzhNVJ/2BiTUOW23NVMqmje/j/yHwLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aCZ5WtWX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aCZ5WtWX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZz1D531zz2xb3
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 04:08:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 746FE43BF8;
	Tue, 17 Mar 2026 17:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76AFC4CEF7;
	Tue, 17 Mar 2026 17:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767278;
	bh=mOa0Z+FMHGlUDFKeNu1yPtuxObIBCZ/tCqFJWZwNt6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCZ5WtWXMY6rVqPJxf+pnsKrAi3t1rUK7yy4JZbNzeU3RpOrEGeemsIp3WK2aFIQ2
	 C3U3okaXSfpcotN41DzmSjxnkUmk56CI/9+KMWf3/cxSx7UjVpvKQxbvjkHPEE58G5
	 k5kbD9G4Ggug5anCLPJK2NmuGC5XD4fe68p924liF67kCXvEB07xR7C2mbTRWX75yq
	 FDrru/HT9Si0Xl+cX/6SnzuioL3+3sIFgse5llkl3y6Gb2hZestMMJ28shBrlR4pHx
	 Rtahk/bHXcFluvNs+gJ7/3J6rBa3xMkH51lvwdljX46EPUn1ETLMlttIEOZBtefzlB
	 nNUeRbeAbKJiw==
Date: Wed, 18 Mar 2026 01:07:53 +0800
From: Gao Xiang <xiang@kernel.org>
To: Utkal Singh <singhutkal015@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: validate h_shared_count in
 erofs_init_inode_xattrs()
Message-ID: <abmKacsG6m5oAsFm@debian>
Mail-Followup-To: Utkal Singh <singhutkal015@gmail.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	yifan.yfzhao@linux.dev, linux-kernel@vger.kernel.org
References: <20260317152439.5738-1-singhutkal015@gmail.com>
 <20260317164135.24892-1-singhutkal015@gmail.com>
 <abmF9Nn85cz35C1k@debian>
 <abmHBmJ1SjhHTuOp@debian>
 <CAGSu4WOop42Dh_7kni3uK5fsjB4zDRkqvVWyZ=+AqbXoEACCsw@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSu4WOop42Dh_7kni3uK5fsjB4zDRkqvVWyZ=+AqbXoEACCsw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2813-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 60FAA2AEFFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:29:00PM +0530, Utkal Singh wrote:
> >
> > Hi Gao,
> >
> > Sorry about this. The mismatch between the commit message and the code
> > slipped through when I revised the patch — I updated the implementation to
> > use sizeof(__le32) but forgot to update the commit message to match. The
> > changelog was also wrong (v2 mislabeled as "initial").

Sorry, honestly I'm skeptical about it, because your v2 already uses
__le32:
https://lore.kernel.org/r/20260317152439.5738-1-singhutkal015@gmail.com

And I think your v2 is almost fine, I will revise a bit manually.

> >
> > I wrote this myself, just didn't review carefully enough before resending.
> > I'll be more thorough going forward.
> >
> > Will send a clean v4 shortly.

Please don't resend anymore, it seems the mailing list is flooded
with your patches, and most versions are meaningless.

Thanks,
Gao Xiang

> >
> > Thanks, Utkal
> >

