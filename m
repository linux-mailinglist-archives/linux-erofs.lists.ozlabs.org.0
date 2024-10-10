Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F139982BF
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 11:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728553739;
	bh=VJIgNujBeIwxrTdQM+w0V65yu9Y9NsiFF6C05DvZ6Yc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Z8+PB60aM+WFX6B+JA5krx7Dkb8Rt7TeYhDimHAk4yhkz0i2LGMNBoRzmKRSG9/bv
	 r2n9KUvQ5F116A3FVy1I1Ue0HsdKgI5j86iJlJMBzALUQIGhLVW6jJep16sZpo8DxI
	 lGFfBwPKGaXbm54Y3fcv4WaD6GbEMoCsA/iEfqzI+wTMA+yVhgH6A3hfqG9xZXzd05
	 qDIsz02+mMhhKsg35mgbgnemOQK1k/jBoIyDi/nnTs+SSxKfywHgj0//UlPi7tlcms
	 IISHwAptgMMu6vXNOQTg5RKmzp8LOPbEQuP8yCulIErBxouZg2v3kfqIVBA8NeCeXU
	 8uQtV8MVTRR5Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPQ235qlfz3brm
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 20:48:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728553738;
	cv=none; b=aVVBarC/X9Oq6jY52WTkE2NA7ggiVOGuVKSLLa0dWibITWJMRzGlSAXFAvZcFBb2ddtFOTF9SYIXwBShlH1uxxU1/L8dwo+XeSF10GKvN2aCg7MVQT/dm33vvguoEqeA3Q5CKSyLYoplgVVz8qUQjiWUyJe3Rq2YQgl+p6NUAr2GSA0BIFpzZBtj9wQh6uaWiqMetucgMv4XGuIk/sLUQmZi7ebG7ZiJYfEKG6dHEPQs2GBeku6rCKOmkmylPqXneOlUwOcpoBgxjyJwKZqNPPDAoivXRrx+odnni0ptEsY3EYDm7UBOisOfjArlXlomdyrTJlCViS63Sk74M14ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728553738; c=relaxed/relaxed;
	bh=VJIgNujBeIwxrTdQM+w0V65yu9Y9NsiFF6C05DvZ6Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1j6/tieBOGOY1Ofa79lMc0m3+zvYHrMY1826VM5bY42n0fo3M/HnA7TgHh8YTrNFFgb0fL2MwZL6pVekmF1zT3aYWan7bQLJSGhXha96Ku9klLnnU8oGpbaeYUDhiMIpym7gCzK1BE1s22JhAx5bjHS/Fk37BvXmu4n9OClDJVm3ci4kXNKORUSzYNfp2f1E0vaTeRc0E7L65Xea59Y701WbKCQKkny5m4EWsnDaf2vRSYTRbwHarisbkqPrpIzlf+rwncIY6+nqcKH+VvSRK3Z7MuM/j+O5eV7TdT1WqqwXbdXOaPd+YUdVh5gnLCAEc67q3lMEOeldlTe9C+raA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nHKv48xA; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nHKv48xA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPQ2148G0z2xJ6
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 20:48:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5728A5C5FF7;
	Thu, 10 Oct 2024 09:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16561C4CEC6;
	Thu, 10 Oct 2024 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553733;
	bh=DZHX/dOTGTTWmHSD7EGIIvqgPoTlZrjsUh+D2k6vutc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHKv48xAGWgbyleVsFTzt8YP+w0xQOUPTLbUmoIl5sP0HFJ9QnHG5B5tqaEv7ELKd
	 9UprnO4fTAK11YvzpndvancYqPFj8L8o5Rt5q0iaYcdsmL2hl72jV2dziDVWGDGOec
	 Fs8b3l7VJUHCVOqxDIbDnqtwaDGMDdxmdwkY8wDqKNiZflZXZLsDLAnVkr3vjJnU3g
	 p8zpxFw6Gmc+XpnxIM3j6FBFpPt55rhSx8JsVMYyAj5BguEp3BOhTvwCDq+TO9hA5M
	 hZHgCf6Mt/tPYpcGgYA2zvlQC2dFAm7HcE8aFn5oQQ/DyK/Lv5JE2yLvuQmoD8CDnh
	 48Ngqb/jUEdMQ==
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Date: Thu, 10 Oct 2024 11:48:36 +0200
Message-ID: <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=brauner@kernel.org; h=from:subject:message-id; bh=DZHX/dOTGTTWmHSD7EGIIvqgPoTlZrjsUh+D2k6vutc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSzL/qz2fGNauqe95Hf7NR+CBgGNB28P+H1lc1fzmxfx L7Gpi3dpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAih+QZGZ41//LavdTmmXmy Qb2ZpsNBp6+OZV2V5lwHbbmPPkqUb2FkmPu9pMm47Wxut3tZxd07uVMDahem6Hv7S/A+YZv16aw EEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
> As Allison reported [1], currently get_tree_bdev() will store
> "Can't lookup blockdev" error message.  Although it makes sense for
> pure bdev-based fses, this message may mislead users who try to use
> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> then.
> 
> Add get_tree_bdev_flags() to specify extensible flags [2] and
> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
> since it's misleading to EROFS file-backed mounts now.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] fs/super.c: introduce get_tree_bdev_flags()
      https://git.kernel.org/vfs/vfs/c/f54acb32dff2
[2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
      https://git.kernel.org/vfs/vfs/c/83e6e973d9c9
