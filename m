Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D68A9223
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 06:49:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CODneMgz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKlgL2Kthz3cQx
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 14:49:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CODneMgz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKlgD6lYJz3btQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 14:49:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8DF3161628;
	Thu, 18 Apr 2024 04:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAC0C113CC;
	Thu, 18 Apr 2024 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713415765;
	bh=TEYkN7+fY+wtkfU+comhLweSMoF5TPWbSOtRU2V/7GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CODneMgzHR+jUd4KfSxmrtXlNfl8cqogS9qXHVWOEuStcpOFtdB5xhhsD41JmC04n
	 0sogZZ0kf/QZ3YiYZaVkq5szay7Tp6SlHlERDKJSazpfh8rqJJXPer0DFFL5tz1jgw
	 njS+zTxtVl3dVPPTfOQdq5mTZ6hI1jgtb8jnaUkqxogdy81Z66DosusyDlM+dhAgIl
	 uadzsat2Ok+0SN5WunKm62tGJicoqZbwCh9LTfSPTMYTCm6oqPoGu89uq8XFA2akk4
	 SoOjS4UQfvARp3X54/Rlxnydv+j4xk5szQdrT5J5qurYOEQ4GLdAtw+L+ZKAsUgPAv
	 TQQSE6ar3jRvg==
Date: Thu, 18 Apr 2024 12:49:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH v3] erofs-utils: dump: print filesystem blocksize
Message-ID: <ZiCmU7NQikGbnuag@debian>
Mail-Followup-To: Sandeep Dhavale <dhavale@google.com>,
	linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	kernel-team@android.com
References: <20240418000054.2769023-1-dhavale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240418000054.2769023-1-dhavale@google.com>
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 17, 2024 at 05:00:54PM -0700, Sandeep Dhavale wrote:
> mkfs.erofs supports creating filesystem images with different
> blocksizes. Add filesystem blocksize in super block dump so
> its easier to inspect the filesystem.
> 
> The field is added after FS magic, so the output now looks like:
> 
> Filesystem magic number:                      0xE0F5E1E2
> Filesystem blocksize:                         65536
> Filesystem blocks:                            21
> Filesystem inode metadata start block:        0
> Filesystem shared xattr metadata start block: 0
> Filesystem root nid:                          36
> Filesystem lz4_max_distance:                  65535
> Filesystem sb_extslots:                       0
> Filesystem inode count:                       10
> Filesystem created:                           Wed Apr 17 16:53:10 2024
> Filesystem features:                          sb_csum mtime 0padding
> Filesystem UUID:                              e66f6dd1-6882-48c3-9770-fee7c4841a93
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
