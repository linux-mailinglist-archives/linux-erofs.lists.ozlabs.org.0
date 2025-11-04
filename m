Return-Path: <linux-erofs+bounces-1350-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB0C30C88
	for <lists+linux-erofs@lfdr.de>; Tue, 04 Nov 2025 12:40:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d16321pB4z3bf8;
	Tue,  4 Nov 2025 22:40:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762256446;
	cv=none; b=R0nGLJwHROzQmQDmznj+WRysU2ZeIfeGEAI+FgTAM695crsZU49Kx3NL8Dq11ZIOiEvkqoTPA7NR8Z9MhlJ38LhIUzCZSK9SuTq4cio91S3oraMJFOPq2tX0U7kT2Z6Lrvp8aL9Ng3JLftaC37zooPfOFfAsUtNbrAVCGWbQ99QDvHiR6EQo0yHjJQzp0qzba6I25AviQht1nTiQM2uCtzGp/vlOS5BPZMxQbd39Dluvg9g9k29Xkrif88DTAZrQGJjEe/aJa6g+P058lz67MjluOnqHc4U+9ZRbBHL6Z2L5G0l0yamLhpSRD6+5XCfQoYWiSiaiI1UV4lJvAB2G6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762256446; c=relaxed/relaxed;
	bh=HyTVbWaFuMOJhTuy8PYX2vPpYMQ+LxuzHldesJTmPLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4oGidaCc+c2glOa45XIWTuiNG9wxYkMsnvqOcbpRBMudrdgDv6wBMFAI84ifTJ2IwvL37u+M2nBhKnhwgXSsPzn+Q9CC4PbKnl9CviY5qGmcZjBfr3ymUaY5sIfKaJhCgZjF6xivtJ2MKHlLQOuOCN5sY7ClBSm74VKW3BhJgVm9X54Hi6+EAmdbrP2CnjL2zls+yOAORHarza2vt11BPqvbfH53UEe4sDBY5DnOMwiKCFd3p7kc9mpQlpHN5ghVI1fkYDCOj/dbn5/1tb7mZTZm05PWhrkEe6bzUKedc+FT8z+NGbC/XVvdNKbTEY/DKzL41SQls9tkDYrqM8qFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TjxRGUvs; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TjxRGUvs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d16311zG9z3bf3
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 22:40:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C635601EB;
	Tue,  4 Nov 2025 11:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578D9C116B1;
	Tue,  4 Nov 2025 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762256442;
	bh=W07D7k8d9r42eIB9elVR5UyKqnAXxbxiWn376ofpzAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjxRGUvsTz2TY9x558mHTIz1Ih91p9JqOFsGFSwluMb08sYCfC6Ta+zRipYa9vIQO
	 sibc5N5/8swj3yBcqMXzlZviupVerLGaz7oBWIfyw0edv8u8ZJoJ/Jad9Wfy3QYUTJ
	 WxUM9obfJfM21WpmvJzLl6YFVkGFkqwhWyuF/cDhSjTUDFTux0PggSbhNbsoGf3D7J
	 cXkQaq1eT0oOY29VqHb9Fwjpnefr6N/CoaJP2W9ISCdRcRvl8DTW4iG1YeYHw7WC6H
	 8U8SBPX4W5hp7daJ1pRBpbhJIzlkSSgVCiQid6fuR9ivcp6dJvC9HEt0z/VPCUfUVy
	 rTpA4nSfJZaqA==
Date: Tue, 4 Nov 2025 12:40:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
Message-ID: <20251104-hebamme-sinnieren-a30735196a26@brauner>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
 <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
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
In-Reply-To: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Nov 04, 2025 at 08:04:28AM +0900, Linus Torvalds wrote:
> On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
> >
> >         /* Perform file operations on behalf of whoever enabled accounting */
> > -       cred = override_creds(file->f_cred);
> > -
> > +       with_creds(file->f_cred);
> 
> I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
> have this version at all.
> 
> Most of the cases want that anyway, and the couple of plain
> "with_creds()" cases look like they would only be cleaned up by making
> the cred scoping more explicit.
> 
> What do you think?

Yeah, good idea. I reworked it all so now we're only left with:

scoped_with_creds()
scoped_with_kernel_creds()

It increases the indentation for about 3 cases but otherwise is safer.
It's all in:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=kernel-6.19.cred

