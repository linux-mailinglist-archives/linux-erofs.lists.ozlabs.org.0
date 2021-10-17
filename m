Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDE2430668
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 06:15:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HX6BD2cJYz305W
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 15:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ORruOso8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ORruOso8; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HX6B52blLz2yb3
 for <linux-erofs@lists.ozlabs.org>; Sun, 17 Oct 2021 15:15:41 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8887F610A0;
 Sun, 17 Oct 2021 04:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634444138;
 bh=pKxvgVEQh6nPXE3KouFVii5ZJrecn76Uar2vKaqSiVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ORruOso8tYta601ws415lLojyfk+remhGm5sxHwFwoKSzbH5VBGehGeR5lClinos4
 A1sh/pA+JjFrElNluYBdY1xQUfU4CU7wZ46PTs/BL9OMEwUlrkLmuuTM2rg1927j+N
 4E/6DKUyxDb5v2ZWAY+8xdZLj1K2+nTtEMQUSvUSH7VhH5d/BcmV44l5UHrmvtso2T
 xRJKJtTtjcJoTRT1e4suAfuGqaru4vKZbLyiWGyjz8Udj91h11JTNki+Bc575ZvZpQ
 ym1ZeXXCMyPAtFjssQOlUz4el9nVGHoi2ZI+Hmkna0dgKzTO9BmLY8XHssIQtO/6IC
 VLej+xE16iFWw==
Date: Sun, 17 Oct 2021 12:15:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v6 2/2] erofs: add multiple device support
Message-ID: <20211017041523.GA15116@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Chao Yu <chao@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
 Yan Song <imeoer@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
References: <20211010063345.28183-1-xiang@kernel.org>
 <20211014081010.43485-1-hsiangkao@linux.alibaba.com>
 <b5f8c41f-d781-a9d2-6ee1-77f2692f9461@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5f8c41f-d781-a9d2-6ee1-77f2692f9461@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Changwei Ge <chge@linux.alibaba.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Sun, Oct 17, 2021 at 10:10:15AM +0800, Chao Yu wrote:
> On 2021/10/14 16:10, Gao Xiang wrote:
> > In order to support multi-layer container images, add multiple
> > device feature to EROFS. Two ways are available to use for now:
> > 
> >   - Devices can be mapped into 32-bit global block address space;
> >   - Device ID can be specified with the chunk indexes format.
> > 
> > Note that it assumes no extent would cross device boundary and mkfs
> > should take care of it seriously.
> > 
> > In the future, a dedicated device manager could be introduced then
> > thus extra devices can be automatically scanned by UUID as well.
> > 
> > Cc: Chao Yu <chao@kernel.org>
> > Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > changes since v5:
> >   - update the outdated comment of on-disk device id;
> >   - add some description about device_id_mask: which is calculated by
> >     using valid bits of extra_devices + 1. Thus the rest bits can be
> >     used for userdata to record extra information.
> > 
> >   Documentation/filesystems/erofs.rst |  12 ++-
> >   fs/erofs/Kconfig                    |  24 +++--
> >   fs/erofs/data.c                     |  73 ++++++++++---
> >   fs/erofs/erofs_fs.h                 |  22 +++-
> >   fs/erofs/internal.h                 |  35 ++++++-
> >   fs/erofs/super.c                    | 156 ++++++++++++++++++++++++++--
> >   fs/erofs/zdata.c                    |  20 +++-
> >   7 files changed, 296 insertions(+), 46 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> > index b97579b7d8fb..01df283c7d04 100644
> > --- a/Documentation/filesystems/erofs.rst
> > +++ b/Documentation/filesystems/erofs.rst
> > @@ -19,9 +19,10 @@ It is designed as a better filesystem solution for the following scenarios:
> >      immutable and bit-for-bit identical to the official golden image for
> >      their releases due to security and other considerations and
> > - - hope to save some extra storage space with guaranteed end-to-end performance
> > -   by using reduced metadata and transparent file compression, especially
> > -   for those embedded devices with limited memory (ex, smartphone);
> > + - hope to minimize extra storage space with guaranteed end-to-end performance
> > +   by using compact layout, transparent file compression and direct access,
> > +   especially for those embedded devices with limited memory and high-density
> > +   hosts with numerous containers;
> >   Here is the main features of EROFS:
> > @@ -51,7 +52,9 @@ Here is the main features of EROFS:
> >    - Support POSIX.1e ACLs by using xattrs;
> >    - Support transparent data compression as an option:
> > -   LZ4 algorithm with the fixed-sized output compression for high performance.
> > +   LZ4 algorithm with the fixed-sized output compression for high performance;
> > +
> > + - Multiple device support for multi-layer container images.
> >   The following git tree provides the file system user-space tools under
> >   development (ex, formatting tool mkfs.erofs):
> > @@ -87,6 +90,7 @@ cache_strategy=%s      Select a strategy for cached decompression from now on:
> >   dax={always,never}     Use direct access (no page cache).  See
> >                          Documentation/filesystems/dax.rst.
> >   dax                    A legacy option which is an alias for ``dax=always``.
> > +device=%s              Specify a path to an extra device to be used together.
> >   ===================    =========================================================
> >   On-disk details
> > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > index 14b747026742..addfe608d08e 100644
> > --- a/fs/erofs/Kconfig
> > +++ b/fs/erofs/Kconfig
> > @@ -6,16 +6,22 @@ config EROFS_FS
> >   	select FS_IOMAP
> >   	select LIBCRC32C
> >   	help
> > -	  EROFS (Enhanced Read-Only File System) is a lightweight
> > -	  read-only file system with modern designs (eg. page-sized
> > -	  blocks, inline xattrs/data, etc.) for scenarios which need
> > -	  high-performance read-only requirements, e.g. Android OS
> > -	  for mobile phones and LIVECDs.
> > +	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
> > +	  file system with modern designs (e.g. no buffer heads, inline
> > +	  xattrs/data, chunk-based deduplication, multiple devices, etc.) for
> > +	  scenarios which need high-performance read-only solutions, e.g.
> > +	  smartphones with Android OS, LiveCDs and high-density hosts with
> > +	  numerous containers;
> > -	  It also provides fixed-sized output compression support,
> > -	  which improves storage density, keeps relatively higher
> > -	  compression ratios, which is more useful to achieve high
> > -	  performance for embedded devices with limited memory.
> > +	  It also provides fixed-sized output compression support in order to
> > +	  improve storage density as well as keep relatively higher compression
> > +	  ratios and implements in-place decompression to reuse the file page
> > +	  for compressed data temporarily with proper strategies, which is
> > +	  quite useful to ensure guaranteed end-to-end runtime decompression
> > +	  performance under extremely memory pressure without extra cost.
> > +
> > +	  See the documentation at <file:Documentation/filesystems/erofs.rst>
> > +	  for more details.
> >   	  If unsure, say N.
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 9db829715652..808234d9190c 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -89,6 +89,7 @@ static int erofs_map_blocks(struct inode *inode,
> >   	erofs_off_t pos;
> >   	int err = 0;
> > +	map->m_deviceid = 0;
> >   	if (map->m_la >= inode->i_size) {
> >   		/* leave out-of-bound access unmapped */
> >   		map->m_flags = 0;
> > @@ -135,14 +136,8 @@ static int erofs_map_blocks(struct inode *inode,
> >   		map->m_flags = 0;
> >   		break;
> >   	default:
> > -		/* only one device is supported for now */
> > -		if (idx->device_id) {
> > -			erofs_err(sb, "invalid device id %u @ %llu for nid %llu",
> > -				  le16_to_cpu(idx->device_id),
> > -				  chunknr, vi->nid);
> > -			err = -EFSCORRUPTED;
> > -			goto out_unlock;
> > -		}
> > +		map->m_deviceid = le16_to_cpu(idx->device_id) &
> > +			EROFS_SB(sb)->device_id_mask;
> >   		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
> >   		map->m_flags = EROFS_MAP_MAPPED;
> >   		break;
> > @@ -155,11 +150,55 @@ static int erofs_map_blocks(struct inode *inode,
> >   	return err;
> >   }
> > +int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
> > +{
> > +	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
> > +	struct erofs_device_info *dif;
> > +	int id;
> > +
> > +	/* primary device by default */
> > +	map->m_bdev = sb->s_bdev;
> > +	map->m_daxdev = EROFS_SB(sb)->dax_dev;
> > +
> > +	if (map->m_deviceid) {
> > +		down_read(&devs->rwsem);
> > +		dif = idr_find(&devs->tree, map->m_deviceid - 1);
> > +		if (!dif) {
> > +			up_read(&devs->rwsem);
> > +			return -ENODEV;
> > +		}
> > +		map->m_bdev = dif->bdev;
> > +		map->m_daxdev = dif->dax_dev;
> > +		up_read(&devs->rwsem);
> > +	} else if (devs->extra_devices) {
> > +		down_read(&devs->rwsem);
> > +		idr_for_each_entry(&devs->tree, dif, id) {
> > +			erofs_off_t startoff, length;
> > +
> > +			if (!dif->mapped_blkaddr)
> > +				continue;
> > +			startoff = blknr_to_addr(dif->mapped_blkaddr);
> > +			length = blknr_to_addr(dif->blocks);
> > +
> > +			if (map->m_pa >= startoff &&
> > +			    map->m_pa < startoff + length) {
> > +				map->m_pa -= startoff;
> > +				map->m_bdev = dif->bdev;
> > +				map->m_daxdev = dif->dax_dev;
> > +				break;
> 
> File won't locate in multidevices, right? otherwise it needs to shrink mapped length
> as well.

Thanks for your review.

File can be located in multi-devices. But it's intended as I mentioned in the commit
message, each extent won't cross devices, which is guaranteed by mkfs seriously.
Otherwise, it's more complicated to handle (especially for the compression side) and
has no more benefits.

Thanks,
Gao Xiang

> 
> Thanks,
