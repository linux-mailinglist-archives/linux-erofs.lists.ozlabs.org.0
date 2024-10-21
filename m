Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8FA9A6889
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 14:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729513963;
	bh=zn6eDDRuYV65hjpD0kxbNg54IDdzr7i3MJ4tHyk41/U=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gvhOsR/WG6cvAWp3jgLMAJG+96quqG8mfhJ7DPrRmW9Sco/5+vnYjkHATSFDpRSs5
	 X+hpmZlp+JkbNUzCrr3GYlAHSC50gdODfMannV7XlLkQ8ohT/xIMl4S503IUjdXe6P
	 bLtAqX4QICUIEhYijuw3dZEv4hb7z8nTt/G24sa/qb1BfxocomKSzCV9/6VxMDGXjv
	 jKt8Q/h3eEfmwCgDxsbaJavCA4lBj+Ll9OAZUnWp2kcw+DjUa09I4T2tT/19Kpn1Yx
	 JJlhykMZMKjtOEeo1EgT5B32O7N7wjnaOXkJblqEOVrCYYD0+f2Kks6Cog1g55aZHL
	 4EIrhqPZElEYQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXF7v4n8mz2yhD
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 23:32:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729513961;
	cv=none; b=BSk49yffN04kunli/Q4C6g0dE3m/jA1+sv1BhqG4DF42F0PhwGUFhrgq+Bb7OCXtN6um/kX1dLzQRWVpNEQfbSNbKpkEyiMdSW9d9X6w9AMbBCZWyegrer72H47A2pxC5WjlsQXQEHmFGFC4TDqKJDXysce+4YRW3geMZR3mBTx6hxhU/VM3KTsABL46Vt8X7xHsgmP3373uY7zHypm5nPDBsqijQzpBfMsNdJ5wVpziz+yPkQix3HqXwSMET+Hk+hL102GNcANQx+nj7bSJIKvskPAfh+qcRLjm40v540lvZRIMD0CzVwJeQS3N9S9NvgVV0whQHllTRKsQkmGQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729513961; c=relaxed/relaxed;
	bh=zn6eDDRuYV65hjpD0kxbNg54IDdzr7i3MJ4tHyk41/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoWAo7HV0mYyvIKzwjxsJbU6zZf3PHAIxBWgXqz2any/Sb/+3w7WRqYKGd+ET1GligK7Deql1qsxe0Vh0x+lE33/YUnP6pqxKoPzXCU1CKIJHRiCXvA7apVidagvg1V3+LZ5/Z4Yi4LSZTXr78+sa0Kq9+A1Ss/ZE4ysBS3Ht2xzWxX+qnPavWD/CtEK4VNKoWlKLB23LPSGBHFYAHkjVcOE6j0QliO10g4Bl8DSn8BuiIdb5h5KvsEISJ6DcY4kHerDRW3Yg8Os9MAOduBH8Y93l/HIgp7n2hVdOkEMTT19BLGxnLNE03c2LsdUEI9LLlD4LF3fibpHnhDkTbOCOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OMRb3CJb; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OMRb3CJb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXF7s01RZz2xBK
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2024 23:32:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CAA63A429DA;
	Mon, 21 Oct 2024 12:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A68C4CEC3;
	Mon, 21 Oct 2024 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513956;
	bh=DVCh3iNw6uYypy5M+ZmLHYym9XosXi9ik8C+JBoUxs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMRb3CJbsVB5FZhUyX7AOdeCDOUsx0HODnJp64JvMdx85P3rcjiQZHgS+3/Z2K+TW
	 dfpC/QpPYmeHHfTPWeY/FKuduAkEk5svXCyTNbNLyDEOgwjdDcMYDILilS+SWdu/FE
	 /vnVtlAKb7VixXBJAPxXTprJ8AyoShCTiDfRxjX8Xv5rIi4Q+efm6qT28m5kTQqJXb
	 9z6is7DjXHCEJDUVsxQxLQYbnR4tUo+V4T1gJreuwN787sKfgykvotf7LrM7PTHLN7
	 VOAmekzhIMsvjhMgdCF/IqTYgOBmdzBPGyJTy9ANQ4jNDFjg/Qx32SRzLaSYpXQOn1
	 DxnOXjFOCZTCQ==
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Date: Mon, 21 Oct 2024 14:32:29 +0200
Message-ID: <20241021-gesagt-abverlangen-b9ad11ca0e9e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=brauner@kernel.org; h=from:subject:message-id; bh=DVCh3iNw6uYypy5M+ZmLHYym9XosXi9ik8C+JBoUxs0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLed7d5DRNM+1o6qydGjovDrYvVzpXe9h47kKO1MkLy wVCdCY0dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkfzfDP41Lm94vbNkdYff2 qxrL6Ut/6pqEdzDFqacq/pDTDdixV5CR4YCBMUuuH3dE33mrEsPTHI5xUbufe/3f+lVlZwz/3dO hXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

[1/2] fs/super.c: introduce get_tree_bdev_flags()
      https://git.kernel.org/vfs/vfs/c/4021e685139d
[2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
      https://git.kernel.org/vfs/vfs/c/14c2d97265ea
