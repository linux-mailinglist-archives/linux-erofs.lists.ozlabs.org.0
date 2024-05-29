Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id A40658D3541
	for <lists+linux-erofs@lfdr.de>; Wed, 29 May 2024 13:16:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jXGyI0ee;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vq66c3W53z78LW
	for <lists+linux-erofs@lfdr.de>; Wed, 29 May 2024 21:07:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jXGyI0ee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vq66R2M86z78KN
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 May 2024 21:07:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4908362821;
	Wed, 29 May 2024 11:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A5C2BD10;
	Wed, 29 May 2024 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716980844;
	bh=Zz5dcUJAjpstTHPJIb+etUveMtW/6Scwi5EQeOUJ7ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXGyI0eek+m4h8vLzCcIeqL3BResayzbn/9eq4eQdmX8aGvdadTDSyYhHbcWZ7SMc
	 oCHQG0OQdVbEsJSt3B2AbSXznOQSRzoJwEN5Cox/MdZ7LUZKIyLN+E5lH0+PfCsDRN
	 TGZF/nVM1sP/Icm7ACn92c6W04cxE/awFZkGYgQQSmtOOVLCVu9Iv12oMrqxF1myES
	 esvfCOgGZhdP02mrWdKyYm4BDL9W/A90oxT6Sb4FeOwgsoS00ldMD3kE2DTm4w+oFq
	 Mox9gT62Xm9LJZdYY3YHlfGoF/FY4TJfAmVS6NUnNN+yAmO3a8yUWCXmg2lkxK737+
	 ENQfbJjqd1Ecw==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Subject: Re: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 29 May 2024 13:07:07 +0200
Message-ID: <20240529-lehrling-verordnen-e5040aa65017@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=brauner@kernel.org; h=from:subject:message-id; bh=Zz5dcUJAjpstTHPJIb+etUveMtW/6Scwi5EQeOUJ7ds=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSF80RPn/nywh92lrKCzP0rxB1+/17elKrM5+26rmBZ2 JZzUuuNOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy34zhr8yErrj9TWUn1tkq PQysO1zQo8TAtoQhRa5EiEvt1a/+cIa/0uzH707ymRFnFLm2c8ElhUNcmVJXtrkVOp/hF5hcbfK ECwA=
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

On Wed, 22 May 2024 19:42:56 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This is the third version of this patch series. The new version has no
> functional changes compared to the previous one, so I've kept the previous
> Acked-by and Reviewed-by, so please let me know if you have any objections.
> 
> [...]

So I've taken that as a fixes series which should probably make it upstream
rather sooner than later. Correct?

---

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

[01/12] cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
        https://git.kernel.org/vfs/vfs/c/cc5ac966f261
[02/12] cachefiles: remove requests from xarray during flushing requests
        https://git.kernel.org/vfs/vfs/c/0fc75c5940fa
[03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
        https://git.kernel.org/vfs/vfs/c/de3e26f9e5b7
[04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
        https://git.kernel.org/vfs/vfs/c/da4a82741606
[05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
        https://git.kernel.org/vfs/vfs/c/3e6d704f02aa
[06/12] cachefiles: add consistency check for copen/cread
        https://git.kernel.org/vfs/vfs/c/a26dc49df37e
[07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
        https://git.kernel.org/vfs/vfs/c/0a790040838c
[08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
        https://git.kernel.org/vfs/vfs/c/4988e35e95fc
[09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
        https://git.kernel.org/vfs/vfs/c/4b4391e77a6b
[10/12] cachefiles: Set object to close if ondemand_id < 0 in copen
        https://git.kernel.org/vfs/vfs/c/4f8703fb3482
[11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
        https://git.kernel.org/vfs/vfs/c/85e833cd7243
[12/12] cachefiles: make on-demand read killable
        https://git.kernel.org/vfs/vfs/c/bc9dde615546
