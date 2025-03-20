Return-Path: <linux-erofs+bounces-98-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10748A69F54
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Mar 2025 06:34:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJDly5m0Tz2yyT;
	Thu, 20 Mar 2025 16:34:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742448862;
	cv=none; b=VICRo+uxzkB8R3ZZtCrQa4JT27Sv1wm/UwKz0LNprvDRLczpAVcAfrTANZU7eFwAe517rfAxPIrzNQZdnw42g4bvL5nyRgGeYj1+Vtdg2XBGf7Pp6P/jA1Y9TwWxradSTg3O6kz0lYzPNwsfRSIzXsMrf7cku1po7WMh60sc2y2QcK8BN5/me3y6JVi9nCdLfl6RUwtlqDrSW6zunn/6YLa6EI7SZM15M7sSbFkFAbIMdMYCqdKwdssindwIC8kaggURC3R6mXOl3Ogx+gzUrwm/+JXAMC0sH7FgyzKPUTmIGcwm9tRbnUtP3o0sFKd0h2BlsWMKK2tF6eGc7WcGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742448862; c=relaxed/relaxed;
	bh=oc8Wf/lcpeff5Lc3gVl51LO0huNvJu875G6QXyEaWow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6nQk3pys81l0ikafpNfICproU20lAto1GBtc+rA0feWSLbpxixWXdTuu7H3bGngnk2sGqbBGDkFUwBFya178Q44Uh2Ex22/QFWMbUhsFey86x0vp3oAdR2AuAYGkevZh4IwESXprDqOJAxO1Ij/CJt0/N2YxDIOLiHLsPEWBZqOHH4UFQb0YTNsZEGBE6lMxpaLY5lZZKbmS7dwaVjR6PVPCoUVl6ZQkVkIV3TgLrGHDjanQu08rktbt8adRJKTHGk0EoFFD4Zwr689W+sqpe3+eSIC4j056qU98/IpimVP6RpHfMgt5kXxqW0H3rYQpP/phMsVcJLJikb6FFHyqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJDly0Z30z2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Mar 2025 16:34:22 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76D7968AA6; Thu, 20 Mar 2025 06:34:16 +0100 (CET)
Date: Thu, 20 Mar 2025 06:34:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <20250320053416.GA12664@lst.de>
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de> <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45> <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com> <20250319062923.GA23686@lst.de> <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Mar 19, 2025 at 01:04:14PM +0100, Mateusz Guzik wrote:
> The change is cosmetic and has an unintended impact on code gen, which
> imo already puts a question mark on it.
> 
> Neither the change itself nor the resulting impact are of note and in
> that case I would err on just not including it for the time being, but
> that's just my $0.03.

Im not sure how you came up with that opinion but as you might have
guessed I don't agree at all.  Having the proper types is more than
just cosmetic, on the other hand the code generation change you
see can easily be argued as cosmetic.  You've also completely ignored
the request to show any indication that it actually matters the
slightest.


