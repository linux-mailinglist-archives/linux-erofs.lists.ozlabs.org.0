Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E992557E
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 10:37:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oYIXoNSn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDY7W1RFJz3cYG
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 18:37:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oYIXoNSn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDY7S0D0bz2y8m
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 18:37:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9B6ACCE17E9;
	Wed,  3 Jul 2024 08:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FEAC2BD10;
	Wed,  3 Jul 2024 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995856;
	bh=sJN+MwV5sUnjoxSQ5dfAVt8zKfWkamWIkI8xHG1+5/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYIXoNSnDnTODvPBZ2lWNiOAhSRpc/Ft1dVV3BiFipzKHxsDmrIByL4EAO+3IQ0+m
	 U0dVB539ht4XH4U9PYqwTkeAPNdPW3m2vl0OfRnSrtf8QJwapI5epMUx1kGzzocRNe
	 +r0bKbP84mX1sXSFxMJ8y90kIQx/iolbmU29SIjmKFX1yUCkHGhhVaCeB1ZlyDQDVl
	 oqFjDHqBjkcro6AyOgpUDFjb1WOUGt4kTGI3pjFK0V7k4B7HNnXmYH60gb9cL20l3k
	 9nEusexxMFMacoQCtSHIBl/x6rPyPoNBc43Mrpr/ASYn8CoWuEGyEc7J0TkELnNwaS
	 xQRvrXMCXj+zw==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Subject: Re: [PATCH v3 0/9] cachefiles: random bugfixes
Date: Wed,  3 Jul 2024 10:37:24 +0200
Message-ID: <20240703-beweis-glimpflich-439d10d8ea13@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=brauner@kernel.org; h=from:subject:message-id; bh=sJN+MwV5sUnjoxSQ5dfAVt8zKfWkamWIkI8xHG1+5/E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS18h5fzfvjj8+mIIHXTK3+lpoZn/JX77N5alJzQZJXM cEgvEigo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL+EQz/U/PmMhQcv9nvURe/ brVqbY2D5b2lTOrvorf8U9dP3qzWyPBX+pN+nderS4Kne03ZZ65S5HAV31vu/PaN2hn9RJuQ/yt ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
Cc: Christian Brauner <brauner@kernel.org>, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 28 Jun 2024 14:29:21 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This is the third version of this patch series, in which another patch set
> is subsumed into this one to avoid confusing the two patch sets.
> (https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/9] netfs, fscache: export fscache_put_volume() and add fscache_try_get_volume()
      https://git.kernel.org/vfs/vfs/c/857edaec7e8b
[2/9] cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
      https://git.kernel.org/vfs/vfs/c/6438822b8978
[3/9] cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
      https://git.kernel.org/vfs/vfs/c/ba71b9fbe167
[4/9] cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
      https://git.kernel.org/vfs/vfs/c/389332dcf4ea
[5/9] cachefiles: stop sending new request when dropping object
      https://git.kernel.org/vfs/vfs/c/6091d755c681
[6/9] cachefiles: cancel all requests for the object that is being dropped
      https://git.kernel.org/vfs/vfs/c/f4648f418a04
[7/9] cachefiles: wait for ondemand_object_worker to finish when dropping object
      https://git.kernel.org/vfs/vfs/c/9659aaa5c58b
[8/9] cachefiles: cyclic allocation of msg_id to avoid reuse
      https://git.kernel.org/vfs/vfs/c/1a95962625e1
[9/9] cachefiles: add missing lock protection when polling
      https://git.kernel.org/vfs/vfs/c/6cc42ff0f5c9
