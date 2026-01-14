Return-Path: <linux-erofs+bounces-1872-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB602D1FC87
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 16:34:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drqtP3BwPz2xT6;
	Thu, 15 Jan 2026 02:34:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404893;
	cv=none; b=CfzAyjRTNrI/sZpyC6kx5nMp4JMvADburUDrzfc6CmWnX5XImOkvqvFY25CMwObcfs6WF6nlM4Hgmpf+lP3yrandFZUoXFjFs8PmY/d9fxE87QGhl3PIAtMFrQ6hZEfDB0xzQQOCQpUYyfNY8yZ836xxlCmDo4A21s17rmEbrE0RkU5Qv/0ivpNZ4STFLtcxZURjd+HtFbwxYergeMvekL0QNny+hvAIU/xnAioIwLKRElUVsZ7VVLU6F7gh+6nqctQv6uQk6gUgPxIM2U1JOdb2cCQXaxECLTm9+TtbG45h2btNg6O6WmBaW8RvwKs92SSJL+DzhKcdrfECP09mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404893; c=relaxed/relaxed;
	bh=KmCWD7zuCaDnbWxTsjL5NaR8FbY5EEfKOEA+zWNmNnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQIFN6Gy7s4UlpnUtNHR1tl6EcH+mfaXhFokCwHmejxgFj0/RYOba61tX5Ia0yV2sj40ECGQc+YUZZg2JR6Tbafhg6uJ5I+i3oMtQ/QPIZPq34/moTWpSVrNtoC/8dMS3yeDB0C4TMJm5MHlj261LiPSlzN0FQZR4lTd2VNU0JZLwJRILkwzG0F3hVli994+jd/lUpGadbnVKPyOPrW/aoUuAOMZLGHWf7Y3NT8SMzcpSVN4UauYqyLrlvQKV8UlAliB1WIjYKB5kAIHDK5uE6FZNC8iBIV2Eda6g5DuyDZ2ueoBo6cL0+RSUY8j/7tAdLXmhWez0Qmja3+EUAarGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=apNLZz+C; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=apNLZz+C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 858 seconds by postgrey-1.37 at boromir; Thu, 15 Jan 2026 02:34:52 AEDT
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqtN6Zvcz2xNg
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 02:34:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33E18404CF;
	Wed, 14 Jan 2026 15:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACA8C4CEF7;
	Wed, 14 Jan 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404891;
	bh=GzVNkZ88Usl4TdMcpitFJ5xD9XIT23/DCN8JtVv7QNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apNLZz+Ce+A0ADkFZI7PQtbs3I3O1p3Aon0TqQjQxW1790iTVIAYhTVnFv6n7MA+5
	 g10k7xBk/7AWgRiVNV41oDU+X06wB5uSjqF272u1e5nyfgv2Ovq2OG/JhMrSZJ37gq
	 FQAxaRY4JvRAx8gfGJ9VvVnnVA6yc9KQnIsLStCrEsscZq5kNxnoz6fFkBeaBELDx+
	 unzGJqjEMHBm3ytUHAwrXSc5jUsIDAjfq5c8Dm1W8siLaY5HogBD6qXPgHalXlWAY7
	 F2WBRz7HNb8XaUTN0Lr9qBvPijkLqskR5aO9OSeBZBA3ITYMf+dxyo/tbKqtISm4X/
	 zkdGN3mhurLNw==
Date: Wed, 14 Jan 2026 16:34:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
Message-ID: <20260114-komma-begeistern-20adeb35fdb8@brauner>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260112-begreifbar-hasten-da396ac2759b@brauner>
 <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
 <0f33bd17-7a03-4c06-a492-e514935faed6@linux.alibaba.com>
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
In-Reply-To: <0f33bd17-7a03-4c06-a492-e514935faed6@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jan 14, 2026 at 06:28:34PM +0800, Gao Xiang wrote:
> Hi Christian,
> 
> On 2026/1/12 22:40, Gao Xiang wrote:
> > Hi Christian,
> > 
> > On 2026/1/12 17:14, Christian Brauner wrote:
> > > On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
> > > > Enabling page cahe sharing in container scenarios has become increasingly
> > > > crucial, as it can significantly reduce memory usage. In previous efforts,
> > > > Hongzhen has done substantial work to push this feature into the EROFS
> > > > mainline. Due to other commitments, he hasn't been able to continue his
> > > > work recently, and I'm very pleased to build upon his work and continue
> > > > to refine this implementation.
> > > 
> > > I can't vouch for implementation details but I like the idea so +1 from me.
> > 
> > Thanks, I think it should be fine.
> > Let me finalize the review this week.
> 
> I wonder if it's possible that you could merge v14
> PATCH 1 and 2 now to the vfs-iomap branch (both
> patches are reviewed or acked):
> https://lore.kernel.org/linux-fsdevel/20260109102856.598531-2-lihongbo22@huawei.com
> https://lore.kernel.org/linux-fsdevel/20260109102856.598531-3-lihongbo22@huawei.com
> 
> since these two patches are almost independent to the
> main feature and can be merged independently as I said
> in the previous cycle.
> 
> Merging those patches into a vfs branch also avoids
> other iomap conflicts.

Done.

> 
> For the other patches (since PATCH 3), how about going
> through erofs tree (I will merge your iomap branch),

Fine.

> since it seems at least it will cause several conflicts
> with my other ongoing work, does it sound good to you?

All good.

