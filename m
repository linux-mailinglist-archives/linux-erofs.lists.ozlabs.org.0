Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68579833358
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 10:26:48 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XKYGsYdN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4THB2F2yWlz3bw2
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 20:26:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XKYGsYdN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4THB263Hr2z30fn
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jan 2024 20:26:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C022FB81D01;
	Sat, 20 Jan 2024 09:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D522EC433C7;
	Sat, 20 Jan 2024 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705742793;
	bh=rAW9sl5sPTwTS/+xYfIGzYEKqJlytDg1k1bYk/am8yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKYGsYdNjf8ovy/gtYzcmhiP+veg+ejoOQVEv8d3RR2oEQtgWozS+5Yk7iFWNQvRb
	 1Y3AFwzbSeDqYnq/uUGL+mOih8Oexoj+wqzUIy/fd8JVlQtiHGez/n0XCaDs/3ep9H
	 B4e6pBm4dvZBkN2oCbRGxe3MLt+AXstxza3YDYfSfNsidYQ13hfDacS4sK9fTZmxaY
	 2yWmFM/gh0t/iHiXFHw9omooUuXtOLnJ8E5HOjMSv+Uie534zz4Z2NGG1hXcLPIDSp
	 iRZfPLOtPIZFQRUpDZTcrm5qzcfcFfZDxU3ZWYvNsn9zEAMeGqhabrgqQmaDwwYQcx
	 FSwGaJw/DvAGA==
Date: Sat, 20 Jan 2024 17:26:29 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH v3 2/3] erofs-utils: mkfs: allow to specify dictionary
 size for compression algorithms
Message-ID: <ZauRxYhEXm+gMYap@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	linux-erofs@lists.ozlabs.org
References: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
 <20240119124655.62850-1-zhaoyifan@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240119124655.62850-1-zhaoyifan@sjtu.edu.cn>
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

On Fri, Jan 19, 2024 at 08:46:55PM +0800, Yifan Zhao wrote:
> Currently, the dictionary size for compression algorithms is fixed. This
> patch allows to specify different ones with new -zX,dictsize=<dictsize>
> options.
> 
> This patch also changes the way to specify compression levels. Now, the
> compression level is specified with -zX,level=<level> options and could
> be specified together with dictsize. The old -zX,<level> form is still
> supported for compatibility.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

I cannot apply this patch.  The error message shows as below:

Applying: erofs-utils: mkfs: merge erofs_compressor_setlevel() into
erofs_compressor_init()
Applying: erofs-utils: mkfs: allow to specify dictionary size for
compression algorithms
Using index info to reconstruct a base tree...
error: patch failed: lib/compressor_liblzma.c:68
error: lib/compressor_liblzma.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0002 erofs-utils: mkfs: allow to specify dictionary size
for compression algorithms
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Did you use the proper branch (the latest -dev) to form patches?

Thanks,
Gao Xiang
