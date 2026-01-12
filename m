Return-Path: <linux-erofs+bounces-1825-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC4D1297B
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 13:47:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqXFw6gzJz30Lt;
	Mon, 12 Jan 2026 23:47:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768222036;
	cv=none; b=i9yAO2RrZst8wlqV4olLbzdhaaEdyJdFS5+4rkPABLgcJe7ZKTcCdW9PQ/AcK0Mpqa1ROQnQzWuYpXVq9/SQGjBELGDsf/qB3NIjaXbXoADJJs7y1dIgu4OelgDjgp9KgpKS7F+k1R7AUPra2WfEG744EgFlx42uwZrRbHSxMqvvPvBVnMgtvWSPL7tsxilNQQQwu9t3dAl/zKwuOfkUe9XYWJ96v0VDq/OqJxy+o3MIEXeu481T0kv3n2cArRpn2CTMTnI7wZ4ocui4RuP6tIPzt3i7rUTlI/lQa+BiRRSb8bvwNbFHzqIwYiXJHVlRrzzAfn4pRv46TFCmpyIpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768222036; c=relaxed/relaxed;
	bh=8cpFl2BRZjBSZF9xFcsPMzIyCVM58nptQOXS4DlnTGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA8Frf888zouJJJrBWFMW8qVdIfPjbnh9n22HQ+qHN3jy+GOEsBQwc5HzmtuAOoq3mPapEU2gbRcewIWpijETypIYDxP8ax9c/T5mAA1Ld/Hi62FtljVC2czFr1/r6pQrI5TuHkXEWxZV+rNYQXELn5zzG6Bc1WWF209tBmOIKtPvqJMbzNOVGeoWPHaOvmzWfI8fy5YM2eZ1BFbHiFogEscKPGC+OlYNfUjxREOOagrKyqhP4qMPuLndqbxFedkDUYNn077LvQmkRrE7Ry1pHPeHWri/n0NL1KGWad2SKu+p4QhNMgSF3dSNCMdWzlDgEyqSuW0r9094yD8oOLFmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WwYLIa/Z; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WwYLIa/Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqXFw0WSGz30HQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 23:47:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E502960141;
	Mon, 12 Jan 2026 12:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD7CC16AAE;
	Mon, 12 Jan 2026 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222003;
	bh=Yaur77UJWshlN4SFJ40DKZsCHZS5SiViKRjaHLlWch8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwYLIa/ZAiJu9lNs1+HqdulvGkdyA6nlM8nRkou1F+JhDYbjt6GtPWDMgIfL8RuBy
	 0dqcTctcOyrYJ2rkNsNUcRdosKeE4QCakJ1WXj16jgosHzKzY7i8yhesdVt9jwBDwi
	 2M7tlSQt2ixlEbNC9fy1A8s4BNMLCW6HLleTybBYp/e5SeFNtYRHryBtRx+Wt/IIou
	 WSZHhvgctm19zAiahQRBiOVpcJ/24FrDoh19zLE+KPzzvqIZNtuDIvKLwbAvy7/PhL
	 hh1f1tLqZppS22hM3gLGqRTQSoqIRdZrFDXxFbBDw5eherr77h048cT2CPVwj6CRMk
	 OKdlW1G3R5gRA==
Date: Mon, 12 Jan 2026 13:46:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?utf-8?B?VGltb3Row6ll?= Ravier <tim@siosm.fr>, =?utf-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Sheng Yong <shengyong1@xiaomi.com>, 
	Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
Message-ID: <20260112-zuziehen-fallpauschalen-0ec870c7e5b5@brauner>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
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
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 08, 2026 at 11:07:09AM +0800, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
> 
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
> 
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
> 
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
> 
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
> 
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
> 
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
> 
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
> 
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

