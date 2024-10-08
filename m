Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE4994284
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 10:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728377193;
	bh=SsZzWNQUxssvBsScCHPgJH6ImP4FZEXYjAOzDpmlIKQ=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=V7ScL7YiF0vHai/Ibja1HCmG2R1cJwme83xiDQPH+SgxWJefj4o4ybo96rfcaVlWZ
	 6WKlFUNDBImgq3Avo5qMhou8ib8Om5PV0TgLXYR9m5JUWwIqP73xSAc7SEcuexG3ew
	 GxMvADYzbBO4YPQMnoggv3ETbpAG2uEdAvzoRnevMdfUPblp5y6WwF6YePXHl5FREb
	 fictX3X3oV7jmMhnzAUc+ecNVTQiOUmxQTGoc2+PFbk+zq/nkRypeBkFkIkcXYUyyb
	 95R8dowSb66QrjFoMM5Fzdgz3iDil+ExNtVWzUA1Y/WnJjc6Uesy0lr9HW06mUcfmK
	 pV1X7fy8xsqRg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN8kx689nz2yNf
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 19:46:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728377192;
	cv=none; b=PJ6fzeXcdg0tN9Zw5A9hdjmt6/xRCvBZSmQ2ULZYPWatkno8gwA9jiXaLw6goFHzg9g1O8veNVEvRM+U2CxiknyUxP7i1zXTKThmveW22UzsjS9pl+2ICAY30o7cVo8EQbI4nS5bc6hJ2Avgi7+68iSgYvptFA7eJBJRIuDgaz3IwUE9Sv6Nmd5dY3F4jNvsk67XAmYL4kTVbpiJ0GC5eVDxJICVIZH+gKK8rP7ETwHqv0HigpmZz8KZPkpr3/M3if6DtvAgu1/16p4p9PxupD0pt+D/jLV/r5xTBY8iS9msZIsX1BcfeUpCjPhChlQyI+0/JNp/G2udRBPXU+1qVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728377192; c=relaxed/relaxed;
	bh=SsZzWNQUxssvBsScCHPgJH6ImP4FZEXYjAOzDpmlIKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAW8Xt7E/dwwYOg4Bdpdq9KvqtK0zEColEE+ZiBWM06Uo5UuwM72YIpy4Zo2rdsVN/sE7fRPmSn8Ni1JbMVxRIAaOLMmCVSyicitcm4zqvWduwkRUyX1mVuszeKZghaL45ctTlr2SzOaDACwbk2bgGDGSxiP9dTnroeJIx2GrB90zyXygqxNxVfzOwIhpNS+n3aF6Mq6F2WQbCLNvlVcJW1Q3ulZ7abY+M/def5M3XIY5F2uxFB/RPbar/Y2fiQ7xz8oOalCvph+FE3gU6g4eRMHNPX9p9qv5nPWRbc9ha0uue0TpNb6ofLnU5P0LV215oWs8jnYuZPrU4c3fg5V4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kDY9HX/c; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kDY9HX/c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN8kv5WCRz2xHb
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 19:46:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2223F5C59B9;
	Tue,  8 Oct 2024 08:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2CCC4CEC7;
	Tue,  8 Oct 2024 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728377188;
	bh=8szYLqKKyxTax3jide3X0jKr5gWhHG0hju86NR+iJ9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDY9HX/c9secNidyfMA6UUWTyk1YRhsTY4tF4/rW3Emgk4ahbRIZzmkEciBHUEUmd
	 BzCSPfSLlYo4uz0eKmmMQInE67o16lG2e8gXTZFbAXRc3WikZ4SOojcQYMlQW1akBR
	 Blk1uvZ7FmRiV1b7F/+6ZIfGqN7el/OHtwpAS5VxwSCquRP5xw20SSpbkM6JwpMAb5
	 1OF8/HiEWNu64LK0lIs56RQHkBMBjsEQjhwRVMWw4Gu0hk/uIgqJcaQ9eW1kNhgZuf
	 R70fQnWA8v2QMnYp/kKXxqf01D3EpQOu1P4JRiSOM8jlbObZsqyum/5Wd+Ezt4wzfY
	 +yOjkftl/pznQ==
Date: Tue, 8 Oct 2024 10:46:24 +0200
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
Message-ID: <20241008-blicken-ziehharmonika-de395b6dd566@brauner>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
 <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
 <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 08, 2024 at 10:13:31AM GMT, Gao Xiang wrote:
> Hi Christian,
> 
> On 2024/10/7 19:35, Christian Brauner wrote:
> > On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:
> 
> ...
> 
> > > 
> > > Hi Christian, if possible, could you give some other
> > > idea to handle this case better? Many thanks!
> 
> Thanks for the reply!
> 
> > 
> > (1) Require that the path be qualified like:
> > 
> >      fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)
> > 
> >      and match on it in either erofs_*_get_tree() or by adding a custom
> >      function for the Opt_source/"source" parameter.
> 
> IMHO, Users could create names with the prefix `file:`,
> it's somewhat strange to define a fixed prefix by the
> definition of source path fc->source.
> 
> Although there could be some escape character likewise
> way, but I'm not sure if it's worthwhile to work out
> this in kernel.
> 
> > 
> > (2) Add a erofs specific "source-file" mount option. IOW, check that
> >      either "source-file" or "source" was specified but not both. You
> >      could even set fc->source to "source-file" value and fail if
> >      fc->source is already set. You get the idea.
> 
> I once thought to add a new mount option too, yet from
> the user perpertive, I think users may not care about
> the source type of an arbitary path, and the kernel also
> can parse the type of the source path directly... so..
> 
> 
> So.. I wonder if it's possible to add a new VFS interface
> like get_tree_bdev_by_dev() for filesystems to specify a
> device number rather than hardcoded hard-coded source path
> way, e.g. I could see the potential benefits other than
> the EROFS use case:
> 
>  - Filesystems can have other ways to get a bdev-based sb
>    in addition to the current hard-coded source path way;
> 
>  - Some pseudo fs can use this way to generate a fs from a
>    bdev.
> 
>  - Just like get_tree_nodev(), it doesn't strictly tie to
>    fc->source too.
> 
> Also EROFS could lookup_bdev() (this kAPI is already
> exported) itself to check if it uses get_tree_bdev_by_dev()
> or get_tree_nodev()... Does it sounds good?  Many thanks!

Sounds fair to me.
