Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539B98CCFB
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 08:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727849567;
	bh=+Z2VkP6oE8DsmJD/jndz9Nc4w0XyO4tXnienfEK/Lzw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=C+/R8G76fDPWraiJRkKd+bTFb0c8IKqXeqHPOVZZYtU6EQLdD5dskd3SW9fO6yO5i
	 g629tIV/08eq7GL90yKEjAdqLkfh2SIku3aBFG6X0K2hVWpmcA0cyosKIFBJOIV8Nz
	 s+HuwIQXbwckqfW0tAh5XD7/uWbeBnaPaFdkBZ7bAuGfAHL+u/I5GM99DiBcjJvnCx
	 6ajOyRqao/akcFpPoX7vsEuPOFsqVjB5hJiLOUFyjTR1Qp/G9LcXImqi60HDWC1sAt
	 RCxgiamnUEHBhr4zPeP4+GeJWYBcsfDDYkYa/TA7C5Ay4CVxmK1Iflo037+xIAT5Pn
	 IzFd7i+zN/NLQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJPcH5YCJz2yQn
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 16:12:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727849565;
	cv=none; b=AWIfxybHZx03iqWKFoYIGTsGbTacyL2H94zJQ+zpOtMSB5Y/q1Z9R5j4rznl1JEqc2nCiNmLVCRIyDn8YFeK4ZbRLaYCLbY5IqYco1aqUuUHoomRxqRU4FexGhf736+IEssElOFi2tbx8NqYL0VHbBzfeMgRxqg7yh8AhYBbW/abcTTH06QSfsS8LTZOGdlFfey4tQRnWd86RorEYi8fVg3FwCUxhR/JIkqZGfde9Qu9XWyYDatzbABpyQDVbPbwmPrxbFArWhrnMoPPIyp/TLsuljx2vsP2B0E0vzBuc/IF4+e/Gt7/TcYC9zu3NtjsLQX8224WSiYflHS1ckP4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727849565; c=relaxed/relaxed;
	bh=+Z2VkP6oE8DsmJD/jndz9Nc4w0XyO4tXnienfEK/Lzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3RQWRDGO7vGHJCYwuYGqsB+qCHppqRIkizhF3ACbF+o16e079RVLZOMob4hmHDfrUqT3kCdLjN+VyBG7g4/t7bYMnDq4NyZCWv2gBsXObIo8RHX6s3aLXYr2EV39YAZLntnr6hGbUZa7W/7hJSdGQNO6tuA6YmFRl4ijBdK4i+hVRGsylZNnp/laUGcutiMdifD0d8VFv+o/AyzIUGR4zrZdHQzrAuMmjrRL5ncu1Wl62T1qUZzm8EwwsPxN5HiWXsum4dU1NXdlLRsoPxcd3Y0C9oVkIHyzy67gRZUjGYm0Bb8NpQIKpRvD17tKmoLqHCgVZB4GeYiZepsQbX7sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I4wFLKM5; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I4wFLKM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJPcF3d0mz2xyB
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Oct 2024 16:12:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 80D575C4D8E;
	Wed,  2 Oct 2024 06:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DB1C4CEC5;
	Wed,  2 Oct 2024 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727849562;
	bh=pGKERVyPR74+Q8MZwsGdFZFru+2EDbBPqiU5/ueq4FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4wFLKM5x+3uXcwOP8u4qQntDvT0o5hbpqSjDaNJGMM7YG4Jb8R15LmJnu7T5r/Fq
	 3fmfwnRftim2k0fQj7mEE53xOXfcCq+sEx+Vp/5UPzykw2nMeAZfl+k5nJMFYd5oMQ
	 L4UWeadaxlQyupuRsZTMldDpoNU0i2Zq+A+FDcyeqhLTgsZVgeLoW2j/824ystckzn
	 826Ax7Y/pS080CnzRx42bZCi9bbgZN0iTGkI6LIbij55+8vyZQi0BEvLW3hpJo9fJi
	 iyJ7CQa/2X4o06K5OLFmrLO+kY1nUac/I1pcqmVs73TSzlaqsjNYMnLqub/JTAtFPI
	 jk5sPPTZcl/ww==
Date: Wed, 2 Oct 2024 08:12:38 +0200
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
Message-ID: <20241002-burgfrieden-nahen-079f64e243ad@brauner>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
 <20240930141819.tabcwa3nk5v2mkwu@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930141819.tabcwa3nk5v2mkwu@quack3>
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 30, 2024 at 04:18:19PM GMT, Jan Kara wrote:
> Hi!
> 
> On Tue 24-09-24 11:21:59, Geert Uytterhoeven wrote:
> > On Fri, Aug 30, 2024 at 5:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > It actually has been around for years: For containers and other sandbox
> > > use cases, there will be thousands (and even more) of authenticated
> > > (sub)images running on the same host, unlike OS images.
> > >
> > > Of course, all scenarios can use the same EROFS on-disk format, but
> > > bdev-backed mounts just work well for OS images since golden data is
> > > dumped into real block devices.  However, it's somewhat hard for
> > > container runtimes to manage and isolate so many unnecessary virtual
> > > block devices safely and efficiently [1]: they just look like a burden
> > > to orchestrators and file-backed mounts are preferred indeed.  There
> > > were already enough attempts such as Incremental FS, the original
> > > ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> > > for current EROFS users, ComposeFS, containerd and Android APEXs will
> > > be directly benefited from it.
> > >
> > > On the other hand, previous experimental feature "erofs over fscache"
> > > was once also intended to provide a similar solution (inspired by
> > > Incremental FS discussion [2]), but the following facts show file-backed
> > > mounts will be a better approach:
> > >  - Fscache infrastructure has recently been moved into new Netfslib
> > >    which is an unexpected dependency to EROFS really, although it
> > >    originally claims "it could be used for caching other things such as
> > >    ISO9660 filesystems too." [3]
> > >
> > >  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
> > >    enhancements.  For example, the failover feature took more than
> > >    one year, and the deamonless feature is still far behind now;
> > >
> > >  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
> > >    perfectly supersede "erofs over fscache" in a simpler way since
> > >    developers (mainly containerd folks) could leverage their existing
> > >    caching mechanism entirely in userspace instead of strictly following
> > >    the predefined in-kernel caching tree hierarchy.
> > >
> > > After "fanotify pre-content hooks" lands upstream to provide the same
> > > functionality, "erofs over fscache" will be removed then (as an EROFS
> > > internal improvement and EROFS will not have to bother with on-demand
> > > fetching and/or caching improvements anymore.)
> > >
> > > [1] https://github.com/containers/storage/pull/2039
> > > [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
> > > [3] https://docs.kernel.org/filesystems/caching/fscache.html
> > > [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
> > >
> > > Closes: https://github.com/containers/composefs/issues/144
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Thanks for your patch, which is now commit fb176750266a3d7f
> > ("erofs: add file-backed mount support").
> > 
> > > ---
> > > v2:
> > >  - should use kill_anon_super();
> > >  - add O_LARGEFILE to support large files.
> > >
> > >  fs/erofs/Kconfig    | 17 ++++++++++
> > >  fs/erofs/data.c     | 35 ++++++++++++---------
> > >  fs/erofs/inode.c    |  5 ++-
> > >  fs/erofs/internal.h | 11 +++++--
> > >  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
> > >  5 files changed, 100 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > > index 7dcdce660cac..1428d0530e1c 100644
> > > --- a/fs/erofs/Kconfig
> > > +++ b/fs/erofs/Kconfig
> > > @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
> > >
> > >           If you are not using a security module, say N.
> > >
> > > +config EROFS_FS_BACKED_BY_FILE
> > > +       bool "File-backed EROFS filesystem support"
> > > +       depends on EROFS_FS
> > > +       default y
> > 
> > I am a bit reluctant to have this default to y, without an ack from
> > the VFS maintainers.
> 
> Well, we generally let filesystems do whatever they decide to do unless it
> is a affecting stability / security / maintainability of the whole system.
> In this case I don't see anything that would be substantially different
> than if we go through a loop device. So although the feature looks somewhat
> unusual I don't see a reason to nack it or otherwise interfere with
> whatever the fs maintainer wants to do. Are you concerned about a
> particular problem?

I see no reason to nak it either.
