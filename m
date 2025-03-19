Return-Path: <linux-erofs+bounces-96-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C0A68D69
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 14:06:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHprV70Rfz2yvk;
	Thu, 20 Mar 2025 00:06:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742389610;
	cv=none; b=NF3SpMqWpWpUCGYMDmCE/IeUkba7TjV+de2DRgky0+n3CjJCWxmPoBOgDiCNjKbHsKNfeRyK9Y8n6qnG+7m5mV/uTzZHhurBpHGVdVhH86JCyrvTaVnggLR7L6Xa8Kyyk3jmKYtBzoMdNZKihH1Tmr8GpA5OmqkWtDMEZTKusU3FYI8MeXstPhCFjukhNTmhBG1WUtYJVf/QA5FLZOVXN0/EOp4GihIDbXgj3YPKxuE46f6eoDt5+am6eor3CeHybuXo63UDgDkdUnuW7QwwRRr86IaJy3xREkYg6IQUcuvoKW38xV5vKWInR14fqwo/ISovfGSJcDFAtFuKc6bWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742389610; c=relaxed/relaxed;
	bh=L3LddFcjzTlySf3v6njf68tEY/h4KIH6w83IHDWuQYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns3SC6kIEGIw6gRuoU1gVDiHda8D8pV1MuAHBFaF2vQFxqZYSYTjl94sjSWFJ2gqyWV/BgWD660njn5J5HOrEUibYcSThjP0zsgR62faMJulxxtFWNZSchgNlJrwJWVtN0k4MCmjHKpx+bjfodKFwMUQQ8l6Q8BobLHkO8kTzSfNGGxLtnon6UgGxwVwx2m5a60jXtjhUSZkHMzxetB8jY5Rs9Fugn8q+37HwdDWrbUMKariDGhF5QBBQpWuqT0S1fJNsenAE/xfMuFBUooVPR/hEhFX36lC3H7Dln7hKnup3S/2Ck3+5/+ZquliohFcjw7FZoqmjCaaN1YV7uf3hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TeaWphTC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TeaWphTC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHprT6jDfz2xd4
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Mar 2025 00:06:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 719966812E;
	Wed, 19 Mar 2025 13:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D71DC4CEE9;
	Wed, 19 Mar 2025 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742389604;
	bh=CPww1TQSDOLLkdBO3ROjU7WbbIGpj/GzEovD+pZ6Q/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeaWphTCO0hr+ok2QjxTNhxgfePARWtf9TuyJZQEVIe6hXxtxIokPSTDxk8eq4DCo
	 yFZYp7MUl8fcTZeK1arE5+JzMsAGKtZqnGAgRw2Oh/dAoGoCip9sT2rGYNq9MfLpIq
	 11+nSz/eeJBXezrpNTDpENxhv5RxQQ53ih/eaLOre47239157mpAtRI26zJcwEC+ud
	 zuansiYlwjpwVBiSNPRzhuWExkfXc4ptEBV+fv0amHB+STr7qD1iNMhipKO9fjH9g8
	 cAXUB9T21FRo4FDa2kb+MBeEjGyMBYrrTeRpxNd3Veo9GfhDTLaa6U+CmpAl3b1VOY
	 nv0GVFD/Wl25g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>,
	Gao Xiang <xiang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
Date: Wed, 19 Mar 2025 14:06:37 +0100
Message-ID: <20250319-daten-dissens-4cac8b38fea2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=brauner@kernel.org; h=from:subject:message-id; bh=CPww1TQSDOLLkdBO3ROjU7WbbIGpj/GzEovD+pZ6Q/M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfOhjXUHnz/V+W6OBn5S2BfNz7NFLcyq7sL2Q5tvv6j t0nV3Tkd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE1Zrhf2l0fF+dzO0ngZk5 CpVMk1f4Huh9uGxF3oQpcVEZnJH3khn+e8bcSM6eHTtZv7xnz0ZBZ9VPSWFnoqWNdygrh2+xlyt nBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, 19 Mar 2025 16:51:25 +0800, Gao Xiang wrote:
> Previously, iomap_readpage_iter() returning 0 would break out of the
> loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
> relies on.
> 
> However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
> buffered read") changes this behavior without calling
> iomap_iter_advance(), which causes EROFS to get stuck in
> iomap_readpage_iter().
> 
> [...]

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[1/1] iomap: fix inline data on buffered read
      https://git.kernel.org/vfs/vfs/c/b26816b4e320

