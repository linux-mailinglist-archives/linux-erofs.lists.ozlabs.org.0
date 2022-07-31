Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E75861DA
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 00:42:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lwx8V4BLZz2y2D
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 08:42:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aIKBJ2kz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aIKBJ2kz;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lwx8Q4F4gz2xGW
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Aug 2022 08:42:14 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2164EB80D8E;
	Sun, 31 Jul 2022 22:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A980BC433D6;
	Sun, 31 Jul 2022 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659307328;
	bh=qP5eooVDnvm8UkEaZMLZ7aYDqktRjtGMMBcdl6LyKyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIKBJ2kz8f8Srib0hMRiw9T5up1jU8tLyqXAxtM3i6xsH4YeyWm452ZOkE5/H3hSA
	 xbF9jBHDcpZUcIclYII706azHIxnk1WEyw/ugPgg060rYQP8icCtx1aYjvrGwxRZeL
	 tsmOG2Chk+0rMuA52NX9XkxDDND461vHKQPLNF3VxhRD4MH/QjqlDDh3nNOmwdF8pk
	 vmz5sBeEeAThv3yqkEjAZQOZdPP8aZZfayw8wHflWN/nxxZhByKcKVb3myDjbFZpOm
	 p6sovAh8Oz3qNAlfxu0bmMgfmLQicEi43cSlpOTGqOLmBRVf7Bky5BMyvqEW4tjJV9
	 6GoJJ2Vu6sOfA==
Date: Mon, 1 Aug 2022 06:42:04 +0800
From: Gao Xiang <xiang@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs/erofs: silence erofs_probe()
Message-ID: <YucFPMzXUAtW4w9f@debian>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Simon Glass <sjg@chromium.org>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	linux-erofs@lists.ozlabs.org
References: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2mXuT5w5SKSeBnzUvBFvtwfmYqjZGWGutPiJ+4-fi_sg@mail.gmail.com>
 <2d3db77a-66d1-8bac-dc53-30d322e6784f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d3db77a-66d1-8bac-dc53-30d322e6784f@canonical.com>
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
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jul 31, 2022 at 10:53:52PM +0200, Heinrich Schuchardt wrote:
> 
> 
> On 7/31/22 20:41, Simon Glass wrote:
> > On Sun, 31 Jul 2022 at 03:10, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > > 
> > > fs_set_blk_dev() probes all file-systems until it finds one that matches
> > > the volume. We do not expect any console output for non-matching
> > > file-systems.
> > > 
> > > Convert error messages in erofs_read_superblock() to debug output.
> > > 
> > > Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   fs/erofs/super.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > 
> > > 
> > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > index 4cca322b9e..095754dc28 100644
> > > --- a/fs/erofs/super.c
> > > +++ b/fs/erofs/super.c
> > > @@ -65,14 +65,14 @@ int erofs_read_superblock(void)
> > > 
> > >          ret = erofs_blk_read(data, 0, 1);
> > >          if (ret < 0) {
> > > -               erofs_err("cannot read erofs superblock: %d", ret);
> > > +               erofs_dbg("cannot read erofs superblock: %d", ret);
> > >                  return -EIO;
> > >          }
> > >          dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
> > > 
> > >          ret = -EINVAL;
> > >          if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
> > > -               erofs_err("cannot find valid erofs superblock");
> > > +               erofs_dbg("cannot find valid erofs superblock");
> > >                  return ret;
> > >          }
> > 
> > > @@ -81,7 +81,7 @@ int erofs_read_superblock(void)
> > >          blkszbits = dsb->blkszbits;
> > >          /* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
> > >          if (blkszbits != LOG_BLOCK_SIZE) {
> > > -               erofs_err("blksize %u isn't supported on this platform",
> > > +               erofs_dbg("blksize %u isn't supported on this platform",
> > >                            1 << blkszbits);
> > 
> > Does this message appear in normal scanning, or is it a genuine error?
> 
> The erofs driver on Linux only supports LOG_BLOCK_SIZE == 12. So if we see
> this message we don't have a valid erofs file system.
> 
> @linux-erofs:
> 
> The Linux driver requires EROFS_BLKSIZ == PAGE_SIZE == 4096.
> The page size on arm64 can be 4 KiB, 16 KiB, or 64 KiB.
> The page size on amd64 can be 4 KiB, 2 MiB or 4 MiB.
> Requiring EROFS_BLKSIZ == PAGE_SIZE is obviously a restriction that should
> be lifted.

Yeah, EROFS doesn't support EROFS_BLKSIZ != PAGE_SIZE explicitly for now,
please help error out this message. Thanks!

Thanks,
Gao Xiang

> 
> Best regards
> 
> Heinrich
