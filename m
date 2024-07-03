Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D371E925563
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 10:31:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=De8x6DGF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDY084bLWz3cY1
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 18:31:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=De8x6DGF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDY052FRYz30VR
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 18:31:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 92CB4CE10F8;
	Wed,  3 Jul 2024 08:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10385C2BD10;
	Wed,  3 Jul 2024 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995473;
	bh=YDu++FQvyBbQ5q007YIq1M9txqwp9dKc/o3S30ODOmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=De8x6DGFGSuDGJ9Fd92iKUb2XW3pL8/ay7jtZOpHAFu4EkQkGXk28CEzWBY4zqQqQ
	 LLulSEHgAtRsvUkG9EEaO0z2E8Xfuvp9Cn1fxSrqqqp8Zh1tw9rKGyGd9uUEq3kyTR
	 zx34zQ/4yOkCJN3JvLEF1niGnZ6jxyiUFbUs3OJZnjwdCI5pGdblQXuG/TAbWoArdm
	 wFpKbtbXyvlbOcF3TAJs/1N59b6RSSUPF4H3h3s0jkbtbNRoFP1+J8CijKpRxtSnRN
	 ac/3TBDqVqZP5959YIKjEOFe8++Ca088D8KzNsHGUPbz7OknTrs1BDL+R1C97f7jBv
	 1olW5FUw/KFrQ==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Subject: Re: (subset) [PATCH v3 0/9] cachefiles: random bugfixes
Date: Wed,  3 Jul 2024 10:30:55 +0200
Message-ID: <20240703-miene-ausziehen-1f6a167a1020@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=brauner@kernel.org; h=from:subject:message-id; bh=YDu++FQvyBbQ5q007YIq1M9txqwp9dKc/o3S30ODOmA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS18rjf3fhdbtn9SEFvTZZnEz+xLrC75lD5Y5eYyue8b dxcivmTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiWcLwP6uI7eHCSFXlg75t rWt2T3IR4O2avGpbrV3qB34jcxXOg4wMF1LX5YReTFgbvXaLVebEdxEV+Tm63+IWzv58u+m8crY yLwA=
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

[4/9] cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
      https://git.kernel.org/vfs/vfs/c/b688bd1735e7
[5/9] cachefiles: stop sending new request when dropping object
      https://git.kernel.org/vfs/vfs/c/32eb47eab833
[6/9] cachefiles: cancel all requests for the object that is being dropped
      https://git.kernel.org/vfs/vfs/c/2f47569feef0
[7/9] cachefiles: wait for ondemand_object_worker to finish when dropping object
      https://git.kernel.org/vfs/vfs/c/343ce8c52dd0
[8/9] cachefiles: cyclic allocation of msg_id to avoid reuse
      https://git.kernel.org/vfs/vfs/c/5e6c8a1ed5ba
[9/9] cachefiles: add missing lock protection when polling
      https://git.kernel.org/vfs/vfs/c/5fcb2094431b
