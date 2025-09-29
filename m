Return-Path: <linux-erofs+bounces-1134-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2EDBA9B2D
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Sep 2025 16:50:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cb3yv3sn9z304x;
	Tue, 30 Sep 2025 00:50:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759157447;
	cv=none; b=NQUY5yS8iSYH/+j4yMfWKzDBfjKeQbS3J77GNJ8MWhTTHDEkeXQdEIs9Y62CfCKxzct3aLJB7XP1jg5mGKo6FGMWftVrJwRvwY5gg9rtrq0sbIZ398V0xeS5dgBIAWQ1S/IL/zKrZQLTVxBOZbztOnIcn+mGOfCkbMHi5ZDCRyeEbqmnEojWRsrEt44uuGKa3pKfC4LgkSe6+Y4WmRRKsGVV3y2EJC5si+S7d9IemGhYDHkwH2dpwj7E/Xj8svqDVZllHdVaZvPHxpVm2vo56S+2iWRIX6UXzPAaGJyv6Wgx8g0wz7Dm6hHmNK3sVcxv1yX+ZBdtClyTzRBdW+ws9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759157447; c=relaxed/relaxed;
	bh=BoxyQo54wSa7ax1hRoxmrhHFftll/zXntLA40GYPQfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibm2CflTt2N/VH8cOWa1yiN/zo8SjZgG+mn57h5ugGMBFz2pglNvCFtS2hx6wfCvQAUb59Br6zHK54bHSuY+dA14ZOHURgdxSrzPNWfkARkX85MgWCSGeB9FgdukQz0I5mpOB0xbsaH6UEOKnOlNMEpgKh16aO3fOe3F6cY4ELagQYnuBnq6c19Vr9IJzoeHEXztA914q7H/+4xU2tBFjKajaqFwvf1M6sdpQpJBCKv75S0zOVyXHuf4FpWBPRf5xTYF7MeSAQgKS6r/uoe12b78GHTqDCZsfaGkh+FHJxPzVdQeWBh8/swKbFrwm9GlN8L6x7MOj3uFhCXYW4DgIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R7ESU4Xg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R7ESU4Xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cb3yr2v7pz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 00:50:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CE14458B0;
	Mon, 29 Sep 2025 14:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CA8C4CEF4;
	Mon, 29 Sep 2025 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157441;
	bh=jJLcX+SzRPpAhcWwG22sNpQE6rOdnRWnbTB0ROWvQaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7ESU4XgSZyuQkLKFXWuwBp2S5dmvs+SKWQybSFfl5Vtbu+e1unXbX+knbuARQ/6O
	 XtrDy7+HEk4TzxaHZfz6rShM2PqswcCgcOgg6fanPNoASHJIPhWtWcWBqlMBE+F8ux
	 tVks/DjxgH6LKja24qJFbQQOkUmyenfFMZlosoGHvFj7Z1eQFTq7OkV5mo1so/MsfO
	 z6vKU3XbhIHNUgSAGIzgQrqQGt4LBj0x5J8UGNPukcM7s3GMXAjfQd9W/5MK62Swkl
	 2/Jhl4AN8mXLxEHb3uuksMVX4LIITQCRdqx/CLe3qq3g9xxQXFk9DaoZ9q01+VCGn+
	 jUwXLgZabaeng==
Date: Mon, 29 Sep 2025 22:50:36 +0800
From: Gao Xiang <xiang@kernel.org>
To: Ivan Mikheykin <ivan.mikheykin@flant.com>
Cc: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: tar: support archives without
 end-of-archive entry
Message-ID: <aNqcvDiftM3ST7Mn@debian>
Mail-Followup-To: Ivan Mikheykin <ivan.mikheykin@flant.com>,
	linux-erofs@lists.ozlabs.org
References: <20250929133222.38815-1-ivan.mikheykin@flant.com>
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
In-Reply-To: <20250929133222.38815-1-ivan.mikheykin@flant.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Ivan,

On Mon, Sep 29, 2025 at 04:32:22PM +0300, Ivan Mikheykin wrote:
> Tar standard https://www.gnu.org/software/tar/manual/html_node/Standard.html
> says that archive "terminated by an end-of-archive entry,
> which consists of two 512 blocks of zero bytes".
> 
> Is also says:
> 
> "A reasonable system should write such end-of-file marker at the end
> of an archive, but must not assume that such a block exists when
> reading an archive. In particular, GNU tar does not treat missing
> end-of-file marker as an error and silently ignores the fact."
> 
> It is rare for erofs to encounter such problem, as images are mostly
> built with docker or buildah. But if you create image using tar library
> in Golang directly uploading layers to registry, you'll get tar layers
> without end-of-archive block. Running containers with such images will
> trigger this error during extraction:
> 
> mkfs.erofs --tar=f --aufs --quiet -Enoinline_data test.erofs test-no-end.tar
> <E> erofs: failed to read header block @ 42496
> <E> erofs: 	Could not format the device : [Error 5] Input/output error
> 
> This patch fixes the problem by assuming that eof is equal to the end-of-archive.
> 
> Reproducible tar without end-of-archive (base64-encoded gzipped blob):
> H4sICKVi2mgAA3Rlc3QtMTAtMi1ibG9ja3MudGFyAAtzDQr29PdjoCUwAAIzExMwbW5mCqYN
> jQzANBgYGTEYmhqYmpqamRoaGTMYGBqaGJkyKBjQ1FVQUFpcklikoMCQkpmYll9ahFNdYkpu
> Zh49HERfYKhnoWdowGVkYGSqa2Cua2jKNdAuGgX0BADwFwqsAAQAAA==

Thanks for the patch!

Could you confirm how docker/containerd or podman parses such image?

Because the POSIX standard says:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html
"At the end of the archive file there shall be two 512-byte blocks filled
with binary zeros, interpreted as an end-of-archive indicator."

So such tar layers will be non-standard, I wonder we need at least
a erofs_warn() message for such tars at least.

Thanks,
Gao Xiang

> 
> Signed-off-by: Ivan Mikheykin <ivan.mikheykin@flant.com>

