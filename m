Return-Path: <linux-erofs+bounces-197-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26038A87271
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Apr 2025 18:02:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZbFYH5dB2z2yMF;
	Mon, 14 Apr 2025 02:02:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744560131;
	cv=none; b=iFwJ43FXpaL597QT2s5ZWeFmqLXRyfsqUSYhkMjTEXHGZnXV163FMScF+gset4z0xaYjMbRTW6UPitawy+mQcGSWaHrM5S3aObit2UOCkeAnvwBCch8bF9w99U9OPz9p4AwYg4ru1Px98tepxTQSPYjaMIsQEmvoioaD/4x3BLpKVPj0bloxHvT23qORvvSUnGy0ck/FLVxVJVDuZn7lOX7qakrIZ3A5MSv1RYAgq3IzyPftQ7QcU9IKRX3yTS/jda8JL9GdCDgDimyFKDdeqn2SodOtBUjqvpBRtQTuWCLr01ip7UfvyEOP+liwiEUJMkf5UW87FF2KkXkQ+plL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744560131; c=relaxed/relaxed;
	bh=s7oyzo8Co3rrzHGr93oSnU01FKR21J+dRyc5rMv51B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co8lN0tdTjdieuzjcYG0OxSkPPcdb7l/o9csyfx5l31/8JN3ndOC5Q5OnxUJaxvMVDTuHCA7bp3A7EHpTyjFGoTNLMkmYqN/vNlaArvW9qUJ7EcxKnwpcw62C1OI5QBScOkKs1YLfMlnJzppkYOAGt/Ne6wZod1XY2qSCsJLo7l6t6XrQvzh38oKPvgI04W0vkgDJ+y8/4vYuNZDW89bV9+erQWuXpub9rKNJzR9DDArjFsCuSfYwHUIbDrBaEMAl64uzOI9/AzTzih2rL4FjhfNohg+yV9mEFIauIAoFOSvF4mXRXZdUjXitsjk37pibzCon+MZsTFCMP1haoCcJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZfAjKNan; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZfAjKNan;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZbFYH04h7z2y34
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Apr 2025 02:02:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 858945C4924;
	Sun, 13 Apr 2025 15:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E212C4CEDD;
	Sun, 13 Apr 2025 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744560128;
	bh=2NaVP5B5uP0EAUwCKZ0jYYq2HWAKil1PegTTkj/+Hlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfAjKNanYVTorjzPc387K+BEqBIDf4jj4UKI4g25nEd8mZetP9Z0j9ecYeAVa1YFq
	 yxSTUug3pTqAOB365U41+Vvc+IktHIRLzlERi6qDSz79bUkaG5Au2G6N2ZUOiyuFaM
	 3oMfYAjYw8PKhxbV3mrZSw8qnpi44V/Pex55ZljClq7WmixOmDGB3QE9/v67F8seal
	 CRJ8scckKDe8Gr4Kw6F8C/Xv0x2Za1YWc/E+ayEfwygyfdl1jix4ZDgvE/kU43MZxy
	 AHZXaEdohwwKNbSOczVCBjCcaUrW0iZVKamneKK/bIdpsSbkeN1S3J0j6LXYwAbXmr
	 rFhQJOUl8tT9w==
Date: Mon, 14 Apr 2025 00:01:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Bingwu Zhang <xtex@envs.net>
Cc: Gao Xiang <xiang@kernel.org>, Bingwu Zhang <xtex@aosc.io>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs-utils: add contrib/stress to .gitignore
Message-ID: <Z/vf90eBBLJ9zxH9@debian>
Mail-Followup-To: Bingwu Zhang <xtex@envs.net>,
	Gao Xiang <xiang@kernel.org>, Bingwu Zhang <xtex@aosc.io>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250412140940.88303-1-xtex@envs.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250412140940.88303-1-xtex@envs.net>
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, Apr 12, 2025 at 10:09:38PM +0800, Bingwu Zhang wrote:
> From: Bingwu Zhang <xtex@aosc.io>
> 
> Signed-off-by: Bingwu Zhang <xtex@aosc.io>

Thanks, applied.

Thanks,
Gao Xiang

