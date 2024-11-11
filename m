Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475F9C3D61
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 12:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731324837;
	bh=s86QEGAEX1dofGFkqEA3dULySjEYCNQcJa+BdzDV/Sk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nvRI4j/29m+mfmh7bnREXSl0lloflK/t1P8kB9mxJtrr5EatUIe+eh+sSwJLxynpm
	 g3JjoA3UCoVEL8P+UOadkQwMLCLl+GCMYSg/5B6mFVEb3Vr/qpxN1/+9vqyNq2jcRd
	 C3QKZvuCtnQFhjfjiuAMWy6tYii+T8/AzQUWsidHwC+hTsjRoClO2GVmVJGWdLxwxd
	 LgR2OAe3mMx97SlJGcaISdi4imbR8u1WJj9mR9+P2T8xci2m3IJoEEms2ADU5cLGrU
	 qniYuvWsLyU4NVZxVw4nAJmTcdftWbz2MBmnfRH0woLsQri262NwH4EQX2hO3EI32g
	 e5bgf03WIj9bg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn6rP2dNBz2ydG
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 22:33:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731324835;
	cv=none; b=HPa8p2fkLh00IAyn2dZ45Ew24DhEzGyt+vBjTIaspQyvQ2Yz1fW0HtojX+Si0DUTFzZIhTleG4G4a43f4FYdAulaTNVUwE0accEf9X/zEaPykSUjsizXVcCmu6hr2TrF106ir6twA6Eh+6Uud0l3vtDwjAH2rNp629catK74k7ruuKL2bkmbq3s+ZXbyT+Y3sStItaP6lEe2HgeL/uoESGH7IReH2esKaI3Xd3VpknrnAOaNSS0zfzTfEkEicZvV9kn5mAFx+Nu4ovRyAEj6W/vcX4Ay7O1Aok6Z/2InqSRgFYKIiHpoaAsjKX51fNLiDT3Ee52lFFnSjZuG/NJmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731324835; c=relaxed/relaxed;
	bh=s86QEGAEX1dofGFkqEA3dULySjEYCNQcJa+BdzDV/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpCo0PF2fmotOI9OFpMSWc7YLHdxSA5b/5mCCLz3rBPy/FX2vzyfugQRrOD0rhZWsSG/FmvPLTKxejbhPDb7bEv/Y5PfIE6vLa0JZl64baqBOROp38rvIdHkpnlUoU1GnhbzIAZmU5Gxo54gDR4Zagcv87J/iZgqUkU4htrViPtEdavp4njd/9+3eZkgXMPIoQ0Vin4+JuZMBLc9Q7c9rqGTBU62YM25EQZP1VXq0yCO+K4KHGVL/zKWIjeVgas29pDb3JfOkkHWRldcgKjKqcFRQO9u4TJ2wZ2xmgK+cRMrrqOIh1CB1zOmSdF8KA0yt3j43Ges9RM+cToli/QOHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iKZG7oTq; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iKZG7oTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn6rL5lxHz2xrb
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 22:33:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C96B5A41507;
	Mon, 11 Nov 2024 11:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE50C4CECF;
	Mon, 11 Nov 2024 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731324830;
	bh=ykZQH5VbdujAJrOFHP+G49/xP/6A09GupDXNuDZK4fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKZG7oTqQCLuJh+FMFDBetvW8vOirsihp5x4ZVOdurOzqy5XwChse15QgEXeaQzJx
	 r/GnRycfiyEVQCkcIASg2vebK5zFt1KsF3d5vbpu7e5SF45SYYXpW0lR/4vB1ieqCx
	 Z0hdi+Av5K3X2p9lUYWQf+3RNd7v41n4tNm/4Z1yBMtDS6QXajFmSYmc3YtHAzduGS
	 1Esabn8cn9B6Br+RurBiDACQoWsFX0SI4OCROBfv5p0kH9ZHydLc20CGVSBevSgV6S
	 7mlqnj/DnNSTk2qEwvMoblG78qasp5s1wHlpZFgq18qp0QiJWzJ6Tnk1M1gean+4vB
	 LchdL864Tbh0A==
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH v2 0/5] fscache/cachefiles: Some bugfixes
Date: Mon, 11 Nov 2024 12:33:36 +0100
Message-ID: <20241111-helft-lachs-9d6ff31e2549@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=brauner@kernel.org; h=from:subject:message-id; bh=ykZQH5VbdujAJrOFHP+G49/xP/6A09GupDXNuDZK4fc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbvp6+tOSEbuPnvSLHst6msK/KXXFCkbdgf8h3bf8I0 Y4s2WkHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS9oGR4ZHwI+Hse9nPvOf+ vyf7XiR/CU87w9n5+SZaq2cmNVYX32L4w1F+f8XNsx5Pbz1O8LSx+36wQTdeoO6UW1WAZuf2sLW rmAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: Christian Brauner <brauner@kernel.org>, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 07 Nov 2024 19:06:44 +0800, Zizhi Wo wrote:
> Changes since V1[1]:
>  - Removed some incorrect patches.
>  - Modified the description of the first patch.
>  - Modified the fourth patch to move fput out of lock execution.
> 
> Recently, I sent the first version of the patch series. After some
> discussions, I made modifications to a few patches and have now officially
> sent this second version.
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/5] cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
      https://git.kernel.org/vfs/vfs/c/544e429e5bc6
[2/5] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
      https://git.kernel.org/vfs/vfs/c/a89ef3809efd
[3/5] cachefiles: Clean up in cachefiles_commit_tmpfile()
      https://git.kernel.org/vfs/vfs/c/d76293bc8658
[4/5] cachefiles: Fix NULL pointer dereference in object->file
      https://git.kernel.org/vfs/vfs/c/53260e5cb920
[5/5] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
      https://git.kernel.org/vfs/vfs/c/37e1f64cbc1b
