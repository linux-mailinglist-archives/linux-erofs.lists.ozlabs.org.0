Return-Path: <linux-erofs+bounces-257-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C3AA00F9
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 05:54:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmmfj0jJlz301N;
	Tue, 29 Apr 2025 13:54:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745898893;
	cv=none; b=bBrOnPbiWc6XxOqO4HSQC2mEybFb38+IrNcaWrRA1tY/SfC/88k4VmBBrxtSLUGhILyU2UcaAsj5Lr8MNDfWJc2w+2fx1utTWdIHXyxz+HLFk7icotQ6rnbjgIAR+buLskf0p+oAjbArczN22WEyCaIYHZCAmzK5k53Cqijc73pTZJ3Z8a8pCqvTm4UMkVIXLADSozfhOtQNU74RBLeNymSQKWOgZ+byP4yezxbarROYEAY8refRomspfvRrXokMLCnR5WVb2brJlvNEqVB3oRB0C264fCZS4W5SkI8ic1Tr9GSLO3wNPsz//onm12JF7c5loaHMI9DO8xJbeufbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745898893; c=relaxed/relaxed;
	bh=iqrIKD9kA4ZXT1E9wW/Gn/XmE/z9tq/e3LaauUP5a7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY+rNxAHtu3joXTMnlpodPjyZaQ7JY9Co/oZX6jUCgqUI3NMr9WrtXtQrizflmChkxKjAndtWXEGwj2L/QIa4D7I5i+P/i1aRmUW2YH6MY8lA4oQc3BR2CpKGnp/U5Ddw1tuGb7UxDOmgrKDmBY75MczivG2GU1QFT0XcFAP0s7tl51yXJfyMo+s/AZimBtd4o/NpYKtSTzbbT9blDGKDOQ2BLwkNJ9wKZ4haDBZmGdWwIxoCCnBoRiAOZ5dXmeYeWdELpkBIFj76yMt+C8zsNMUrIMa1Z/tLy/wixj6u0pq13eGh3rjMKz3a+/2F9lF4B0HKwM15Pxd/MNP/1IwUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lEepEXE7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lEepEXE7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmmfh1kXjz2yfv
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 13:54:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A1C4615EF;
	Tue, 29 Apr 2025 03:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C209C4CEE3;
	Tue, 29 Apr 2025 03:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745898887;
	bh=fsAJgwgv76GeVGb6k4x3v7pmQyLbPvQIQvSoQtnUrDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEepEXE7YR9ZcyJShRS07pd2GGAEa1uvtG9507xKF3PEWlA4ibxkBzMvLMi0Fc+oh
	 f/zjXjLcGY9f2u2gI7Y6cj6FH3b76c37Zqpt1N79f4bWapf5CMXSeqk83CZ+RLPeS0
	 W0oPwWJzGFPTLajCQ3upPu/iVakMgAwsf7VqG1dv1PhK1teBlDqiDY8dD/X1c4KDGF
	 zoeZ13xF0/AO17ApneJb6njv52N0BJk/XwA2zPcVn8zSOjZ6wiNFhLZMQEg1U09d9o
	 i1nuRmOlVojdERe8hmn/3tUflrtaMrQtwhbh5qsI0KJXLfVaDRnafpbDP3znzi8feV
	 lv9I9t1DkzUDg==
Date: Tue, 29 Apr 2025 11:54:39 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs: reject unknown option if it is not supported
Message-ID: <aBBNf1u+8yyAXrV3@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>,
	linux-erofs@lists.ozlabs.org
References: <20250428142545.484818-1-lihongbo22@huawei.com>
 <aA+bsw09PHTQWUXK@debian>
 <22e9fd7b-5e45-4f7c-b9fd-36e76118653f@huawei.com>
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
In-Reply-To: <22e9fd7b-5e45-4f7c-b9fd-36e76118653f@huawei.com>
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Apr 29, 2025 at 11:46:39AM +0800, Hongbo Li wrote:

...

> > 
> > Another thing is that I'm not sure if "user_xattr" option is really
> > needed, we might just kill this option since all recent fses don't
> > have such configuration and user_xattrs should be supported by default.
> > 
> Yeah, perhaps this option should be removed along with
> CONFIG_EROFS_FS_XATTR, as xattr can be also consider as a type of data that
> we cannot modify.

You meant remove "CONFIG_EROFS_FS_XATTR"? but some embedded
use cases don't need xattrs anyway.

I mean just kill "user_xattr" option and leave user xattrs on
all the time.

Thanks,
Gao Xiang

