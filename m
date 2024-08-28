Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C261F9625EA
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 13:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724844162;
	bh=BLXiieZ22RUqz5tnd6awFZS3axEO2JGwX9GeaYR51I8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BQfr/fITBs4QdBKI2GvU1FB7irNwO39IrxyMOR38+HbQdER7nOxmmczC0ZJGRQ/6w
	 OX1nRQeXy7+YCqFLQ1rRryfHX2LXfzskdO1LaVRXZHggg4zf8rYm7o+5KBRhrnKVV7
	 nKffiYXAmg5h5fogThkHfiFuznHWpSrvAU8n4s5y6bEOuMzJQM4LknTb95SHMa6wH5
	 WCeIIeMcvo7xwpPSiytui+zy68f4o1WK9G2j9I58iIrRkWNDZUU9NfG4IvMzFzsGGe
	 8osycV4Fboo2jDh+nwyV+TAiYNByLNh0AsA1y9WpM2nClvZbbv7Y3r8frjEEbFe9kV
	 8IRkK+wzl7HWw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv2823MQCz2yk3
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 21:22:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=145.40.73.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724844160;
	cv=none; b=i0RSR5uJGoCRIUWxMtyux+NPojBEFxovQoxaikHlUghCUnz5g811OcrJvWd9u6TY4NLTqwptu4+X4NLARt0HX62AzjhwI985vjeGWdBB+a50FAU6l69ubxjqDI5+NgSJCQrp50hvgB4rMBAH+Gg82Y/fnvCPwhvgQ6dutGNB7KUOydyOoS7FUF9iSvos2XZuy8RFvffUNII1TceRDBIW8cl9Q/bbiqBmOHBncYBPJ+c/Cnv75IAu8MnzLSsyY8CFcxJu3lgB4GnYPly5dg1ZoGe1fPSidA/QQUibpk9a7+MEuNi9dl69tKj2WuU4/nwMwMTF2lJOVaABOu5g3VSUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724844160; c=relaxed/relaxed;
	bh=BLXiieZ22RUqz5tnd6awFZS3axEO2JGwX9GeaYR51I8=;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=J3vRcRXJBvk0WDLq6GGv8TS6WhRxwZnD6mB+zINxOQxvFcZEnnZTa7P6K1F2VAwWNfbJ1q6pAQ243hZS72Uvm2GKCA2PF3Hv7sQ/daWN+p9uncqkfUfx0WzIwjsqTnpZ2ohccoD0/p1KiKO2tuS54V2X6nWl0sbSUXWDupXyqoPh4KMVM9u8z2K886p4QkYS1tS9u9etidp/e2m2PgbxtrkylH2AUgn160ZhN7m6XyersBprZhhd9wHzV2sEnbJSMD8x+cOhmwRR0jkLOAN+9ojY8gjfeCTVWKGAqzeuGnb0FJQDJXFTKaRRvZZa88yLbbCbZHWumDf6j/4kQp991w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CnksQoqo; dkim-atps=neutral; spf=pass (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CnksQoqo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv2800kqNz2xsH
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 21:22:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BD6D4CE1340;
	Wed, 28 Aug 2024 11:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3164AC98EC1;
	Wed, 28 Aug 2024 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724844157;
	bh=Nf3PEb3R2fEBVAcqaU+NbEMYg0L6+wEFWBzFvK14wyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnksQoqoxVFIKKsZi0byoMoAlvfMilDr9GmU3TSdrR57167Ow0qcTcOBIwCBpiEiF
	 9A5RVEWTfgtnYs2iehI43J2kFfJtBS/TtIS862NDTN+2JE2R+cM1Kb6yGHuEUh1oIg
	 jVdhJBw1rO7fc0n8zuqaLsggnHa8JajsE1vzY9du9y3EEnqJ4ZqE0HRbmuvKHFBq+y
	 OYssINTq1TTl8zzHUx02vK9gWvdvaA0AHrA7gTYIii8fWVZsVdHOrNT5BbndKD5k17
	 RFVkHMwJiY+n7CFkjc8bok6sb7NmP3E6Mm+49dN8Kx2mTA3z+LtD+76+sFoSMGSG1E
	 wUrew8yfxFgBg==
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
Date: Wed, 28 Aug 2024 13:22:25 +0200
Message-ID: <20240828-fuhren-platzen-fc6210881103@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826113404.3214786-1-libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=brauner@kernel.org; h=from:subject:message-id; bh=Nf3PEb3R2fEBVAcqaU+NbEMYg0L6+wEFWBzFvK14wyk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSd5yj+XHu7QM5zVi/D7FsC/Qyf+y9GKRm3KrjPrIutv Lme48ftjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkiTEyTEn+oXj92MfjrwUr pv1YM5Mn7ZDOv4Lsd/FtT7nFrvDF3WJkeKOWkj2/ae92kcK+YOc572qO/CuuM7y5rFjuQ1LzpMX crAA=
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org, stable@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 26 Aug 2024 19:34:04 +0800, libaokun@huaweicloud.com wrote:
> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> deleting its subtree. This triggers the following WARNING:
> 
> ==================================================================
> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
> Modules linked in: netfs(-)
> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> RIP: 0010:remove_proc_entry+0x160/0x1c0
> Call Trace:
>  <TASK>
>  netfs_exit+0x12/0x620 [netfs]
>  __do_sys_delete_module.isra.0+0x14c/0x2e0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
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

[1/1] netfs: Delete subtree of 'fs/netfs' when netfs module exits
      https://git.kernel.org/vfs/vfs/c/0aef59b3eabb
