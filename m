Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7183545A
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jan 2024 04:34:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rMvLjE2S;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4THf8v400Bz3bdV
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jan 2024 14:34:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rMvLjE2S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4THf8l4Qvwz3039
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jan 2024 14:33:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C3747CE1F22;
	Sun, 21 Jan 2024 03:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445AFC433C7;
	Sun, 21 Jan 2024 03:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705808034;
	bh=pI1s/Ka3kG7XYfRDmlxT9WKVFIV+mrPPJNCP7A6gH6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMvLjE2SKkmIEM8lveHRqqWIV+ckdHhx+37sU7Kg5mWKGCgj+Wn62/Lk07NUScYcL
	 u7MJHyXYMWCkxHbkUaZQpZe6ye1rrD+E2wV0oj2XbaaOk77mX7vXL0Hy41wt8PhZ2X
	 XY0sY8Ez6ZX6Lj5PwS9BOZqOiABkue8D07r7IFqNTv/xlsRnOP5wmol+H8CmaWawTd
	 Lnn4fma/LTyJnDClSJzgaaPaIY0rWboerlbeL1RtlRImqrnHh01hxXDivzslF5egqq
	 2CDKWYPYrqhwEwDfHDtHfWgfwnrq65QtGhwcJ2dJ3US3TRIPkiej8VgrWeAKLq9P5t
	 9SRK3lmCuFGxg==
Date: Sun, 21 Jan 2024 11:33:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH] erofs-utils: introduce GitHub Actions CI
Message-ID: <ZayQnZ9dI3CUhnSe@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	linux-erofs@lists.ozlabs.org
References: <20240120152557.178210-1-zhaoyifan@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240120152557.178210-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yifan,

On Sat, Jan 20, 2024 at 11:25:57PM +0800, Yifan Zhao wrote:
> This commit introduces a new CI workflow configuration designed to
> automate the testing process for erofs-utils. This CI is based on the
> free GitHub Actions for we have a fork in GitHub. The CI will be
> triggered on every push to the {main,dev,experimental} branch.
> 
> Currently, we have only a simple test for ensuring the correctness of
> mkfs.erofs, which covers a small subset of its extended options
> including dedupe, fragments, ztailpacking and {lz4,lz4hc,deflate}
> compression algorithms. It creates a EROFS image using Linux v6.7 source
> code as the workload, then extracts it using fsck.erofs and compares the
> sha256sum of the extracted files with the original ones.

Personally, I tend to avoid relying on any Github infrastructure for
the erofs-utils codebase.  Previously it already checked enwik8
correctness in the Github CI, see:
https://github.com/erofs/erofsnightly/blob/main/.github/workflows/smoking.yml#L185

If you would like to add a Github CI for Linux codebase, please
update
https://github.com/erofs/erofsnightly/actions

nightly CI instead.

Thanks,
Gao Xiang

> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
