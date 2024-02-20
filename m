Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E085B5BB
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 09:47:13 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XcBcYY5I;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfChH3J6vz3cCx
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 19:47:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XcBcYY5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfCh90LTlz3c12
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 19:47:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 10AF3CE18E4;
	Tue, 20 Feb 2024 08:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086BC433C7;
	Tue, 20 Feb 2024 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418820;
	bh=GZ+HcFFNIzj0fwynEx3VW22XthB/JF29Bnq/DjlKiCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcBcYY5IgpVk3q4imoW0XKzb7mrMtt9TcenPFnl0dHvFc+JSDIGyIshkMRYvW9ryP
	 HSbgN7UYyJbzpRFj0hytz83QXfN3DWERvWR9B1/I0LHn8VxD+lcr/HrF1B0GdnV9GJ
	 dUEwe2bWRpegbYDqjrLCRls6A/p/VWNE65OoGtc49j1/WJAad3PaVW0ACAeyUTSckJ
	 lwsO4+cU7Ggp6ht3N37JN/OzXvqJEjEu67RVrgofo+6yrDvYI35tW19+uI6GRyhqt/
	 aJWUTjVcmqB20VE9u6o6VV9KbjS6WEyeNaO37cLjkRFkaU88HrDxSkVvltc1vYRR9L
	 MawQCvi5G96cA==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	dhowells@redhat.com
Subject: Re: [PATCH RESEND] cachefiles: fix memory leak in cachefiles_add_cache()
Date: Tue, 20 Feb 2024 09:46:28 +0100
Message-ID: <20240220-lasst-hemden-8ab6d7d2e9ee@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217081431.796809-1-libaokun1@huawei.com>
References: <20240217081431.796809-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=brauner@kernel.org; h=from:subject:message-id; bh=GZ+HcFFNIzj0fwynEx3VW22XthB/JF29Bnq/DjlKiCM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReSftzfxlfFb/gguUSEwRX+NxMdpaN2+MmY367w4WDf xKfl+n9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIko7GRkuOhnJjtRN+W609ft Z2amV0QXZfxvVEst8RZ8G/f6lmCbOiPDs00/RMO7///JEuPMfFB8t/4Kn3zquytd/AGxd/RfKP7 hBgA=
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
Cc: Christian Brauner <brauner@kernel.org>, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 17 Feb 2024 16:14:31 +0800, Baokun Li wrote:
> The following memory leak was reported after unbinding /dev/cachefiles:
> 
> ==================================================================
> unreferenced object 0xffff9b674176e3c0 (size 192):
>   comm "cachefilesd2", pid 680, jiffies 4294881224
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ea38a44b):
>     [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
>     [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
>     [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
>     [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
>     [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
>     [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
>     [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
>     [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
>     [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> ==================================================================
> 
> [...]

Sorry for the delay, David.

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

[1/1] cachefiles: fix memory leak in cachefiles_add_cache()
      https://git.kernel.org/vfs/vfs/c/e21a2f17566c
