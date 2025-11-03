Return-Path: <linux-erofs+bounces-1330-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF90C2C7C5
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:53:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZNG0gRFz2yrm;
	Tue,  4 Nov 2025 01:53:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181630;
	cv=none; b=c98Wdi8+T1IFmodE2S5x9VG2AoIa3DGu52CnPAytS+H3k9PRx1qACjuUjEYpNoRRKKA+BY/NNoKkwdLjGdTiEjTb20UKMLNLzgA9H7NIeOYCRc0F2Tzup+ESjF/tM0lw3H+4t9pXNr56yvJuLfGbL62YNIx8NfLY1vMFDkTGtwRF9WE43d2duIgmXvTKefDPY76UufenqTc7oNElM8lFNIbZIg0ztFyaOxBK5/loqAcETRslpKxEUH1PoXPdXcH4YbPSp0HkMjgoAlo3ad9pm1WMRsu2QRxZDyP5GkBliHjTqpEY1BXdn5/6ShUAmOlgtCdGbavPJvu8eTJwp7kGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181630; c=relaxed/relaxed;
	bh=no0N6VDnDXRSGJ/eJArH631z09KDwVeHeiWa2BoyXSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVuh6ZUoOVGWvvFPG+fCAhuKBBHmQ9I1FpkGD4VJrDi+Dhk38bBPsQI+mveXCqdUwckrxGvUqKRwTJ3JBqSqn7H3T9LEyABDgM5CnfUtQugL6MWH8S9zG0fBH6BoC0yaRxWiL9PeSe+b8ugcOf7/Fq7W3XnlVwYovcB2tig2SaL5FA7EjfC7fuhhOTrvv2Nd5tfUh7gofAp0D7qEUEGMlqYDIsafAoY0n7judVxebTsyWe6QgNnKhSichWIpntj52AlWIUpB5nVCj6ubl1tAKkA4CeIHBIjqeSWKXF8BLcVd0bcKX+ynH91LDyx4jcZIiU9Tx5HsyRy/h1Y8Aai3IQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ePqVIqG4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ePqVIqG4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZNF28Q4z2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:53:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF000437F6;
	Mon,  3 Nov 2025 14:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D9C4CEE7;
	Mon,  3 Nov 2025 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181626;
	bh=Ri6OYBYHckwm0+mp0un6shuRJsNaNIpkth772AmzDvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePqVIqG4hgdozY8I2Dt8f9GBLcNVnwR0Jgb3e3j7tGtxsgJpAH8iLGHXZyk9mpAE2
	 jH8KR23qmbyXMGzJG1SLbp3KTRDsxctPEu6L3NIFpuAcPkWBTlBCHA44h963/Zp9MY
	 cVMe/ZnwEOW71v+qasSEqLSoboeasIJTn6N0ZNjv3h9e9Wq8wnThxxTQq7z5LVg7Yt
	 FNHNeOAuFOhl1xoFkYg33SiMz9z8Lxyu1iChCLxLP8a3Zsr2IkEjjO65wX+iamxuVV
	 c6iv3khLyHyPmgNaDWT5k4N3doojjX49b95YAjOQvyDZ7EJMDC5v3M1lyWS+apD6ql
	 hqi0UoeJnpgGQ==
Date: Mon, 3 Nov 2025 15:53:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 00/16] credentials guards: the easy cases
Message-ID: <20251103-studien-anwalt-1991078e7e12@brauner>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Nov 03, 2025 at 02:29:40PM +0100, Amir Goldstein wrote:
> On Mon, Nov 3, 2025 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > This converts all users of override_creds() to rely on credentials
> > guards. Leave all those that do the prepare_creds() + modify creds +
> > override_creds() dance alone for now. Some of them qualify for their own
> > variant.
> 
> Nice!
> 
> What about with_ovl_creator_cred()/scoped_with_ovl_creator_cred()?
> Is there any reason not to do it as well?

No, I don't think there is other than that the complexity of it warrants
a separate patch series.

When override_creds()/revert_creds() still was a reference count
bonanza, we struggled with two issues related to overlayfs:

(1) reference counting was sometimes very non-obvious
    (think:
    cred = get_cred(creator_cred);
    old_cred = override_cred(cred);
    put_cred(revert_creds(old_cred));
    put_cred(cred); or worse )

    and thus the credential override logic when creating files where you
    change the fsuid and you essentially override credentials _twice_
    lead to pretty twisted logic that wasn't necessarily clarified by
    the scope-based semantics.

    This problem is now resolved since my prior rework.

(2) The scope based cleanup did struggle in switch() statements that
    messed with the scope-based logic iirc. I don't have the details in
    my head right now anymore but basically this is why we originally
    punted on the original conversion so we wouldn't end up chasing bugs
    in two semantic changes done at the same time.

    I think we're ready to do (2) now.

What I tried in this series is to reduce the amount of scope switching
due to gotos and that's why I also moved some code around. It also helps
to visually clarify the guards when the scope is reduced by moving large
portions where work is done under a guard out to a helper. That's
especially true when the guard overrides credentials imho. That's
something I already aimed for during the first conversion.

> 
> I can try to clear some time for this cleanup.
> 
> For this series, feel free to add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.
> 
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Christian Brauner (16):
> >       cred: add {scoped_}with_creds() guards
> >       aio: use credential guards
> >       backing-file: use credential guards for reads
> >       backing-file: use credential guards for writes
> >       backing-file: use credential guards for splice read
> >       backing-file: use credential guards for splice write
> >       backing-file: use credential guards for mmap
> >       binfmt_misc: use credential guards
> >       erofs: use credential guards
> >       nfs: use credential guards in nfs_local_call_read()
> >       nfs: use credential guards in nfs_local_call_write()
> >       nfs: use credential guards in nfs_idmap_get_key()
> >       smb: use credential guards in cifs_get_spnego_key()
> >       act: use credential guards in acct_write_process()
> >       cgroup: use credential guards in cgroup_attach_permissions()
> >       net/dns_resolver: use credential guards in dns_query()
> >
> >  fs/aio.c                     |   6 +-
> >  fs/backing-file.c            | 147 ++++++++++++++++++++++---------------------
> >  fs/binfmt_misc.c             |   7 +--
> >  fs/erofs/fileio.c            |   6 +-
> >  fs/nfs/localio.c             |  59 +++++++++--------
> >  fs/nfs/nfs4idmap.c           |   7 +--
> >  fs/smb/client/cifs_spnego.c  |   6 +-
> >  include/linux/cred.h         |  12 ++--
> >  kernel/acct.c                |   6 +-
> >  kernel/cgroup/cgroup.c       |  10 ++-
> >  net/dns_resolver/dns_query.c |   6 +-
> >  11 files changed, 133 insertions(+), 139 deletions(-)
> > ---
> > base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
> > change-id: 20251103-work-creds-guards-simple-619ef2200d22
> >
> >

