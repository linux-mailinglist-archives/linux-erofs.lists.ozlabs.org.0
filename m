Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546888A18F
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 14:20:41 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aDKG3hFm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V3D832P9Zz3cnv
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Mar 2024 00:20:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aDKG3hFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2c; helo=mail-yb1-xb2c.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V3D7s0YLGz3bx0
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Mar 2024 00:20:23 +1100 (AEDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-dd161eb03afso3607798276.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 25 Mar 2024 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711372817; x=1711977617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnpvLIUrfjrMDrpYadDEAQMh8VgValdAyfKndehB29s=;
        b=aDKG3hFmlpC+jORPQqCo5DKga1kYI9FiV2Qzs0Xpk77p7RFVoRfhea2bB5wcIJguIM
         Jbrav+yUwbUzmEe5zE6WrbBtzaDVa3ThJliRu52stgbwZlzd3bygIn3vjYRJ9gj6NSnM
         O0prt7Fq36ILF60IPR55m/vJ3E+Alg/wDEkxBUR23scDH0T6EEQFnpkDRNdQ8md9LURN
         lyheAB1IhTWo1sp4YUwiX6LDGurkTYutQ68GchNj3v8D/9XWsxRXPmpwJ6LbNMnd9P5b
         oh+FfWehp3WQsMHnaPuUEEXVeXktQ/EbwTO0tRIbda6HRDR1WSi45IB3DDL6mKnnFbWH
         c17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372817; x=1711977617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnpvLIUrfjrMDrpYadDEAQMh8VgValdAyfKndehB29s=;
        b=S01p/Pr+oE/dKWyUU3xxJGo7vksfcIbbQzjQGvOXx0mhrSNSENbixiK5WYPpWdHhbz
         OKuLc2ao4ZyA4P6WF5QnZENwUMCCtK5/6rCXZlBUhpm4gTIH1f92dgBsHwSOY7WcpC92
         mO1dj9kMVGnCRUx44E8WhG4ymr1kg2SRW6RltNuV57l1OSP/PqxkOLTiRcklGvvwsgjz
         XJAJ4iTKx36BshbtxWU3/XF+95Ow0wGUH6eNCBJNd/3kHSdq27B9h5uB8IB42UAqha2u
         7HlJfAGqwKTQfWXPGZm/vNRryrbPHY0E2EHKWPFxGFW8VchUcAPsWvsmYUvS3ZuB097I
         aJnQ==
X-Gm-Message-State: AOJu0YxssJlPwJNs3rU22cFuJLX4Bd0yygB49dYA+ucbWxsFl9BRQNCp
	T87lM/CDkjgd1fbb1Bgokv42kJ225tmTIs289PXUz87XSGV2IPm1HOe/XOj9sXoIxeinbSRBdBr
	6qd0kJuh2Uqq6CnElQyLNVUnmkhQ=
X-Google-Smtp-Source: AGHT+IGpCE8si961gkE6Drmqt/lm2H+ov+N8pGIRLy9DU8zaGohJMAkoocoqgmKUlptfxYCerQh4B/hNzdTWvbTOy3Y=
X-Received: by 2002:a25:7450:0:b0:dd1:40cf:942b with SMTP id
 p77-20020a257450000000b00dd140cf942bmr5236848ybc.48.1711372816825; Mon, 25
 Mar 2024 06:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240323173902.3882401-1-zhaoyifan@sjtu.edu.cn> <20240323173902.3882401-3-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240323173902.3882401-3-zhaoyifan@sjtu.edu.cn>
From: Huang Jianan <jnhuang95@gmail.com>
Date: Mon, 25 Mar 2024 21:20:00 +0800
Message-ID: <CAJfKizpro5RMYs1mmxao2urkWQTHrrKvnD0fLjjnORLL_9MDdw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] erofs-utils: mkfs: introduce inter-file
 multi-threaded compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Yifan Zhao <zhaoyifan@sjtu.edu.cn> =E4=BA=8E2024=E5=B9=B43=E6=9C=8824=E6=97=
=A5=E5=91=A8=E6=97=A5 01:39=E5=86=99=E9=81=93=EF=BC=9A
>
> This patch allows parallelizing the compression process of different
> files in mkfs. Specifically, a traverser thread traverses the files and
> issues the compression task, which is handled by the workers. Then, the
> main thread consumes them and writes the compressed data to the device.
>
> To this end, the logic of erofs_write_compressed_file() has been
> modified to split the creation and completion logic of the compression
> task.
>
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
> ---
>  include/erofs/compress.h |  16 ++
>  include/erofs/inode.h    |  30 ++++
>  include/erofs/internal.h |   3 +
>  lib/compress.c           | 336 +++++++++++++++++++++++++--------------
>  lib/inode.c              | 254 +++++++++++++++++++++++++++--
>  5 files changed, 511 insertions(+), 128 deletions(-)
>
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index 871db54..8d5a54b 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -17,6 +17,22 @@ extern "C"
>  #define EROFS_CONFIG_COMPR_MAX_SZ      (4000 * 1024)
>  #define Z_EROFS_COMPR_QUEUE_SZ         (EROFS_CONFIG_COMPR_MAX_SZ * 2)
>
> +#ifdef EROFS_MT_ENABLED
> +struct z_erofs_mt_file {
> +       pthread_mutex_t mutex;
> +       pthread_cond_t cond;
> +       int total;
> +       int nfini;
> +
> +       int fd;
> +       struct erofs_compress_work *head;
> +
> +       struct z_erofs_mt_file *next;
> +};
> +
> +int z_erofs_mt_reap(struct z_erofs_mt_file *desc);
> +#endif
> +
>  void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
>  int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 f=
pos);
>
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index d5a732a..e68f677 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -41,6 +41,36 @@ struct erofs_inode *erofs_new_inode(void);
>  struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
>  struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char =
*name);
>
> +#ifdef EROFS_MT_ENABLED
> +struct erofs_inode_fifo {
> +       pthread_mutex_t lock;
> +       pthread_cond_t full, empty;
> +
> +       void *buf;
> +
> +       size_t size, elem_size;
> +       size_t head, tail;
> +};
> +
> +struct erofs_inode_fifo *erofs_alloc_inode_fifo(size_t size, size_t elem=
_size);
> +void erofs_push_inode_fifo(struct erofs_inode_fifo *q, void *elem);
> +void *erofs_pop_inode_fifo(struct erofs_inode_fifo *q);
> +void erofs_destroy_inode_fifo(struct erofs_inode_fifo *q);
> +#else
> +struct erofs_inode_fifo {};
> +static inline struct erofs_inode_fifo *erofs_alloc_inode_fifo(size_t siz=
e,
> +                                                             size_t elem=
_size)
> +{
> +       return NULL;
> +}
> +static inline void erofs_push_inode_fifo(struct erofs_inode_fifo *q, voi=
d *elem) {}
> +static inline void *erofs_pop_inode_fifo(struct erofs_inode_fifo *q)
> +{
> +       return NULL;
> +}
> +static inline void erofs_destroy_inode_fifo(struct erofs_inode_fifo *q) =
{}
> +#endif
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 4cd2059..2580588 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -250,6 +250,9 @@ struct erofs_inode {
>  #ifdef WITH_ANDROID
>         uint64_t capabilities;
>  #endif
> +#ifdef EROFS_MT_ENABLED
> +       struct z_erofs_mt_file *mt_desc;
> +#endif
>  };
>
>  static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
> diff --git a/lib/compress.c b/lib/compress.c
> index 61bbf8a..252c11f 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -86,6 +86,7 @@ struct erofs_compress_work {
>         struct erofs_work work;
>         struct z_erofs_compress_sctx ctx;
>         struct erofs_compress_work *next;
> +       struct z_erofs_mt_file *mtfile_desc;
>
>         unsigned int alg_id;
>         char *alg_name;
> @@ -97,14 +98,14 @@ struct erofs_compress_work {
>
>  static struct {
>         struct erofs_workqueue wq;
> -       struct erofs_compress_work *idle;
> -       pthread_mutex_t mutex;
> -       pthread_cond_t cond;
> -       int nfini;
> +       struct erofs_compress_work *work_idle;
> +       pthread_mutex_t work_mutex;
> +       struct z_erofs_mt_file *file_idle;
> +       pthread_mutex_t file_mutex;
>  } z_erofs_mt_ctrl;
>  #endif
>
> -static bool z_erofs_mt_enabled;
> +bool z_erofs_mt_enabled;
>
>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE Z_EROFS_FULL_INDEX_ALIGN(0)
>
> @@ -1026,6 +1027,90 @@ int z_erofs_compress_segment(struct z_erofs_compre=
ss_sctx *ctx,
>         return 0;
>  }
>
> +int z_erofs_finalize_compression(struct z_erofs_compress_ictx *ictx,
> +                                struct erofs_buffer_head *bh,
> +                                erofs_blk_t blkaddr,
> +                                erofs_blk_t compressed_blocks)
> +{
> +       struct erofs_inode *inode =3D ictx->inode;
> +       struct erofs_sb_info *sbi =3D inode->sbi;
> +       u8 *compressmeta =3D ictx->metacur - Z_EROFS_LEGACY_MAP_HEADER_SI=
ZE;
> +       unsigned int legacymetasize;
> +       int ret =3D 0;
> +
> +       /* fall back to no compression mode */
> +       DBG_BUGON(compressed_blocks < !!inode->idata_size);
> +       compressed_blocks -=3D !!inode->idata_size;
> +
> +       z_erofs_write_indexes(ictx);
> +       legacymetasize =3D ictx->metacur - compressmeta;
> +       /* estimate if data compression saves space or not */
> +       if (!inode->fragment_size &&
> +           compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
> +           legacymetasize >=3D inode->i_size) {
> +               z_erofs_dedupe_commit(true);
> +
> +               if (inode->idata) {
> +                       free(inode->idata);
> +                       inode->idata =3D NULL;
> +               }
> +               erofs_bdrop(bh, true); /* revoke buffer */
> +               free(compressmeta);
> +               inode->compressmeta =3D NULL;
> +
> +               return -ENOSPC;
> +       }
> +       z_erofs_dedupe_commit(false);
> +       z_erofs_write_mapheader(inode, compressmeta);
> +
> +       if (!ictx->fragemitted)
> +               sbi->saved_by_deduplication +=3D inode->fragment_size;
> +
> +       /* if the entire file is a fragment, a simplified form is used. *=
/
> +       if (inode->i_size <=3D inode->fragment_size) {
> +               DBG_BUGON(inode->i_size < inode->fragment_size);
> +               DBG_BUGON(inode->fragmentoff >> 63);
> +               *(__le64 *)compressmeta =3D
> +                       cpu_to_le64(inode->fragmentoff | 1ULL << 63);
> +               inode->datalayout =3D EROFS_INODE_COMPRESSED_FULL;
> +               legacymetasize =3D Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> +       }
> +
> +       if (compressed_blocks) {
> +               ret =3D erofs_bh_balloon(bh, erofs_pos(sbi, compressed_bl=
ocks));
> +               DBG_BUGON(ret !=3D erofs_blksiz(sbi));
> +       } else {
> +               if (!cfg.c_fragments && !cfg.c_dedupe)
> +                       DBG_BUGON(!inode->idata_size);
> +       }
> +
> +       erofs_info("compressed %s (%llu bytes) into %u blocks",
> +                  inode->i_srcpath, (unsigned long long)inode->i_size,
> +                  compressed_blocks);
> +
> +       if (inode->idata_size) {
> +               bh->op =3D &erofs_skip_write_bhops;
> +               inode->bh_data =3D bh;
> +       } else {
> +               erofs_bdrop(bh, false);
> +       }
> +
> +       inode->u.i_blocks =3D compressed_blocks;
> +
> +       if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_FULL) {
> +               inode->extent_isize =3D legacymetasize;
> +       } else {
> +               ret =3D z_erofs_convert_to_compacted_format(inode, blkadd=
r,
> +                                                         legacymetasize,
> +                                                         compressmeta);
> +               DBG_BUGON(ret);
> +       }
> +       inode->compressmeta =3D compressmeta;
> +       if (!erofs_is_packed_inode(inode))
> +               erofs_droid_blocklist_write(inode, blkaddr, compressed_bl=
ocks);
> +       return 0;
> +}
> +
>  #ifdef EROFS_MT_ENABLED
>  void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
>  {
> @@ -1100,6 +1185,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, voi=
d *tlsp)
>         struct erofs_compress_work *cwork =3D (struct erofs_compress_work=
 *)work;
>         struct erofs_compress_wq_tls *tls =3D tlsp;
>         struct z_erofs_compress_sctx *sctx =3D &cwork->ctx;
> +       struct z_erofs_mt_file *mtfile_desc =3D cwork->mtfile_desc;
>         struct erofs_inode *inode =3D sctx->ictx->inode;
>         struct erofs_sb_info *sbi =3D inode->sbi;
>         int ret =3D 0;
> @@ -1127,10 +1213,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, v=
oid *tlsp)
>
>  out:
>         cwork->errcode =3D ret;
> -       pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> -       ++z_erofs_mt_ctrl.nfini;
> -       pthread_cond_signal(&z_erofs_mt_ctrl.cond);
> -       pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> +       pthread_mutex_lock(&mtfile_desc->mutex);
> +       ++mtfile_desc->nfini;
> +       pthread_cond_signal(&mtfile_desc->cond);
> +       pthread_mutex_unlock(&mtfile_desc->mutex);
>  }
>
>  int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
> @@ -1164,27 +1250,59 @@ int z_erofs_merge_segment(struct z_erofs_compress=
_ictx *ictx,
>  }
>
>  int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
> -                       struct erofs_compress_cfg *ccfg,
> -                       erofs_blk_t blkaddr,
> -                       erofs_blk_t *compressed_blocks)
> +                       struct erofs_compress_cfg *ccfg)
>  {
>         struct erofs_compress_work *cur, *head =3D NULL, **last =3D &head=
;
>         struct erofs_inode *inode =3D ictx->inode;
> +       struct z_erofs_mt_file *mtfile_desc =3D NULL;
>         int nsegs =3D DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
> -       int ret, i;
> +       int i;
>
> -       z_erofs_mt_ctrl.nfini =3D 0;
> +       pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
> +       if (z_erofs_mt_ctrl.file_idle) {
> +               mtfile_desc =3D z_erofs_mt_ctrl.file_idle;
> +               z_erofs_mt_ctrl.file_idle =3D mtfile_desc->next;
> +               mtfile_desc->next =3D NULL;
> +       }
> +       pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> +       if (!mtfile_desc) {
> +               mtfile_desc =3D calloc(1, sizeof(*mtfile_desc));
> +               if (!mtfile_desc)
> +                       return -ENOMEM;
> +       }
> +       inode->mt_desc =3D mtfile_desc;
> +
> +       mtfile_desc->fd =3D ictx->fd;
> +       mtfile_desc->total =3D nsegs;
> +       mtfile_desc->nfini =3D 0;
> +       pthread_mutex_init(&mtfile_desc->mutex, NULL);
> +       pthread_cond_init(&mtfile_desc->cond, NULL);
>
>         for (i =3D 0; i < nsegs; i++) {
> -               if (z_erofs_mt_ctrl.idle) {
> -                       cur =3D z_erofs_mt_ctrl.idle;
> -                       z_erofs_mt_ctrl.idle =3D cur->next;
> +               cur =3D NULL;
> +
> +               pthread_mutex_lock(&z_erofs_mt_ctrl.work_mutex);
> +               if (z_erofs_mt_ctrl.work_idle) {
> +                       cur =3D z_erofs_mt_ctrl.work_idle;
> +                       z_erofs_mt_ctrl.work_idle =3D cur->next;
>                         cur->next =3D NULL;
> -               } else {
> +               }
> +               pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
> +               if (!cur) {
>                         cur =3D calloc(1, sizeof(*cur));
> -                       if (!cur)
> +                       if (!cur) {
> +                               while (head) {
> +                                       cur =3D head;
> +                                       head =3D cur->next;
> +                                       free(cur);
> +                               }
> +                               free(mtfile_desc);
>                                 return -ENOMEM;
> +                       }
>                 }
> +
> +               if (i =3D=3D 0)
> +                       mtfile_desc->head =3D cur;
>                 *last =3D cur;
>                 last =3D &cur->next;
>
> @@ -1208,21 +1326,30 @@ int z_erofs_mt_compress(struct z_erofs_compress_i=
ctx *ictx,
>                 cur->comp_level =3D ccfg->handle.compression_level;
>                 cur->dict_size =3D ccfg->handle.dict_size;
>
> +               cur->mtfile_desc =3D mtfile_desc;
>                 cur->work.fn =3D z_erofs_mt_workfn;
>                 erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
>         }
>
> -       pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> -       while (z_erofs_mt_ctrl.nfini !=3D nsegs)
> -               pthread_cond_wait(&z_erofs_mt_ctrl.cond,
> -                                 &z_erofs_mt_ctrl.mutex);
> -       pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> +       return 0;
> +}
>
> -       ret =3D 0;
> -       while (head) {
> -               cur =3D head;
> -               head =3D cur->next;
> +int z_erofs_mt_reap(struct z_erofs_mt_file *desc)
> +{
> +       struct erofs_buffer_head *bh =3D NULL;
> +       struct erofs_compress_work *cur =3D desc->head, *tmp;
> +       struct z_erofs_compress_ictx *ictx =3D cur->ctx.ictx;
> +       erofs_blk_t blkaddr, compressed_blocks =3D 0;
> +       int ret =3D 0;
>
> +       bh =3D erofs_balloc(DATA, 0, 0, 0);
> +       if (IS_ERR(bh)) {
> +               ret =3D PTR_ERR(bh);
> +               goto out;
> +       }
> +       blkaddr =3D erofs_mapbh(bh->block);
> +
> +       while (cur) {
>                 if (cur->errcode) {
>                         ret =3D cur->errcode;
>                 } else {
> @@ -1233,13 +1360,30 @@ int z_erofs_mt_compress(struct z_erofs_compress_i=
ctx *ictx,
>                         if (ret2)
>                                 ret =3D ret2;
>
> -                       *compressed_blocks +=3D cur->ctx.blkaddr - blkadd=
r;
> +                       compressed_blocks +=3D cur->ctx.blkaddr - blkaddr=
;
>                         blkaddr =3D cur->ctx.blkaddr;
>                 }
>
> -               cur->next =3D z_erofs_mt_ctrl.idle;
> -               z_erofs_mt_ctrl.idle =3D cur;
> +               tmp =3D cur->next;
> +               pthread_mutex_lock(&z_erofs_mt_ctrl.work_mutex);
> +               cur->next =3D z_erofs_mt_ctrl.work_idle;
> +               z_erofs_mt_ctrl.work_idle =3D cur;
> +               pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
> +               cur =3D tmp;
>         }
> +       if (ret)
> +               goto out;
> +
> +       ret =3D z_erofs_finalize_compression(
> +               ictx, bh, blkaddr - compressed_blocks, compressed_blocks)=
;
> +
> +out:
> +       free(ictx);
> +       pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
> +       desc->next =3D z_erofs_mt_ctrl.file_idle;
> +       z_erofs_mt_ctrl.file_idle =3D desc;
> +       pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> +
>         return ret;
>  }
>  #endif
> @@ -1252,9 +1396,7 @@ int erofs_write_compressed_file(struct erofs_inode =
*inode, int fd, u64 fpos)
>         static struct z_erofs_compress_sctx sctx;
>         struct erofs_compress_cfg *ccfg;
>         erofs_blk_t blkaddr, compressed_blocks =3D 0;
> -       unsigned int legacymetasize;
>         int ret;
> -       bool ismt =3D false;
>         struct erofs_sb_info *sbi =3D inode->sbi;
>         u8 *compressmeta =3D malloc(BLK_ROUND_UP(sbi, inode->i_size) *
>                                   sizeof(struct z_erofs_lcluster_index) +
> @@ -1263,11 +1405,17 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd, u64 fpos)
>         if (!compressmeta)
>                 return -ENOMEM;
>
> -       /* allocate main data buffer */
> -       bh =3D erofs_balloc(DATA, 0, 0, 0);
> -       if (IS_ERR(bh)) {
> -               ret =3D PTR_ERR(bh);
> -               goto err_free_meta;
> +       if (!z_erofs_mt_enabled) {
> +               /* allocate main data buffer */
> +               bh =3D erofs_balloc(DATA, 0, 0, 0);
> +               if (IS_ERR(bh)) {
> +                       ret =3D PTR_ERR(bh);
> +                       goto err_free_meta;
> +               }
> +               blkaddr =3D erofs_mapbh(bh->block); /* start_blkaddr */
> +       } else {
> +               bh =3D NULL;
> +               blkaddr =3D EROFS_NULL_ADDR;
>         }
>
>         /* initialize per-file compression setting */
> @@ -1316,7 +1464,6 @@ int erofs_write_compressed_file(struct erofs_inode =
*inode, int fd, u64 fpos)
>                         goto err_bdrop;
>         }
>
> -       blkaddr =3D erofs_mapbh(bh->block);       /* start_blkaddr */
>         ctx.inode =3D inode;
>         ctx.fd =3D fd;
>         ctx.fpos =3D fpos;
> @@ -1333,11 +1480,24 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd, u64 fpos)
>                 if (ret)
>                         goto err_free_idata;
>  #ifdef EROFS_MT_ENABLED
> -       } else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_si=
ze) {
> -               ismt =3D true;
> -               ret =3D z_erofs_mt_compress(&ctx, ccfg, blkaddr, &compres=
sed_blocks);
> -               if (ret)
> +       } else if (z_erofs_mt_enabled) {
> +               struct z_erofs_compress_ictx *l_ictx;
> +
> +               l_ictx =3D malloc(sizeof(*l_ictx));
> +               if (!l_ictx) {
> +                       ret =3D -ENOMEM;
>                         goto err_free_idata;
> +               }
> +
> +               memcpy(l_ictx, &ctx, sizeof(*l_ictx));
> +               init_list_head(&l_ictx->extents);
> +
> +               ret =3D z_erofs_mt_compress(l_ictx, ccfg);
> +               if (ret) {
> +                       free(l_ictx);
> +                       goto err_free_idata;
> +               }
> +               return 0;
>  #endif
>         } else {
>                 sctx.queue =3D g_queue;
> @@ -1355,10 +1515,6 @@ int erofs_write_compressed_file(struct erofs_inode=
 *inode, int fd, u64 fpos)
>                 compressed_blocks =3D sctx.blkaddr - blkaddr;
>         }
>
> -       /* fall back to no compression mode */
> -       DBG_BUGON(compressed_blocks < !!inode->idata_size);
> -       compressed_blocks -=3D !!inode->idata_size;
> -
>         /* generate an extent for the deduplicated fragment */
>         if (inode->fragment_size && !ctx.fragemitted) {
>                 struct z_erofs_extent_item *ei;
> @@ -1380,69 +1536,10 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd, u64 fpos)
>                 z_erofs_commit_extent(&sctx, ei);
>         }
>         z_erofs_fragments_commit(inode);
> +       list_splice_tail(&sctx.extents, &ctx.extents);
>
> -       if (!ismt)
> -               list_splice_tail(&sctx.extents, &ctx.extents);
> -
> -       z_erofs_write_indexes(&ctx);
> -       legacymetasize =3D ctx.metacur - compressmeta;
> -       /* estimate if data compression saves space or not */
> -       if (!inode->fragment_size &&
> -           compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
> -           legacymetasize >=3D inode->i_size) {
> -               z_erofs_dedupe_commit(true);
> -               ret =3D -ENOSPC;
> -               goto err_free_idata;
> -       }
> -       z_erofs_dedupe_commit(false);
> -       z_erofs_write_mapheader(inode, compressmeta);
> -
> -       if (!ctx.fragemitted)
> -               sbi->saved_by_deduplication +=3D inode->fragment_size;
> -
> -       /* if the entire file is a fragment, a simplified form is used. *=
/
> -       if (inode->i_size <=3D inode->fragment_size) {
> -               DBG_BUGON(inode->i_size < inode->fragment_size);
> -               DBG_BUGON(inode->fragmentoff >> 63);
> -               *(__le64 *)compressmeta =3D
> -                       cpu_to_le64(inode->fragmentoff | 1ULL << 63);
> -               inode->datalayout =3D EROFS_INODE_COMPRESSED_FULL;
> -               legacymetasize =3D Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> -       }
> -
> -       if (compressed_blocks) {
> -               ret =3D erofs_bh_balloon(bh, erofs_pos(sbi, compressed_bl=
ocks));
> -               DBG_BUGON(ret !=3D erofs_blksiz(sbi));
> -       } else {
> -               if (!cfg.c_fragments && !cfg.c_dedupe)
> -                       DBG_BUGON(!inode->idata_size);
> -       }
> -
> -       erofs_info("compressed %s (%llu bytes) into %u blocks",
> -                  inode->i_srcpath, (unsigned long long)inode->i_size,
> -                  compressed_blocks);
> -
> -       if (inode->idata_size) {
> -               bh->op =3D &erofs_skip_write_bhops;
> -               inode->bh_data =3D bh;
> -       } else {
> -               erofs_bdrop(bh, false);
> -       }
> -
> -       inode->u.i_blocks =3D compressed_blocks;
> -
> -       if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_FULL) {
> -               inode->extent_isize =3D legacymetasize;
> -       } else {
> -               ret =3D z_erofs_convert_to_compacted_format(inode, blkadd=
r,
> -                                                         legacymetasize,
> -                                                         compressmeta);
> -               DBG_BUGON(ret);
> -       }
> -       inode->compressmeta =3D compressmeta;
> -       if (!erofs_is_packed_inode(inode))
> -               erofs_droid_blocklist_write(inode, blkaddr, compressed_bl=
ocks);
> -       return 0;
> +       return z_erofs_finalize_compression(&ctx, bh, blkaddr,
> +                                           compressed_blocks);
>
>  err_free_idata:
>         if (inode->idata) {
> @@ -1450,7 +1547,8 @@ err_free_idata:
>                 inode->idata =3D NULL;
>         }
>  err_bdrop:
> -       erofs_bdrop(bh, true);  /* revoke buffer */
> +       if (bh)
> +               erofs_bdrop(bh, true);  /* revoke buffer */
>  err_free_meta:
>         free(compressmeta);
>         inode->compressmeta =3D NULL;
> @@ -1601,8 +1699,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi=
, struct erofs_buffer_head *s
>         z_erofs_mt_enabled =3D false;
>  #ifdef EROFS_MT_ENABLED
>         if (cfg.c_mt_workers > 1) {
> -               pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
> -               pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
> +               pthread_mutex_init(&z_erofs_mt_ctrl.file_mutex, NULL);
> +               pthread_mutex_init(&z_erofs_mt_ctrl.work_mutex, NULL);
>                 ret =3D erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
>                                             cfg.c_mt_workers,
>                                             cfg.c_mt_workers << 2,
> @@ -1629,11 +1727,17 @@ int z_erofs_compress_exit(void)
>                 ret =3D erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
>                 if (ret)
>                         return ret;
> -               while (z_erofs_mt_ctrl.idle) {
> +               while (z_erofs_mt_ctrl.work_idle) {
>                         struct erofs_compress_work *tmp =3D
> -                               z_erofs_mt_ctrl.idle->next;
> -                       free(z_erofs_mt_ctrl.idle);
> -                       z_erofs_mt_ctrl.idle =3D tmp;
> +                               z_erofs_mt_ctrl.work_idle->next;
> +                       free(z_erofs_mt_ctrl.work_idle);
> +                       z_erofs_mt_ctrl.work_idle =3D tmp;
> +               }
> +               while (z_erofs_mt_ctrl.file_idle) {
> +                       struct z_erofs_mt_file *tmp =3D
> +                               z_erofs_mt_ctrl.file_idle->next;
> +                       free(z_erofs_mt_ctrl.file_idle);
> +                       z_erofs_mt_ctrl.file_idle =3D tmp;
>                 }
>  #endif
>         }
> diff --git a/lib/inode.c b/lib/inode.c
> index 36ee58d..0faf461 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -29,6 +29,10 @@
>  #include "erofs/fragments.h"
>  #include "liberofs_private.h"
>
> +extern bool z_erofs_mt_enabled;
> +struct erofs_inode_fifo *z_erofs_mt_inode_fifo;
> +#define EROFS_MT_QUEUE_SIZE 256
> +
>  #define S_SHIFT                 12
>  static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] =3D {
>         [S_IFREG >> S_SHIFT]  =3D EROFS_FT_REG_FILE,
> @@ -1036,6 +1040,9 @@ struct erofs_inode *erofs_new_inode(void)
>         inode->i_ino[0] =3D sbi.inos++;   /* inode serial number */
>         inode->i_count =3D 1;
>         inode->datalayout =3D EROFS_INODE_FLAT_PLAIN;
> +#ifdef EROFS_MT_ENABLED
> +       inode->mt_desc =3D NULL;
> +#endif
>
>         init_list_head(&inode->i_hash);
>         init_list_head(&inode->i_subdirs);
> @@ -1100,7 +1107,6 @@ static void erofs_fixup_meta_blkaddr(struct erofs_i=
node *rootdir)
>         rootdir->nid =3D (off - meta_offset) >> EROFS_ISLOTBITS;
>  }
>
> -
>  static int erofs_mkfs_handle_symlink(struct erofs_inode *inode)
>  {
>         int ret =3D 0;
> @@ -1144,6 +1150,21 @@ static int erofs_mkfs_handle_file(struct erofs_ino=
de *inode)
>         return 0;
>  }
>
> +static int erofs_mkfs_issue_compress(struct erofs_inode *inode)
> +{
> +       if (!inode->i_size || S_ISLNK(inode->i_mode))

missing cfg.c_chunkbits here.
Other than that,  it looks good to me.

Thanks,
Jianan

> +               return 0;
> +
> +       if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode))=
 {
> +               int fd =3D open(inode->i_srcpath, O_RDONLY | O_BINARY);
> +               if (fd < 0)
> +                       return -errno;
> +               return erofs_write_compressed_file(inode, fd, 0);
> +       }
> +
> +       return 0;
> +}
> +
>  static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
>                                  struct list_head *dirs)
>  {
> @@ -1153,6 +1174,14 @@ static int erofs_mkfs_handle_dir(struct erofs_inod=
e *dir,
>         struct erofs_dentry *d;
>         unsigned int nr_subdirs =3D 0, i_nlink;
>
> +       ret =3D erofs_scan_file_xattrs(dir);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D erofs_prepare_xattr_ibody(dir);
> +       if (ret < 0)
> +               return ret;
> +
>         _dir =3D opendir(dir->i_srcpath);
>         if (!_dir) {
>                 erofs_err("failed to opendir at %s: %s",
> @@ -1160,7 +1189,6 @@ static int erofs_mkfs_handle_dir(struct erofs_inode=
 *dir,
>                 return -errno;
>         }
>
> -       nr_subdirs =3D 0;
>         while (1) {
>                 /*
>                  * set errno to 0 before calling readdir() in order to
> @@ -1196,13 +1224,15 @@ static int erofs_mkfs_handle_dir(struct erofs_ino=
de *dir,
>         if (ret)
>                 return ret;
>
> -       ret =3D erofs_prepare_inode_buffer(dir);
> -       if (ret)
> -               return ret;
> -       dir->bh->op =3D &erofs_skip_write_bhops;
> +       if (!z_erofs_mt_enabled) {
> +               ret =3D erofs_prepare_inode_buffer(dir);
> +               if (ret)
> +                       return ret;
> +               dir->bh->op =3D &erofs_skip_write_bhops;
>
> -       if (IS_ROOT(dir))
> -               erofs_fixup_meta_blkaddr(dir);
> +               if (IS_ROOT(dir))
> +                       erofs_fixup_meta_blkaddr(dir);
> +       }
>
>         i_nlink =3D 0;
>         list_for_each_entry(d, &dir->i_subdirs, d_child) {
> @@ -1302,11 +1332,13 @@ static int erofs_mkfs_build_tree(struct erofs_ino=
de *dir,
>
>         if (S_ISDIR(dir->i_mode))
>                 return erofs_mkfs_handle_dir(dir, dirs);
> +       else if (z_erofs_mt_enabled)
> +               return erofs_mkfs_issue_compress(dir);
>         else
>                 return erofs_mkfs_handle_file(dir);
>  }
>
> -struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> +struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path)
>  {
>         LIST_HEAD(dirs);
>         struct erofs_inode *inode, *root, *dumpdir;
> @@ -1327,7 +1359,8 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path=
(const char *path)
>                 list_del(&inode->i_subdirs);
>                 init_list_head(&inode->i_subdirs);
>
> -               erofs_mkfs_print_progressinfo(inode);
> +               if (!z_erofs_mt_enabled)
> +                       erofs_mkfs_print_progressinfo(inode);
>
>                 err =3D erofs_mkfs_build_tree(inode, &dirs);
>                 if (err) {
> @@ -1335,15 +1368,212 @@ struct erofs_inode *erofs_mkfs_build_tree_from_p=
ath(const char *path)
>                         break;
>                 }
>
> +               if (!z_erofs_mt_enabled) {
> +                       if (S_ISDIR(inode->i_mode)) {
> +                               inode->next_dirwrite =3D dumpdir;
> +                               dumpdir =3D inode;
> +                       } else {
> +                               erofs_iput(inode);
> +                       }
> +               } else {
> +                       erofs_push_inode_fifo(z_erofs_mt_inode_fifo, &ino=
de);
> +               }
> +       } while (!list_empty(&dirs));
> +
> +       if (!z_erofs_mt_enabled)
> +               erofs_mkfs_dumpdir(dumpdir);
> +       else
> +               erofs_push_inode_fifo(z_erofs_mt_inode_fifo, &dumpdir);
> +
> +       return root;
> +}
> +
> +#ifdef EROFS_MT_ENABLED
> +pthread_t z_erofs_mt_traverser;
> +
> +void *z_erofs_mt_traverse_task(void *path)
> +{
> +       pthread_exit((void *)__erofs_mkfs_build_tree_from_path(path));
> +}
> +
> +static int z_erofs_mt_reap_compressed(struct erofs_inode *inode)
> +{
> +       struct z_erofs_mt_file *desc =3D inode->mt_desc;
> +       int fd =3D desc->fd;
> +       int ret =3D 0;
> +
> +       pthread_mutex_lock(&desc->mutex);
> +       while (desc->nfini !=3D desc->total)
> +               pthread_cond_wait(&desc->cond, &desc->mutex);
> +       pthread_mutex_unlock(&desc->mutex);
> +
> +       ret =3D z_erofs_mt_reap(desc);
> +       if (ret =3D=3D -ENOSPC) {
> +               ret =3D lseek(fd, 0, SEEK_SET);
> +               if (ret < 0)
> +                       return -errno;
> +
> +               ret =3D write_uncompressed_file_from_fd(inode, fd);
> +       }
> +
> +       close(fd);
> +       return ret;
> +}
> +
> +static int z_erofs_mt_reap_inodes()
> +{
> +       struct erofs_inode *inode, *dumpdir;
> +       int ret =3D 0;
> +
> +       dumpdir =3D NULL;
> +       while (true) {
> +               inode =3D *(struct erofs_inode **)erofs_pop_inode_fifo(
> +                       z_erofs_mt_inode_fifo);
> +               if (!inode)
> +                       break;
> +
> +               erofs_mkfs_print_progressinfo(inode);
> +
>                 if (S_ISDIR(inode->i_mode)) {
> +                       ret =3D erofs_prepare_inode_buffer(inode);
> +                       if (ret)
> +                               goto out;
> +                       inode->bh->op =3D &erofs_skip_write_bhops;
> +
> +                       if (IS_ROOT(inode))
> +                               erofs_fixup_meta_blkaddr(inode);
> +
>                         inode->next_dirwrite =3D dumpdir;
>                         dumpdir =3D inode;
> +                       continue;
> +               }
> +
> +               if (inode->mt_desc) {
> +                       ret =3D z_erofs_mt_reap_compressed(inode);
> +               } else if (S_ISLNK(inode->i_mode)) {
> +                       ret =3D erofs_mkfs_handle_symlink(inode);
> +               } else if (!inode->i_size) {
> +                       ret =3D 0;
>                 } else {
> -                       erofs_iput(inode);
> +                       int fd =3D open(inode->i_srcpath, O_RDONLY | O_BI=
NARY);
> +                       if (fd < 0)
> +                               return -errno;
> +
> +                       if (cfg.c_chunkbits)
> +                               ret =3D erofs_write_chunked_file(inode, f=
d, 0);
> +                       else
> +                               ret =3D write_uncompressed_file_from_fd(i=
node,
> +                                                                     fd)=
;
> +                       close(fd);
>                 }
> -       } while (!list_empty(&dirs));
> +               if (ret)
> +                       goto out;
> +
> +               erofs_prepare_inode_buffer(inode);
> +               erofs_write_tail_end(inode);
> +               erofs_iput(inode);
> +       }
>
>         erofs_mkfs_dumpdir(dumpdir);
> +
> +out:
> +       return ret;
> +}
> +
> +struct erofs_inode_fifo *erofs_alloc_inode_fifo(size_t size, size_t elem=
_size)
> +{
> +       struct erofs_inode_fifo *q =3D malloc(sizeof(*q));
> +
> +       pthread_mutex_init(&q->lock, NULL);
> +       pthread_cond_init(&q->empty, NULL);
> +       pthread_cond_init(&q->full, NULL);
> +
> +       q->size =3D size;
> +       q->elem_size =3D elem_size;
> +       q->head =3D 0;
> +       q->tail =3D 0;
> +       q->buf =3D calloc(size, elem_size);
> +       if (!q->buf)
> +               return ERR_PTR(-ENOMEM);
> +
> +       return q;
> +}
> +
> +void erofs_push_inode_fifo(struct erofs_inode_fifo *q, void *elem)
> +{
> +       pthread_mutex_lock(&q->lock);
> +
> +       while ((q->tail + 1) % q->size =3D=3D q->head)
> +               pthread_cond_wait(&q->full, &q->lock);
> +
> +       memcpy(q->buf + q->tail * q->elem_size, elem, q->elem_size);
> +       q->tail =3D (q->tail + 1) % q->size;
> +
> +       pthread_cond_signal(&q->empty);
> +       pthread_mutex_unlock(&q->lock);
> +}
> +
> +void *erofs_pop_inode_fifo(struct erofs_inode_fifo *q)
> +{
> +       void *elem;
> +
> +       pthread_mutex_lock(&q->lock);
> +
> +       while (q->head =3D=3D q->tail)
> +               pthread_cond_wait(&q->empty, &q->lock);
> +
> +       elem =3D q->buf + q->head * q->elem_size;
> +       q->head =3D (q->head + 1) % q->size;
> +
> +       pthread_cond_signal(&q->full);
> +       pthread_mutex_unlock(&q->lock);
> +
> +       return elem;
> +}
> +
> +void erofs_destroy_inode_fifo(struct erofs_inode_fifo *q)
> +{
> +       pthread_mutex_destroy(&q->lock);
> +       pthread_cond_destroy(&q->empty);
> +       pthread_cond_destroy(&q->full);
> +       free(q->buf);
> +       free(q);
> +}
> +
> +#endif
> +
> +struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> +{
> +#ifdef EROFS_MT_ENABLED
> +       int err;
> +#endif
> +       struct erofs_inode *root =3D NULL;
> +
> +       if (!z_erofs_mt_enabled)
> +               return __erofs_mkfs_build_tree_from_path(path);
> +
> +#ifdef EROFS_MT_ENABLED
> +       z_erofs_mt_inode_fifo =3D erofs_alloc_inode_fifo(
> +               EROFS_MT_QUEUE_SIZE, sizeof(struct erofs_inode *));
> +       if (IS_ERR(z_erofs_mt_inode_fifo))
> +               return ERR_CAST(z_erofs_mt_inode_fifo);
> +
> +       err =3D pthread_create(&z_erofs_mt_traverser, NULL,
> +                            z_erofs_mt_traverse_task, (void *)path);
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       err =3D z_erofs_mt_reap_inodes();
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       err =3D pthread_join(z_erofs_mt_traverser, (void *)&root);
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       erofs_destroy_inode_fifo(z_erofs_mt_inode_fifo);
> +#endif
> +
>         return root;
>  }
>
> --
> 2.44.0
>
