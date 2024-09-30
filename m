Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97298A6DF
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 16:18:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHNTn0tsSz302P
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2024 00:18:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727705915;
	cv=none; b=D41YbfjxsAO1k6tACYW7PTyhzW85AklZu5AA5YAC32Nd21azC3H4+KJe4E/WMS9erlq+hob/vUZVRvsIJH2F1gKmBVGJWXQ6yksJwQJ9h1O8LojTPn968T/btP49wej6jago17+0AdsbDhWYszILADz/UsSWZDQTzubEin7qMP9lWEQQjUbf4UXbqWiq1ApzJYsP7phhprfDU0Q8NDPzxSj7Uch3ZaqXBHNN8NbiOAjXAWJbEo0cN328HPppxRmwHoVDqJnuNeYRRNJ7LVjmGE080LqvtFBFnLJ/9DOsbM0/cH73Cv1dO7C2ZJlmFNbCT3VXqvjPmYM2NJLiGRFuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727705915; c=relaxed/relaxed;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2kOko2s9+T50xeaVMlPWGyejQSUlU/XRb+iGos1whAxFocOSvLQgrE8tzg8YKH3P+tQ1LxTJ15XGcsg++3h/JKaOxFO9YLqS/YFXVon3fUdvwDzSfs6dgbuRLm1QHeoW1zhc3IetbMJwQA5q9UtUzosVE5IaXpxYc73CagokH617dFBmznUTxPPO6fMsAOSaC2ubZlsYScVwsjE5YyjvlnHhbS5boEC4zYOZrVdBDG0jSsMV+NvN3tA2N/T3yeZwH0Z+yqa0nAAyEISXzfgcBVJ9KRB75SfekNa1kGTan14/a52Z37EY2dIZCz3uOseJH+JzbiKi+EQB1I2X7aH4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oQOIubJv; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eU2U7l7j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZXKypRn9; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qgTRa9DM; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oQOIubJv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eU2U7l7j;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZXKypRn9;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qgTRa9DM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHNTk3ZXjz2yLJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2024 00:18:34 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5DC21FBAC;
	Mon, 30 Sep 2024 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727705904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=oQOIubJvVB5fGbM720M+yr59VBiD+XA/tPA7+aVDk3K5REPI2w06nhIgH2Jx8hDvsv9g2M
	trn1mJI9msnmjnL44gtFladFfJn2bbs5tGg4pwI6ILa8bYkCYzl1UUPLiM92QAbqjhvqEk
	D6LfyUhGqnqxoxtuRjXuZz0MUz33yEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727705904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=eU2U7l7jQsgvjGuTl2SO1P2Bliz3IEM8M9wnaQ9n/ps4U0aWdM85QW6sqQTuOHDKF661qU
	qqgWuChD3ZDlqYDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZXKypRn9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qgTRa9DM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727705903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=ZXKypRn9B9Jm+kMno1hmhGnlyDsq+5Z0mqO44ElQtXIqqjqwGXiRCNtxUYjdgBCPGZrO0K
	PrzPy823p0rIReUUrnKG1aEaBJVsWBVOhu1ZmJ7YZOlgpUrQUaB+a9FbLvooVbtxePmPy1
	+cl9UwCn365KDomRSzFVRy7cdHZHhxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727705903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=qgTRa9DMJA/CgCPS/5P5mehbVINY8eB9oZNUrefPsKzLGf8TF1fm0a18Rx5p6q9qHtZrs3
	qG/20Cq0kR3DhJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA96A13A8B;
	Mon, 30 Sep 2024 14:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lcdZNS+z+mZ0DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 14:18:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9398AA0845; Mon, 30 Sep 2024 16:18:19 +0200 (CEST)
Date: Mon, 30 Sep 2024 16:18:19 +0200
From: Jan Kara <jack@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
Message-ID: <20240930141819.tabcwa3nk5v2mkwu@quack3>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
X-Rspamd-Queue-Id: E5DC21FBAC
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi!

On Tue 24-09-24 11:21:59, Geert Uytterhoeven wrote:
> On Fri, Aug 30, 2024 at 5:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > It actually has been around for years: For containers and other sandbox
> > use cases, there will be thousands (and even more) of authenticated
> > (sub)images running on the same host, unlike OS images.
> >
> > Of course, all scenarios can use the same EROFS on-disk format, but
> > bdev-backed mounts just work well for OS images since golden data is
> > dumped into real block devices.  However, it's somewhat hard for
> > container runtimes to manage and isolate so many unnecessary virtual
> > block devices safely and efficiently [1]: they just look like a burden
> > to orchestrators and file-backed mounts are preferred indeed.  There
> > were already enough attempts such as Incremental FS, the original
> > ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> > for current EROFS users, ComposeFS, containerd and Android APEXs will
> > be directly benefited from it.
> >
> > On the other hand, previous experimental feature "erofs over fscache"
> > was once also intended to provide a similar solution (inspired by
> > Incremental FS discussion [2]), but the following facts show file-backed
> > mounts will be a better approach:
> >  - Fscache infrastructure has recently been moved into new Netfslib
> >    which is an unexpected dependency to EROFS really, although it
> >    originally claims "it could be used for caching other things such as
> >    ISO9660 filesystems too." [3]
> >
> >  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
> >    enhancements.  For example, the failover feature took more than
> >    one year, and the deamonless feature is still far behind now;
> >
> >  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
> >    perfectly supersede "erofs over fscache" in a simpler way since
> >    developers (mainly containerd folks) could leverage their existing
> >    caching mechanism entirely in userspace instead of strictly following
> >    the predefined in-kernel caching tree hierarchy.
> >
> > After "fanotify pre-content hooks" lands upstream to provide the same
> > functionality, "erofs over fscache" will be removed then (as an EROFS
> > internal improvement and EROFS will not have to bother with on-demand
> > fetching and/or caching improvements anymore.)
> >
> > [1] https://github.com/containers/storage/pull/2039
> > [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
> > [3] https://docs.kernel.org/filesystems/caching/fscache.html
> > [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
> >
> > Closes: https://github.com/containers/composefs/issues/144
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks for your patch, which is now commit fb176750266a3d7f
> ("erofs: add file-backed mount support").
> 
> > ---
> > v2:
> >  - should use kill_anon_super();
> >  - add O_LARGEFILE to support large files.
> >
> >  fs/erofs/Kconfig    | 17 ++++++++++
> >  fs/erofs/data.c     | 35 ++++++++++++---------
> >  fs/erofs/inode.c    |  5 ++-
> >  fs/erofs/internal.h | 11 +++++--
> >  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
> >  5 files changed, 100 insertions(+), 44 deletions(-)
> >
> > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > index 7dcdce660cac..1428d0530e1c 100644
> > --- a/fs/erofs/Kconfig
> > +++ b/fs/erofs/Kconfig
> > @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
> >
> >           If you are not using a security module, say N.
> >
> > +config EROFS_FS_BACKED_BY_FILE
> > +       bool "File-backed EROFS filesystem support"
> > +       depends on EROFS_FS
> > +       default y
> 
> I am a bit reluctant to have this default to y, without an ack from
> the VFS maintainers.

Well, we generally let filesystems do whatever they decide to do unless it
is a affecting stability / security / maintainability of the whole system.
In this case I don't see anything that would be substantially different
than if we go through a loop device. So although the feature looks somewhat
unusual I don't see a reason to nack it or otherwise interfere with
whatever the fs maintainer wants to do. Are you concerned about a
particular problem?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
