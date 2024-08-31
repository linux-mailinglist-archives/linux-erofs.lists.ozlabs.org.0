Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C8A966D85
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 02:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725064272;
	bh=VT8oouZGQwzYC1vFmX2Bue/oThHs7bBkAgqX8/v0ST0=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S7dEgHttr4/cv8GUINsPZ7/vKhJPys2ri0+REAxjraX+7GJFByYhZoXWCG1HBo2NK
	 mW5Q6sOWaVIsIpo1FXNaka4W6KXn+1DsYBYvryZA7kY6K4pLvfikDOZTD/nAiAWSLy
	 vOXxHMkTLVwTYIV/vpMcDtssrKHjiIYGLmdwArQdaDHoECutUyiIgndRD+IsQNZH1F
	 1K/YLpsLWqv/5bQ826zmyCwjZ5/WlSg/gqkAPAKCZ0NuNnjU5i4C0/Z5imY5c3ibqC
	 4Z4dY3Cb+erAzZIiViSxp/2y5hY09SUV0uDRtl8bm9ObIATk5UAzwop5Be2mzdLLMW
	 IBed9DA+7UvkQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwbXw0Wsxz30V3
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 10:31:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725064269;
	cv=none; b=JMNRmO/nsbUb3H/2HZjyxGa3b83W0/UiiZ8Nd4v7/nODkt3iS07NF8DRLvTAHqJE1XexLj+sbwQ+sne3oTyMRQUR6iBPSfI6oAGCmVcD7YQKocU4XpqhtosNYKyDw98ruv3ItSdeJVHaE85ijYXrb30M4/52X9iD8D3ey6DPzKGT8SRpVbfJdf8QDkIpQU1+IBH3dyvgvC3gawk4oYSV6AuHRXXsvWcNLzR2lvz+B5IA3pF63amiFgV7NmxYW4BmpQ+EcJtPo8mmJdlgD0jdGCRJTc0JtG9Jgx6xemTCvLFS24px2z92F61PW8BH5p5mt++Oflc+GMH0xSdImuPpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725064269; c=relaxed/relaxed;
	bh=VT8oouZGQwzYC1vFmX2Bue/oThHs7bBkAgqX8/v0ST0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ZpuO7V/ni9mvAMhuMgR+s8LUsWpCLqrVJSo7R+X9QVIvPwNhv5BLH9VRAinsy0zBfPg5Rn5d98+mwSfFhbJ+C51rBN0kIDcPpxVl2zjqf6dpngaJP8/Ui7vi3TxzQT5qfBknlzelkFzDMpFeOiyuAglh9bfrplig95tK1Y/rm3u4uUA+qs8n8me0xOyfqwR3TbxfddEn1Hd4KAEeK/JXdBG+WlNqQ1e55IlHATgBz8DMszC1BqmG6lNxwIkRuDbkfuJKjQOaoxZOA3akjHRhJtNCuMYU1tiuwTsQff22Km5aMjBuuz1pR9tkuwXNvJFyMFUYnayJzn7R613Yjri1rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Qq6y1nYd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Qq6y1nYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwbXr4vTJz30TS
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 10:31:07 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-7cdf2ac6130so843381a12.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 17:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725064265; x=1725669065; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT8oouZGQwzYC1vFmX2Bue/oThHs7bBkAgqX8/v0ST0=;
        b=Qq6y1nYdSQUhRLLfEbgjYloV+21EaOfSP5/A2HmfBeY0iBX+v0La98guX1qsSPUfJp
         qqL+ZB0aV67dAhDkGl3YjaEMpAJBJR93IE7yuYgWdM8zALq/B2NCb1y6/ecKpXHcRCMn
         B0Htqrk/3Jpz0ggCFKjjoIQwqNMDJWwzqWtGs3y3XaVV6+GaF+XqxNSyc18P/Hhydr2G
         SfeVK5gx5lxOIfk5R+F7gciJzIpxnA83t43JY9FyvvH1uGDBu6m2T+1YZznWVgh+Y+yY
         H0ImC4HuK+5s+XZYnZWys+O9BvvvTakHcDWmpGBLCbeu21kQNtE0+wdf/M115mwPnmLq
         TQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725064265; x=1725669065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT8oouZGQwzYC1vFmX2Bue/oThHs7bBkAgqX8/v0ST0=;
        b=M05BK88kcIvG4oYM4Mhfo5C8nnp9+PYKXluj8OP8+mvivex/7KTjbr4C+RvSqy+oBH
         DIvFRNGZ0xP660WaCkRa5SfAjD/8AVZOcv7Ah6+VPL7HprmhANnSZbsWHGbjcO1Pk2GG
         3Z2VQV/iJiidM4kb5lKivv0M/zRjz/7Wv6qMJkHLrT4ppQt6+XV4inCvCgd/gtM+HHTm
         skmQwGurAFL/T5oJZCaATxiJO766OrmvzHi4w82V+SJXT0wTo/9IeEw5ZzW23TgHFLOR
         OYdsaIiLazn/38TJviwvagj4IdlwOGb6lQYUoM3twPnB43S0N2IhFElWVuA9oojrKmno
         WY4w==
X-Gm-Message-State: AOJu0Yz3iq+k+EYEfonb6V/bB5OodZtDiC3efU/ZR1hL34RG3oPUvi3J
	0dMT4kNljLqRx7mEkWqU1CfONXsNhJF/3FgfOLyzu5HoAwpGFXP0Ccx69Cz4fHMc0IA8Delx8vJ
	cRpbbmPyfZOx3v2ZjSQUwk+qRGgDJeA4o33oZxkRZyAZP470mr+mPqMg=
X-Google-Smtp-Source: AGHT+IHllA+hCLAfJhQi6WPIRVjTGZvJCzHWXnVAVx/B1xQX5e6f3kLuFFwG6AhJRWP6N1ZJ0kb0K5sZQa+Ghvga4Xs=
X-Received: by 2002:a17:90b:1917:b0:2d8:7a3b:730d with SMTP id
 98e67ed59e1d1-2d890546c3cmr1094202a91.21.1725064264712; Fri, 30 Aug 2024
 17:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
Date: Fri, 30 Aug 2024 17:30:53 -0700
Message-ID: <CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 29, 2024 at 8:29=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> It actually has been around for years: For containers and other sandbox
> use cases, there will be thousands (and even more) of authenticated
> (sub)images running on the same host, unlike OS images.
>
> Of course, all scenarios can use the same EROFS on-disk format, but
> bdev-backed mounts just work well for OS images since golden data is
> dumped into real block devices.  However, it's somewhat hard for
> container runtimes to manage and isolate so many unnecessary virtual
> block devices safely and efficiently [1]: they just look like a burden
> to orchestrators and file-backed mounts are preferred indeed.  There
> were already enough attempts such as Incremental FS, the original
> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> for current EROFS users, ComposeFS, containerd and Android APEXs will
> be directly benefited from it.
>
Hi Gao,
Thank you for the series! This is an interesting idea and will
definitely help the Android ecosystem for APEXes if we can remove the
loopback device. I will take a deeper look and provide comments soon.

Thanks,
Sandeep.

> On the other hand, previous experimental feature "erofs over fscache"
> was once also intended to provide a similar solution (inspired by
> Incremental FS discussion [2]), but the following facts show file-backed
> mounts will be a better approach:
>  - Fscache infrastructure has recently been moved into new Netfslib
>    which is an unexpected dependency to EROFS really, although it
>    originally claims "it could be used for caching other things such as
>    ISO9660 filesystems too." [3]
>
>  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>    enhancements.  For example, the failover feature took more than
>    one year, and the deamonless feature is still far behind now;
>
>  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>    perfectly supersede "erofs over fscache" in a simpler way since
>    developers (mainly containerd folks) could leverage their existing
>    caching mechanism entirely in userspace instead of strictly following
>    the predefined in-kernel caching tree hierarchy.
>
> After "fanotify pre-content hooks" lands upstream to provide the same
> functionality, "erofs over fscache" will be removed then (as an EROFS
> internal improvement and EROFS will not have to bother with on-demand
> fetching and/or caching improvements anymore.)
>
> [1] https://github.com/containers/storage/pull/2039
> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=3Dw_AeM6Y=
M=3DzVixsUfQ@mail.gmail.com
> [3] https://docs.kernel.org/filesystems/caching/fscache.html
> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
>
> Closes: https://github.com/containers/composefs/issues/144
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - should use kill_anon_super();
>  - add O_LARGEFILE to support large files.
>
>  fs/erofs/Kconfig    | 17 ++++++++++
>  fs/erofs/data.c     | 35 ++++++++++++---------
>  fs/erofs/inode.c    |  5 ++-
>  fs/erofs/internal.h | 11 +++++--
>  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
>  5 files changed, 100 insertions(+), 44 deletions(-)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..1428d0530e1c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>
>           If you are not using a security module, say N.
>
> +config EROFS_FS_BACKED_BY_FILE
> +       bool "File-backed EROFS filesystem support"
> +       depends on EROFS_FS
> +       default y
> +       help
> +         This allows EROFS to use filesystem image files directly, witho=
ut
> +         the intercession of loopback block devices or likewise. It is
> +         particularly useful for container images with numerous blobs an=
d
> +         other sandboxes, where loop devices behave intricately.  It can=
 also
> +         be used to simplify error-prone lifetime management of unnecess=
ary
> +         virtual block devices.
> +
> +         Note that this feature, along with ongoing fanotify pre-content
> +         hooks, will eventually replace "EROFS over fscache."
> +
> +         If you don't want to enable this feature, say N.
> +
>  config EROFS_FS_ZIP
>         bool "EROFS Data Compression Support"
>         depends on EROFS_FS
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 1b7eba38ba1e..0fb31c588ae0 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -59,8 +59,12 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t o=
ffset,
>
>  void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>  {
> -       if (erofs_is_fscache_mode(sb))
> -               buf->mapping =3D EROFS_SB(sb)->s_fscache->inode->i_mappin=
g;
> +       struct erofs_sb_info *sbi =3D EROFS_SB(sb);
> +
> +       if (erofs_is_fileio_mode(sbi))
> +               buf->mapping =3D file_inode(sbi->fdev)->i_mapping;
> +       else if (erofs_is_fscache_mode(sb))
> +               buf->mapping =3D sbi->s_fscache->inode->i_mapping;
>         else
>                 buf->mapping =3D sb->s_bdev->bd_mapping;
>  }
> @@ -189,10 +193,22 @@ int erofs_map_blocks(struct inode *inode, struct er=
ofs_map_blocks *map)
>         return err;
>  }
>
> +static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
> +                                   struct erofs_device_info *dif)
> +{
> +       map->m_bdev =3D NULL;
> +       if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
> +               map->m_bdev =3D file_bdev(dif->file);
> +       map->m_daxdev =3D dif->dax_dev;
> +       map->m_dax_part_off =3D dif->dax_part_off;
> +       map->m_fscache =3D dif->fscache;
> +}
> +
>  int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  {
>         struct erofs_dev_context *devs =3D EROFS_SB(sb)->devs;
>         struct erofs_device_info *dif;
> +       erofs_off_t startoff, length;
>         int id;
>
>         map->m_bdev =3D sb->s_bdev;
> @@ -212,29 +228,20 @@ int erofs_map_dev(struct super_block *sb, struct er=
ofs_map_dev *map)
>                         up_read(&devs->rwsem);
>                         return 0;
>                 }
> -               map->m_bdev =3D dif->bdev_file ? file_bdev(dif->bdev_file=
) : NULL;
> -               map->m_daxdev =3D dif->dax_dev;
> -               map->m_dax_part_off =3D dif->dax_part_off;
> -               map->m_fscache =3D dif->fscache;
> +               erofs_fill_from_devinfo(map, dif);
>                 up_read(&devs->rwsem);
>         } else if (devs->extra_devices && !devs->flatdev) {
>                 down_read(&devs->rwsem);
>                 idr_for_each_entry(&devs->tree, dif, id) {
> -                       erofs_off_t startoff, length;
> -
>                         if (!dif->mapped_blkaddr)
>                                 continue;
> +
>                         startoff =3D erofs_pos(sb, dif->mapped_blkaddr);
>                         length =3D erofs_pos(sb, dif->blocks);
> -
>                         if (map->m_pa >=3D startoff &&
>                             map->m_pa < startoff + length) {
>                                 map->m_pa -=3D startoff;
> -                               map->m_bdev =3D dif->bdev_file ?
> -                                             file_bdev(dif->bdev_file) :=
 NULL;
> -                               map->m_daxdev =3D dif->dax_dev;
> -                               map->m_dax_part_off =3D dif->dax_part_off=
;
> -                               map->m_fscache =3D dif->fscache;
> +                               erofs_fill_from_devinfo(map, dif);
>                                 break;
>                         }
>                 }
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 419432be3223..d05b9e59f122 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -258,7 +258,10 @@ static int erofs_fill_inode(struct inode *inode)
>         }
>
>         mapping_set_large_folios(inode->i_mapping);
> -       if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +       if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> +               /* XXX: data I/Os will be implemented in the following pa=
tches */
> +               err =3D -EOPNOTSUPP;
> +       } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
>  #ifdef CONFIG_EROFS_FS_ZIP
>                 DO_ONCE_LITE_IF(inode->i_blkbits !=3D PAGE_SHIFT,
>                           erofs_info, inode->i_sb,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 45dc15ebd870..9bf4fb1cfa09 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
>  struct erofs_device_info {
>         char *path;
>         struct erofs_fscache *fscache;
> -       struct file *bdev_file;
> +       struct file *file;
>         struct dax_device *dax_dev;
>         u64 dax_part_off;
>
> @@ -130,6 +130,7 @@ struct erofs_sb_info {
>
>         struct erofs_sb_lz4_info lz4;
>  #endif /* CONFIG_EROFS_FS_ZIP */
> +       struct file *fdev;
>         struct inode *packed_inode;
>         struct erofs_dev_context *devs;
>         struct dax_device *dax_dev;
> @@ -190,9 +191,15 @@ struct erofs_sb_info {
>  #define set_opt(opt, option)   ((opt)->mount_opt |=3D EROFS_MOUNT_##opti=
on)
>  #define test_opt(opt, option)  ((opt)->mount_opt & EROFS_MOUNT_##option)
>
> +static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
> +{
> +       return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
> +}
> +
>  static inline bool erofs_is_fscache_mode(struct super_block *sb)
>  {
> -       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev;
> +       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> +                       !erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bde=
v;
>  }
>
>  enum {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index aae3fd15899a..9a7e67eceed4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -10,6 +10,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/exportfs.h>
> +#include <linux/backing-dev.h>
>  #include "xattr.h"
>
>  #define CREATE_TRACE_POINTS
> @@ -161,7 +162,7 @@ static int erofs_init_device(struct erofs_buf *buf, s=
truct super_block *sb,
>         struct erofs_sb_info *sbi =3D EROFS_SB(sb);
>         struct erofs_fscache *fscache;
>         struct erofs_deviceslot *dis;
> -       struct file *bdev_file;
> +       struct file *file;
>
>         dis =3D erofs_read_metabuf(buf, sb, *pos, EROFS_KMAP);
>         if (IS_ERR(dis))
> @@ -183,13 +184,17 @@ static int erofs_init_device(struct erofs_buf *buf,=
 struct super_block *sb,
>                         return PTR_ERR(fscache);
>                 dif->fscache =3D fscache;
>         } else if (!sbi->devs->flatdev) {
> -               bdev_file =3D bdev_file_open_by_path(dif->path, BLK_OPEN_=
READ,
> -                                               sb->s_type, NULL);
> -               if (IS_ERR(bdev_file))
> -                       return PTR_ERR(bdev_file);
> -               dif->bdev_file =3D bdev_file;
> -               dif->dax_dev =3D fs_dax_get_by_bdev(file_bdev(bdev_file),
> -                               &dif->dax_part_off, NULL, NULL);
> +               file =3D erofs_is_fileio_mode(sbi) ?
> +                               filp_open(dif->path, O_RDONLY | O_LARGEFI=
LE, 0) :
> +                               bdev_file_open_by_path(dif->path,
> +                                               BLK_OPEN_READ, sb->s_type=
, NULL);
> +               if (IS_ERR(file))
> +                       return PTR_ERR(file);
> +
> +               dif->file =3D file;
> +               if (!erofs_is_fileio_mode(sbi))
> +                       dif->dax_dev =3D fs_dax_get_by_bdev(file_bdev(fil=
e),
> +                                       &dif->dax_part_off, NULL, NULL);
>         }
>
>         dif->blocks =3D le32_to_cpu(dis->blocks);
> @@ -566,15 +571,16 @@ static void erofs_set_sysfs_name(struct super_block=
 *sb)
>  {
>         struct erofs_sb_info *sbi =3D EROFS_SB(sb);
>
> -       if (erofs_is_fscache_mode(sb)) {
> -               if (sbi->domain_id)
> -                       super_set_sysfs_name_generic(sb, "%s,%s",sbi->dom=
ain_id,
> -                                                    sbi->fsid);
> -               else
> -                       super_set_sysfs_name_generic(sb, "%s", sbi->fsid)=
;
> -               return;
> -       }
> -       super_set_sysfs_name_id(sb);
> +       if (sbi->domain_id)
> +               super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
> +                                            sbi->fsid);
> +       else if (sbi->fsid)
> +               super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
> +       else if (erofs_is_fileio_mode(sbi))
> +               super_set_sysfs_name_generic(sb, "%s",
> +                                            bdi_dev_name(sb->s_bdi));
> +       else
> +               super_set_sysfs_name_id(sb);
>  }
>
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context=
 *fc)
> @@ -589,14 +595,15 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
>         sb->s_op =3D &erofs_sops;
>
>         sbi->blkszbits =3D PAGE_SHIFT;
> -       if (erofs_is_fscache_mode(sb)) {
> +       if (!sb->s_bdev) {
>                 sb->s_blocksize =3D PAGE_SIZE;
>                 sb->s_blocksize_bits =3D PAGE_SHIFT;
>
> -               err =3D erofs_fscache_register_fs(sb);
> -               if (err)
> -                       return err;
> -
> +               if (erofs_is_fscache_mode(sb)) {
> +                       err =3D erofs_fscache_register_fs(sb);
> +                       if (err)
> +                               return err;
> +               }
>                 err =3D super_setup_bdi(sb);
>                 if (err)
>                         return err;
> @@ -693,11 +700,24 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>         struct erofs_sb_info *sbi =3D fc->s_fs_info;
> +       int ret;
>
>         if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>                 return get_tree_nodev(fc, erofs_fc_fill_super);
>
> -       return get_tree_bdev(fc, erofs_fc_fill_super);
> +       ret =3D get_tree_bdev(fc, erofs_fc_fill_super);
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +       if (ret =3D=3D -ENOTBLK) {
> +               if (!fc->source)
> +                       return invalf(fc, "No source specified");
> +               sbi->fdev =3D filp_open(fc->source, O_RDONLY | O_LARGEFIL=
E, 0);
> +               if (IS_ERR(sbi->fdev))
> +                       return PTR_ERR(sbi->fdev);
> +
> +               return get_tree_nodev(fc, erofs_fc_fill_super);
> +       }
> +#endif
> +       return ret;
>  }
>
>  static int erofs_fc_reconfigure(struct fs_context *fc)
> @@ -727,8 +747,8 @@ static int erofs_release_device_info(int id, void *pt=
r, void *data)
>         struct erofs_device_info *dif =3D ptr;
>
>         fs_put_dax(dif->dax_dev, NULL);
> -       if (dif->bdev_file)
> -               fput(dif->bdev_file);
> +       if (dif->file)
> +               fput(dif->file);
>         erofs_fscache_unregister_cookie(dif->fscache);
>         dif->fscache =3D NULL;
>         kfree(dif->path);
> @@ -791,7 +811,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  {
>         struct erofs_sb_info *sbi =3D EROFS_SB(sb);
>
> -       if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
> +       if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) || sbi->f=
dev)
>                 kill_anon_super(sb);
>         else
>                 kill_block_super(sb);
> @@ -801,6 +821,8 @@ static void erofs_kill_sb(struct super_block *sb)
>         erofs_fscache_unregister_fs(sb);
>         kfree(sbi->fsid);
>         kfree(sbi->domain_id);
> +       if (sbi->fdev)
> +               fput(sbi->fdev);
>         kfree(sbi);
>         sb->s_fs_info =3D NULL;
>  }
> @@ -903,7 +925,7 @@ static int erofs_statfs(struct dentry *dentry, struct=
 kstatfs *buf)
>         buf->f_namelen =3D EROFS_NAME_LEN;
>
>         if (uuid_is_null(&sb->s_uuid))
> -               buf->f_fsid =3D u64_to_fsid(erofs_is_fscache_mode(sb) ? 0=
 :
> +               buf->f_fsid =3D u64_to_fsid(!sb->s_bdev ? 0 :
>                                 huge_encode_dev(sb->s_bdev->bd_dev));
>         else
>                 buf->f_fsid =3D uuid_to_fsid(sb->s_uuid.b);
> --
> 2.43.5
>
