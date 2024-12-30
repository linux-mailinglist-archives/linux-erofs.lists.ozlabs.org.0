Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982429FE215
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2024 03:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1735527203;
	bh=WDAkKZXgZ5WE2BvxAr2caCwoiXmIrq4mEYt9vI0pzFk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=E59M+7/nshmRvm/sn8VTZ3hOYtRAYYGpHT6sq9GOhCgIg55HzLsDF+ynHd+lgFZOp
	 Cks7HNCIUuqePgNv7GP29p0RGcoxeXcrSkgV34iApP4nSq/NhI7jWkTYsC1RXnfV4U
	 UyZo8kj/h9axmnL24JTEI17SnqA3B4aOoXoblMa2bWJ36mWSe/dL2/z2lFuTgIZEQ2
	 U+Y4V+5Py12zhh7ErwG4ibQ26junpKZRqumPvqaVegYV3EM4xUG8CSt9mnbj3pnxLy
	 VhdOKaHQ5o3I6V/SQZRM8IWeaTdHBTQf/F9f6U79WIIXLlf0/3Uknru8PXy+kurp9N
	 1IHaHc3ThxutQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YM0z76VDtz2yvh
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2024 13:53:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735527201;
	cv=none; b=UgODM6f3Jm5rCERWcwpxbgYOXhaR81KSjuo4LU4Mw32G205hxp8XIaolJB+Ob0BAVqC/gsqgib50aEGqBzkBlEkpxMTuHyCxOHCSEPdNYwPYuvlHIUeeH1sV3MPMN/EDUQcR3xHJlT37Z2q3ffTrVYZcVuwodzR6leBNZDd4zWadwNEV6gJHRBiPHYbJHJdY4DgVq1RPGDa60rdCuqsSGjc/PEN82xoNsnVvffmNfZG3W7SA1BBdYLcq4ii09nL6Vx+Zaz8o9HfY5+KKAqCMHHTRwyDY14nntgDN3rNStUF/RTTXTclM5WPeS5zKEUsGsvsrzuZn2856sIkM4WFJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735527201; c=relaxed/relaxed;
	bh=WDAkKZXgZ5WE2BvxAr2caCwoiXmIrq4mEYt9vI0pzFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc85inKnemDdeSFNdTciMsgUR2DUQDow5WozVPreYmH5xkOMzzPmid0sOxZhd9InoaH579EUFLnALy7eVWqPo+QnrBRMlRfsib5BFQYfPhKg1td0ZksUT5L9PqB8NftQmHDOJlpgF0kq+TbeXriF7s4Bmkt8B/BiXfF1X4dgqMrKHobktl5wHp4Ml7l6aHMDfCxn4GdzAkvUSLCwhYXXKpLoW+//dAfdbknogVyk31qKJxnojrGa64IlotikYUfOirrrtjcqe4ccLbHeSBquywwODV3WWtVxToZZAIhDqBu0P42DP1X/FQLGa/FG/XW05IBDcK3tBOWxYyhDAUNdiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tdlLUjgL; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tdlLUjgL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YM0z44nvNz2xt7
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2024 13:53:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DFD235C10BD;
	Mon, 30 Dec 2024 02:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE25C4CED1;
	Mon, 30 Dec 2024 02:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735527197;
	bh=5T9teM4X9U6CZgzJeAePaUsIgwgB+c9qSGbOu6Aqdas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdlLUjgLD0d+pYeUHApaM9XfKCRQydFKAGETmR5KTsbUl8yBl/jfXqdb+9T4gO5/6
	 DHk5eHRi0sSBwb/eUt2UMY4zilp73rHSW/LAHhRBLjdOIcZUPnR/NFgKg4KUMPGoO7
	 cVH0JSaqTl/S3Q2GvqfnXsOr048iHo096Uo5xxB706BcyZ3b2vkOR3Lx+0v1QEWDHB
	 KZvAauIleTO7vrVWOAkhWqvY/jtqo+3HVdoS9Y3/rW3Bhk2Cs+Bs2PC8B2vsZVS3Ks
	 Wo/jk7Ugo3ifDbOwDCNhpnziFWwWpjfU/G5aqbYZ1CohJBAsZjjEVZmtLyxzr+YNLe
	 QNpOMUIx5bHUg==
Date: Mon, 30 Dec 2024 10:53:11 +0800
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	syzbot <syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in erofs_fc_fill_super
Message-ID: <Z3ILF2ClX4sSA0wd@debian>
Mail-Followup-To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	syzbot <syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
References: <6770fe12.050a0220.226966.00bb.GAE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6770fe12.050a0220.226966.00bb.GAE@google.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi exfat maintainers,

On Sat, Dec 28, 2024 at 11:45:22PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=112374c4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9048090d7bb0d06
> dashboard link: https://syzkaller.appspot.com/bug?extid=1379ee6b9a14d5dacaf2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/244f25c1a275/disk-9b2ffa61.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0d14fc6634fd/vmlinux-9b2ffa61.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cb152a4c0fd2/bzImage-9b2ffa61.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com
> 
> exFAT-fs (loop7): failed to load upcase table (idx : 0x00010000, chksum : 0x1a9973fb, utbl_chksum : 0xe619d30d)
> =====================================================
> BUG: KMSAN: uninit-value in erofs_read_superblock fs/erofs/super.c:274 [inline]
> BUG: KMSAN: uninit-value in erofs_fc_fill_super+0x66a/0x2520 fs/erofs/super.c:614
>  erofs_read_superblock fs/erofs/super.c:274 [inline]
>  erofs_fc_fill_super+0x66a/0x2520 fs/erofs/super.c:614
>  vfs_get_super fs/super.c:1280 [inline]
>  get_tree_nodev+0x183/0x350 fs/super.c:1299
>  erofs_fc_get_tree+0x34d/0x450 fs/erofs/super.c:721
>  vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
>  path_mount+0x742/0x1f10 fs/namespace.c:3834
>  do_mount fs/namespace.c:3847 [inline]
>  __do_sys_mount fs/namespace.c:4057 [inline]
>  __se_sys_mount+0x722/0x810 fs/namespace.c:4034
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
>  x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4776
>  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2269
>  alloc_pages_noprof mm/mempolicy.c:2348 [inline]
>  folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2355
>  filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1009
>  __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1951
>  block_write_begin+0x6e/0x2b0 fs/buffer.c:2221
>  exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
>  exfat_extend_valid_size fs/exfat/file.c:553 [inline]
>  exfat_file_write_iter+0x771/0x12a0 fs/exfat/file.c:598
>  do_iter_readv_writev+0x88a/0xa30
>  vfs_writev+0x56a/0x14f0 fs/read_write.c:1050
>  do_pwritev fs/read_write.c:1146 [inline]
>  __do_sys_pwritev2 fs/read_write.c:1204 [inline]
>  __se_sys_pwritev2+0x262/0x460 fs/read_write.c:1195
>  __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1195
>  x64_sys_call+0x368c/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:329
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>

Currently, I don't think it's an EROFS issue but since it doesn't have
a valid reproducer so I don't have an exact idea.

This case is out of EROFS file-backed mount, which seems to read EROFS
superblock (erofs_read_superblock -> erofs_read_metabuf -> erofs_bread)
via exfat page cache:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/super.c?h=v6.13-rc5#n274

But it seems exfat returns an unlocked uptodate page without fully
initialized data.

I'm not sure if it's a post-EOF read for this specific regular inode,
but IMHO, at least mmap read allows post-EOF read within the same page,
so it'd be better to leave the whole page initialized on the exfat side.

I'm not sure if it's related to exfat_extend_valid_size() though.

Thanks,
Gao Xiang
