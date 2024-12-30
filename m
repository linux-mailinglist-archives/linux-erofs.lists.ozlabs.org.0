Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E099FE269
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2024 05:34:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1735533256;
	bh=ACCGeKwbm4uh+qjihOfycccfI77tHBwUPlIVkEoZxsE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Lc549bO0NIaiCmqqHE49GAdOueEIukycppKMmPxk8ElQHD5fF0kslqlVmUDoi0iz8
	 FiuEZfbF1p9g02osAseXYHPZcaWvacRWmsq91Um9RSSkDA6arJ/z2Y93szcPpVRdCv
	 SuJCu8RX0h2aA0w49rG6qUz35PaTuu5+VpOO6xFOfe/kle2O8aEJPgL1E+PkK5Chqx
	 C9Swnb1kEfXKHCCNTj+3kgB7IW0PC3IRrNTR0jkK6q4FepF4O/t4hQmxirJUAG2eki
	 NHLj4dlIwnsnDRI8jXdqeY2kse33MnZ7C47vzfL1YFKBMZM6YamxCpHc3suLxom0S1
	 wuo0YsqlOpLVA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YM3CX0CKyz2yvl
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2024 15:34:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735533254;
	cv=none; b=ZUOe0ZYwNz+ri148MFZudVNukRPQiICAQsFiEy97VlDflTbjpgyIJmCisD/1FcAygKzc+sp1lOBE/lB11wnclNsqtifbGvXB8i/5sChOquTyKCn4RAdGbsG1Ulf4UZc+UyPEGxex0+Ob9WxTkr1U0gxslVoH2Tev4f07DpWtaphBMMJDis6vE7/3Irs6Ay24FT7OOqKxl4CX/3yn4c8Jmw+6tblvvDxAQBy867Q/pH7/sO9kxhLZO4Dvg33LtLLAJ3ferDJlWbFaRUhB7TxGlIFCGYls2B0qXvQu4xrdMp3sGxryBJAqFK7vydT9Qneg+7jK6lELJXWPD5MLQRSLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735533254; c=relaxed/relaxed;
	bh=ACCGeKwbm4uh+qjihOfycccfI77tHBwUPlIVkEoZxsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BzKqRqScZ0M0anFgBD+6bj+xEbqi1omaJEHpuojf8FANPrLlzHTN4x2dr1sgZOC7GW/bRBAbWfC1jB9WXBH2/xR2SgAqKquU2iMOJa442Etu4xGv2Re3J4hJv2Y+j3YOFqYu6TImg6oyoeKzOG12Fo+mruInA8/Crx8ihE1za3j6EFyXJ+YUNtBwhCQdVV+nyDvYs59Nofq9C+YUzRJNWpVkSURUK5UI0/El7Ka+LBub1z3toauaRMiVJNRjY2EtkoSyGwIVKcTmXDKDDQetKSKTJFyUh3g9t/bnngCVRnOSjxOTF2AdYdn4qrNgFmRrww5laox9Hr+qkwuwpRu+4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mq7KezHM; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=linkinjeon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mq7KezHM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=linkinjeon@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YM3CT5fJsz2yXY
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2024 15:34:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E0E37A401BE
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2024 04:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24283C4CEDD
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2024 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735533250;
	bh=QmUul2/yJlCxcLFZDPA3lVDNH1+bn6Ooe1jO2ZuG1X0=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=mq7KezHMsSof3c1ImmCvgADrAjbaMN5JNMDfAuGTJzUpj3Kn0vh4Z+XJPCmeJRvgR
	 sVPEfBDkfHXEMG2VrxfyX/8iUPRrIpSRIr6KcUZgwaoR+th9E8FL5Ai/AtJfSsNFyo
	 geF0HD14jb3aMeYP7ep+fWqDZ0+HNlJ0djVMgbOXyt5Op/LRbMb/qp7i9VxlX3EKUR
	 BZG7uCT7v1AV+nIFzUo3pTFjIF34zbU+Ls+uJldM8Fwt/geEXW+LctsUIQdF+OlNtR
	 o/KYeqyzskYxGgvzycx4UVQUByUh79lXm+CG7lCARP/35WnM+WyE9qYNyidXXJhnJD
	 g1hTajcQ9FF+A==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb7edfa42dso4187538b6e.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2024 20:34:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/cmkZJWz2xJElmILgwTdDqABgMSGgP6IAsGOshdB/8h1Np2gUufKnEA/kFEJ8VagUo9SlKCXikHee3g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIJmT1zTcnZdhwHJaWP8YH3d+Rql5bFdz1Q+1hFJ8dMMU3jiK5
	5UUOp2yxSKDXWH5oKt8HrF7X1T3l2J4vHlaZFUyLXlgPBZzmufyRGe3N6OkgQ47oU5gxuTUvgL8
	x/y3wYZJ5yFFlHrwIZRpn++SipVw=
X-Google-Smtp-Source: AGHT+IGPR3Flf5/zEXHZnn7zLrdd5PXMCsBq+h032b8JgurvxU/LtofRzdR28Ik/6G7f7iwV0oe73wHTnG5nZTHtypU=
X-Received: by 2002:a05:6808:2512:b0:3eb:6dd3:12bf with SMTP id
 5614622812f47-3ed8907bc1bmr20910901b6e.28.1735533249411; Sun, 29 Dec 2024
 20:34:09 -0800 (PST)
MIME-Version: 1.0
References: <6770fe12.050a0220.226966.00bb.GAE@google.com> <Z3ILF2ClX4sSA0wd@debian>
In-Reply-To: <Z3ILF2ClX4sSA0wd@debian>
Date: Mon, 30 Dec 2024 13:33:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-wg9dMsv_UgUKVeLCqkFjroh3mBUcywE8mvDcFasjNwA@mail.gmail.com>
Message-ID: <CAKYAXd-wg9dMsv_UgUKVeLCqkFjroh3mBUcywE8mvDcFasjNwA@mail.gmail.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in erofs_fc_fill_super
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, 
	syzbot <syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
From: Namjae Jeon via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Namjae Jeon <linkinjeon@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 30, 2024 at 11:53=E2=80=AFAM Gao Xiang <xiang@kernel.org> wrote=
:
>
> Hi exfat maintainers,
Hi Gao,

We have a patch for this and will send a PR to Linus soon.
Thanks!
>
> On Sat, Dec 28, 2024 at 11:45:22PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D112374c4580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df9048090d7b=
b0d06
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1379ee6b9a14d=
5dacaf2
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/244f25c1a275/d=
isk-9b2ffa61.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0d14fc6634fd/vmli=
nux-9b2ffa61.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cb152a4c0fd2=
/bzImage-9b2ffa61.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com
> >
> > exFAT-fs (loop7): failed to load upcase table (idx : 0x00010000, chksum=
 : 0x1a9973fb, utbl_chksum : 0xe619d30d)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in erofs_read_superblock fs/erofs/super.c:274 =
[inline]
> > BUG: KMSAN: uninit-value in erofs_fc_fill_super+0x66a/0x2520 fs/erofs/s=
uper.c:614
> >  erofs_read_superblock fs/erofs/super.c:274 [inline]
> >  erofs_fc_fill_super+0x66a/0x2520 fs/erofs/super.c:614
> >  vfs_get_super fs/super.c:1280 [inline]
> >  get_tree_nodev+0x183/0x350 fs/super.c:1299
> >  erofs_fc_get_tree+0x34d/0x450 fs/erofs/super.c:721
> >  vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
> >  do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
> >  path_mount+0x742/0x1f10 fs/namespace.c:3834
> >  do_mount fs/namespace.c:3847 [inline]
> >  __do_sys_mount fs/namespace.c:4057 [inline]
> >  __se_sys_mount+0x722/0x810 fs/namespace.c:4034
> >  __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
> >  x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.=
h:166
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was created at:
> >  __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4776
> >  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2269
> >  alloc_pages_noprof mm/mempolicy.c:2348 [inline]
> >  folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2355
> >  filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1009
> >  __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1951
> >  block_write_begin+0x6e/0x2b0 fs/buffer.c:2221
> >  exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
> >  exfat_extend_valid_size fs/exfat/file.c:553 [inline]
> >  exfat_file_write_iter+0x771/0x12a0 fs/exfat/file.c:598
> >  do_iter_readv_writev+0x88a/0xa30
> >  vfs_writev+0x56a/0x14f0 fs/read_write.c:1050
> >  do_pwritev fs/read_write.c:1146 [inline]
> >  __do_sys_pwritev2 fs/read_write.c:1204 [inline]
> >  __se_sys_pwritev2+0x262/0x460 fs/read_write.c:1195
> >  __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1195
> >  x64_sys_call+0x368c/0x3c30 arch/x86/include/generated/asm/syscalls_64.=
h:329
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
>
> Currently, I don't think it's an EROFS issue but since it doesn't have
> a valid reproducer so I don't have an exact idea.
>
> This case is out of EROFS file-backed mount, which seems to read EROFS
> superblock (erofs_read_superblock -> erofs_read_metabuf -> erofs_bread)
> via exfat page cache:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/erofs/super.c?h=3Dv6.13-rc5#n274
>
> But it seems exfat returns an unlocked uptodate page without fully
> initialized data.
>
> I'm not sure if it's a post-EOF read for this specific regular inode,
> but IMHO, at least mmap read allows post-EOF read within the same page,
> so it'd be better to leave the whole page initialized on the exfat side.
>
> I'm not sure if it's related to exfat_extend_valid_size() though.
>
> Thanks,
> Gao Xiang
