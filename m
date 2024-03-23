Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7978876FA
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 05:03:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H7lhPxYI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1lsh5sLFz3cCx
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 15:03:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H7lhPxYI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1lsY4rGsz3bn8
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Mar 2024 15:02:56 +1100 (AEDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so2735796276.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 21:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711166573; x=1711771373; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySOxvTh0d6obpDfncP+Ch0F4/D0sUIkcr+TFzg3TLXM=;
        b=H7lhPxYIob/M0hBfmLtJf+Aeoo2r8jsDAU2jzKgBqDEQhv89518p9cqak8s8594Hn4
         hBqCi5mJGNJU49RmEKMkcuj6louh3mFAXsnXXrz5bPjqKKDMtW5Va217mJvdSZwVF8eC
         jxDxxMPJV8wXaxC+tbRAfNZtmtZxUq9chSUQuCj6vzLoa+YvAXaMqZ1RLmDpNDDjxisg
         slQpnxwXV66QchpxO50TV9jDBaQF665eSUspZ6KsaCGGvdIYhGpZBvJzDN1sGejjfRan
         HXG9fk93ilt0Y/wehiBrayjprlx1tycUDxQ9LLv2WMRExXxv4nQBWfqTM9sScOMnNQoT
         12LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711166573; x=1711771373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySOxvTh0d6obpDfncP+Ch0F4/D0sUIkcr+TFzg3TLXM=;
        b=lV28t3hDyaPdNsGVeviA/v5AKQU0ArJde4jke/QyJaL0Xt65ypJK8tBYwnR4pY1czn
         ZwQmXtOFPhT6vfPmZevOVbIN/MxOnyU9PgpIDiZ90GCa1JAzP8RKnvm47gUSlL2QfSEH
         j1LW2WuGriYFzTNn7Q7MjemWFgZ9kg4TktH8MuoBWx10AfEmodpXIhqxDeZj596q/oNK
         qB8mE/al/gMazEHMOhjAR1PJDqpFatxXYvfliTIHgQryQmhVY38MVIf+bq8/yoffH2Wo
         Is5gF143OcHlJBgTdAsrLCAo3aYHiTvAlWLPmVAfga246c/6MsCLTGRosGtVCQs5GVPV
         cS1g==
X-Gm-Message-State: AOJu0Yx4v6Bl85X7AS0pbn7rA5DjW6+/hL+0MuwpBVKjSQ+IvC8sFvbk
	EEZV8Q9SUwhhXcGXc5zKrGLSb1MpGkzCl0Meqz2IcNp7FrWg64/1lVdes78mzZmKYqVFC4phv1o
	XOpDLtod9f9xIuDIJW8AXrHSU2ZA=
X-Google-Smtp-Source: AGHT+IHX7gt0IcTVSYT2uODnFuTCUQqFJp1vn1ZFfMJlRZGtzKcOgXO4xjP1RHcmcrTHXpde9G4Ukcgc8YMCGza0Ubo=
X-Received: by 2002:a25:dc94:0:b0:dc6:bbbc:80e4 with SMTP id
 y142-20020a25dc94000000b00dc6bbbc80e4mr1082891ybe.4.1711166572399; Fri, 22
 Mar 2024 21:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240322102421.3780992-1-zhaoyifan@sjtu.edu.cn>
 <20240322102421.3780992-3-zhaoyifan@sjtu.edu.cn> <CAJfKizooP=XdYfNawzJRBmJYS2j5v=pvkGbj5EXcD-wihEGKtw@mail.gmail.com>
In-Reply-To: <CAJfKizooP=XdYfNawzJRBmJYS2j5v=pvkGbj5EXcD-wihEGKtw@mail.gmail.com>
From: Huang Jianan <jnhuang95@gmail.com>
Date: Sat, 23 Mar 2024 12:02:39 +0800
Message-ID: <CAJfKizqFcxHc9O-nJn+2uOG5Jm7qsQa4cAjyJw3ew7KoZ_i5Sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] erofs-utils: mkfs: introduce inter-file
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

Huang Jianan <jnhuang95@gmail.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8823=E6=97=
=A5=E5=91=A8=E5=85=AD 11:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Yifan Zhao <zhaoyifan@sjtu.edu.cn> =E4=BA=8E2024=E5=B9=B43=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=94 18:25=E5=86=99=E9=81=93=EF=BC=9A
> >
> > This patch allows parallelizing the compression process of different
> > files in mkfs. Specifically, a traverser thread traverses the files and
> > issues the compression task, which is handled by the workers. Then, the
> > main thread consumes them and writes the compressed data to the device.
> >
> > To this end, the logic of erofs_write_compressed_file() has been
> > modified to split the creation and completion logic of the compression
> > task.
> >
> > Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> > Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
> > ---
> >  include/erofs/compress.h |  16 ++
> >  include/erofs/inode.h    |  17 ++
> >  include/erofs/internal.h |   3 +
> >  lib/compress.c           | 336 +++++++++++++++++++++++++--------------
> >  lib/inode.c              | 258 ++++++++++++++++++++++++++++--
> >  5 files changed, 503 insertions(+), 127 deletions(-)
> >
> > diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> > index 871db54..8d5a54b 100644
> > --- a/include/erofs/compress.h
> > +++ b/include/erofs/compress.h
> > @@ -17,6 +17,22 @@ extern "C"
> >  #define EROFS_CONFIG_COMPR_MAX_SZ      (4000 * 1024)
> >  #define Z_EROFS_COMPR_QUEUE_SZ         (EROFS_CONFIG_COMPR_MAX_SZ * 2)
> >
> > +#ifdef EROFS_MT_ENABLED
> > +struct z_erofs_mt_file {
> > +       pthread_mutex_t mutex;
> > +       pthread_cond_t cond;
> > +       int total;
> > +       int nfini;
> > +
> > +       int fd;
> > +       struct erofs_compress_work *head;
> > +
> > +       struct z_erofs_mt_file *next;
> > +};
> > +
> > +int z_erofs_mt_reap(struct z_erofs_mt_file *desc);
> > +#endif
> > +
> >  void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
> >  int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64=
 fpos);
> >
> > diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> > index d5a732a..101ff59 100644
> > --- a/include/erofs/inode.h
> > +++ b/include/erofs/inode.h
> > @@ -41,6 +41,23 @@ struct erofs_inode *erofs_new_inode(void);
> >  struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
> >  struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const cha=
r *name);
> >
> > +#ifdef EROFS_MT_ENABLED
> > +struct erofs_inode_fifo {
> > +       pthread_mutex_t lock;
> > +       pthread_cond_t full, empty;
> > +
> > +       void *buf;
> > +
> > +       size_t size, elem_size;
> > +       size_t head, tail;
> > +};
> > +
> > +struct erofs_inode_fifo *erofs_alloc_inode_fifo(size_t size, size_t el=
em_size);
> > +void erofs_push_inode_fifo(struct erofs_inode_fifo *q, void *elem);
> > +void *erofs_pop_inode_fifo(struct erofs_inode_fifo *q);
> > +void erofs_destroy_inode_fifo(struct erofs_inode_fifo *q);
> > +#endif
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 4cd2059..2580588 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -250,6 +250,9 @@ struct erofs_inode {
> >  #ifdef WITH_ANDROID
> >         uint64_t capabilities;
> >  #endif
> > +#ifdef EROFS_MT_ENABLED
> > +       struct z_erofs_mt_file *mt_desc;
> > +#endif
> >  };
> >
> >  static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
> > diff --git a/lib/compress.c b/lib/compress.c
> > index e064293..d89e404 100644
> > --- a/lib/compress.c
> > +++ b/lib/compress.c
> > @@ -85,6 +85,7 @@ struct erofs_compress_work {
> >         struct erofs_work work;
> >         struct z_erofs_compress_sctx ctx;
> >         struct erofs_compress_work *next;
> > +       struct z_erofs_mt_file *mtfile_desc;
> >
> >         unsigned int alg_id;
> >         char *alg_name;
> > @@ -96,14 +97,14 @@ struct erofs_compress_work {
> >
> >  static struct {
> >         struct erofs_workqueue wq;
> > -       struct erofs_compress_work *idle;
> > -       pthread_mutex_t mutex;
> > -       pthread_cond_t cond;
> > -       int nfini;
> > +       struct erofs_compress_work *work_idle;
> > +       pthread_mutex_t work_mutex;
> > +       struct z_erofs_mt_file *file_idle;
> > +       pthread_mutex_t file_mutex;
> >  } z_erofs_mt_ctrl;
> >  #endif
> >
> > -static bool z_erofs_mt_enabled;
> > +bool z_erofs_mt_enabled;
> >
> >  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE Z_EROFS_FULL_INDEX_ALIGN(0)
> >
> > @@ -1025,6 +1026,90 @@ int z_erofs_compress_segment(struct z_erofs_comp=
ress_sctx *ctx,
> >         return 0;
> >  }
> >
> > +int z_erofs_finalize_compression(struct z_erofs_compress_ictx *ictx,
> > +                                struct erofs_buffer_head *bh,
> > +                                erofs_blk_t blkaddr,
> > +                                erofs_blk_t compressed_blocks)
> > +{
> > +       struct erofs_inode *inode =3D ictx->inode;
> > +       struct erofs_sb_info *sbi =3D inode->sbi;
> > +       u8 *compressmeta =3D ictx->metacur - Z_EROFS_LEGACY_MAP_HEADER_=
SIZE;
> > +       unsigned int legacymetasize;
> > +       int ret =3D 0;
> > +
> > +       /* fall back to no compression mode */
> > +       DBG_BUGON(compressed_blocks < !!inode->idata_size);
> > +       compressed_blocks -=3D !!inode->idata_size;
> > +
> > +       z_erofs_write_indexes(ictx);
> > +       legacymetasize =3D ictx->metacur - compressmeta;
> > +       /* estimate if data compression saves space or not */
> > +       if (!inode->fragment_size &&
> > +           compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
> > +           legacymetasize >=3D inode->i_size) {
> > +               z_erofs_dedupe_commit(true);
> > +
> > +               if (inode->idata) {
> > +                       free(inode->idata);
> > +                       inode->idata =3D NULL;
> > +               }
> > +               erofs_bdrop(bh, true); /* revoke buffer */
> > +               free(compressmeta);
> > +               inode->compressmeta =3D NULL;
> > +
> > +               return -ENOSPC;
> > +       }
> > +       z_erofs_dedupe_commit(false);
> > +       z_erofs_write_mapheader(inode, compressmeta);
> > +
> > +       if (!ictx->fragemitted)
> > +               sbi->saved_by_deduplication +=3D inode->fragment_size;
> > +
> > +       /* if the entire file is a fragment, a simplified form is used.=
 */
> > +       if (inode->i_size <=3D inode->fragment_size) {
> > +               DBG_BUGON(inode->i_size < inode->fragment_size);
> > +               DBG_BUGON(inode->fragmentoff >> 63);
> > +               *(__le64 *)compressmeta =3D
> > +                       cpu_to_le64(inode->fragmentoff | 1ULL << 63);
> > +               inode->datalayout =3D EROFS_INODE_COMPRESSED_FULL;
> > +               legacymetasize =3D Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> > +       }
> > +
> > +       if (compressed_blocks) {
> > +               ret =3D erofs_bh_balloon(bh, erofs_pos(sbi, compressed_=
blocks));
> > +               DBG_BUGON(ret !=3D erofs_blksiz(sbi));
> > +       } else {
> > +               if (!cfg.c_fragments && !cfg.c_dedupe)
> > +                       DBG_BUGON(!inode->idata_size);
> > +       }
> > +
> > +       erofs_info("compressed %s (%llu bytes) into %u blocks",
> > +                  inode->i_srcpath, (unsigned long long)inode->i_size,
> > +                  compressed_blocks);
> > +
> > +       if (inode->idata_size) {
> > +               bh->op =3D &erofs_skip_write_bhops;
> > +               inode->bh_data =3D bh;
> > +       } else {
> > +               erofs_bdrop(bh, false);
> > +       }
> > +
> > +       inode->u.i_blocks =3D compressed_blocks;
> > +
> > +       if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_FULL) {
> > +               inode->extent_isize =3D legacymetasize;
> > +       } else {
> > +               ret =3D z_erofs_convert_to_compacted_format(inode, blka=
ddr,
> > +                                                         legacymetasiz=
e,
> > +                                                         compressmeta)=
;
> > +               DBG_BUGON(ret);
> > +       }
> > +       inode->compressmeta =3D compressmeta;
> > +       if (!erofs_is_packed_inode(inode))
> > +               erofs_droid_blocklist_write(inode, blkaddr, compressed_=
blocks);
> > +       return 0;
> > +}
> > +
> >  #ifdef EROFS_MT_ENABLED
> >  void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
> >  {
> > @@ -1099,6 +1184,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, v=
oid *tlsp)
> >         struct erofs_compress_work *cwork =3D (struct erofs_compress_wo=
rk *)work;
> >         struct erofs_compress_wq_tls *tls =3D tlsp;
> >         struct z_erofs_compress_sctx *sctx =3D &cwork->ctx;
> > +       struct z_erofs_mt_file *mtfile_desc =3D cwork->mtfile_desc;
> >         struct erofs_sb_info *sbi =3D sctx->ictx->inode->sbi;
> >         int ret =3D 0;
> >
> > @@ -1124,10 +1210,10 @@ void z_erofs_mt_workfn(struct erofs_work *work,=
 void *tlsp)
> >
> >  out:
> >         cwork->errcode =3D ret;
> > -       pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> > -       ++z_erofs_mt_ctrl.nfini;
> > -       pthread_cond_signal(&z_erofs_mt_ctrl.cond);
> > -       pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> > +       pthread_mutex_lock(&mtfile_desc->mutex);
> > +       ++mtfile_desc->nfini;
> > +       pthread_cond_signal(&mtfile_desc->cond);
> > +       pthread_mutex_unlock(&mtfile_desc->mutex);
> >  }
> >
> >  int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
> > @@ -1161,27 +1247,60 @@ int z_erofs_merge_segment(struct z_erofs_compre=
ss_ictx *ictx,
> >  }
> >
> >  int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
> > -                       struct erofs_compress_cfg *ccfg,
> > -                       erofs_blk_t blkaddr,
> > -                       erofs_blk_t *compressed_blocks)
> > +                       struct erofs_compress_cfg *ccfg)
> >  {
> >         struct erofs_compress_work *cur, *head =3D NULL, **last =3D &he=
ad;
> >         struct erofs_inode *inode =3D ictx->inode;
> > +       struct z_erofs_mt_file *mtfile_desc =3D NULL;
> >         int nsegs =3D DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
> > -       int ret, i;
> > +       int i;
> >
> > -       z_erofs_mt_ctrl.nfini =3D 0;
> > +       pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
> > +       if (z_erofs_mt_ctrl.file_idle) {
> > +               mtfile_desc =3D z_erofs_mt_ctrl.file_idle;
> > +               z_erofs_mt_ctrl.file_idle =3D mtfile_desc->next;
> > +               mtfile_desc->next =3D NULL;
> > +       }
> > +       pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> > +       if (!mtfile_desc) {
> > +               mtfile_desc =3D calloc(1, sizeof(*mtfile_desc));
> > +               if (!mtfile_desc) {
> > +                       return -ENOMEM;
> > +               }
> > +       }
> > +       inode->mt_desc =3D mtfile_desc;
> > +
> > +       mtfile_desc->fd =3D ictx->fd;
> > +       mtfile_desc->total =3D nsegs;
> > +       mtfile_desc->nfini =3D 0;
> > +       pthread_mutex_init(&mtfile_desc->mutex, NULL);
> > +       pthread_cond_init(&mtfile_desc->cond, NULL);
> >
> >         for (i =3D 0; i < nsegs; i++) {
> > -               if (z_erofs_mt_ctrl.idle) {
> > -                       cur =3D z_erofs_mt_ctrl.idle;
> > -                       z_erofs_mt_ctrl.idle =3D cur->next;
> > +               cur =3D NULL;
> > +
> > +               pthread_mutex_lock(&z_erofs_mt_ctrl.work_mutex);
> > +               if (z_erofs_mt_ctrl.work_idle) {
> > +                       cur =3D z_erofs_mt_ctrl.work_idle;
> > +                       z_erofs_mt_ctrl.work_idle =3D cur->next;
> >                         cur->next =3D NULL;
> > -               } else {
> > +               }
> > +               pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
> > +               if (!cur) {
> >                         cur =3D calloc(1, sizeof(*cur));
> > -                       if (!cur)
> > +                       if (!cur) {
> > +                               while (head) {
> > +                                       cur =3D head;
> > +                                       head =3D cur->next;
> > +                                       free(cur);
> > +                               }
> > +                               free(mtfile_desc);
> >                                 return -ENOMEM;
> > +                       }
> >                 }
> > +
> > +               if (i =3D=3D 0)
> > +                       mtfile_desc->head =3D cur;
> >                 *last =3D cur;
> >                 last =3D &cur->next;
> >
> > @@ -1205,21 +1324,29 @@ int z_erofs_mt_compress(struct z_erofs_compress=
_ictx *ictx,
> >                 cur->comp_level =3D ccfg->handle.compression_level;
> >                 cur->dict_size =3D ccfg->handle.dict_size;
> >
> > +               cur->mtfile_desc =3D mtfile_desc;
> >                 cur->work.fn =3D z_erofs_mt_workfn;
> >                 erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
> >         }
> >
> > -       pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> > -       while (z_erofs_mt_ctrl.nfini !=3D nsegs)
> > -               pthread_cond_wait(&z_erofs_mt_ctrl.cond,
> > -                                 &z_erofs_mt_ctrl.mutex);
> > -       pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> > +       return 0;
> > +}
> >
> > -       ret =3D 0;
> > -       while (head) {
> > -               cur =3D head;
> > -               head =3D cur->next;
> > +int z_erofs_mt_reap(struct z_erofs_mt_file *desc) {
> > +       struct erofs_buffer_head *bh =3D NULL;
> > +       struct erofs_compress_work *cur =3D desc->head, *tmp;
> > +       struct z_erofs_compress_ictx *ictx =3D cur->ctx.ictx;
> > +       erofs_blk_t blkaddr, compressed_blocks =3D 0;
> > +       int ret =3D 0;
> >
> > +       bh =3D erofs_balloc(DATA, 0, 0, 0);
> > +       if (IS_ERR(bh)) {
> > +               ret =3D PTR_ERR(bh);
> > +               goto out;
> > +       }
> > +       blkaddr =3D erofs_mapbh(bh->block);
> > +
> > +       while (cur) {
> >                 if (cur->errcode) {
> >                         ret =3D cur->errcode;
> >                 } else {
> > @@ -1230,13 +1357,30 @@ int z_erofs_mt_compress(struct z_erofs_compress=
_ictx *ictx,
> >                         if (ret2)
> >                                 ret =3D ret2;
> >
> > -                       *compressed_blocks +=3D cur->ctx.blkaddr - blka=
ddr;
> > +                       compressed_blocks +=3D cur->ctx.blkaddr - blkad=
dr;
> >                         blkaddr =3D cur->ctx.blkaddr;
> >                 }
> >
> > -               cur->next =3D z_erofs_mt_ctrl.idle;
> > -               z_erofs_mt_ctrl.idle =3D cur;
> > +               tmp =3D cur->next;
> > +               pthread_mutex_lock(&z_erofs_mt_ctrl.work_mutex);
> > +               cur->next =3D z_erofs_mt_ctrl.work_idle;
> > +               z_erofs_mt_ctrl.work_idle =3D cur;
> > +               pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
> > +               cur =3D tmp;
> >         }
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret =3D z_erofs_finalize_compression(
> > +               ictx, bh, blkaddr - compressed_blocks, compressed_block=
s);
> > +
> > +out:
> > +       free(ictx);
> > +       pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
> > +       desc->next =3D z_erofs_mt_ctrl.file_idle;
> > +       z_erofs_mt_ctrl.file_idle =3D desc;
> > +       pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> > +
> >         return ret;
> >  }
> >  #endif
> > @@ -1249,9 +1393,7 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd, u64 fpos)
> >         static struct z_erofs_compress_sctx sctx;
> >         struct erofs_compress_cfg *ccfg;
> >         erofs_blk_t blkaddr, compressed_blocks =3D 0;
> > -       unsigned int legacymetasize;
> >         int ret;
> > -       bool ismt =3D false;
> >         struct erofs_sb_info *sbi =3D inode->sbi;
> >         u8 *compressmeta =3D malloc(BLK_ROUND_UP(sbi, inode->i_size) *
> >                                   sizeof(struct z_erofs_lcluster_index)=
 +
> > @@ -1260,11 +1402,17 @@ int erofs_write_compressed_file(struct erofs_in=
ode *inode, int fd, u64 fpos)
> >         if (!compressmeta)
> >                 return -ENOMEM;
> >
> > -       /* allocate main data buffer */
> > -       bh =3D erofs_balloc(DATA, 0, 0, 0);
> > -       if (IS_ERR(bh)) {
> > -               ret =3D PTR_ERR(bh);
> > -               goto err_free_meta;
> > +       if (!z_erofs_mt_enabled) {
> > +               /* allocate main data buffer */
> > +               bh =3D erofs_balloc(DATA, 0, 0, 0);
> > +               if (IS_ERR(bh)) {
> > +                       ret =3D PTR_ERR(bh);
> > +                       goto err_free_meta;
> > +               }
> > +               blkaddr =3D erofs_mapbh(bh->block); /* start_blkaddr */
> > +       } else {
> > +               bh =3D NULL;
> > +               blkaddr =3D EROFS_NULL_ADDR;
> >         }
> >
> >         /* initialize per-file compression setting */
> > @@ -1313,7 +1461,6 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd, u64 fpos)
> >                         goto err_bdrop;
> >         }
> >
> > -       blkaddr =3D erofs_mapbh(bh->block);       /* start_blkaddr */
> >         ctx.inode =3D inode;
> >         ctx.pclustersize =3D z_erofs_get_max_pclustersize(inode);
> >         ctx.fd =3D fd;
> > @@ -1331,11 +1478,24 @@ int erofs_write_compressed_file(struct erofs_in=
ode *inode, int fd, u64 fpos)
> >                 if (ret)
> >                         goto err_free_idata;
> >  #ifdef EROFS_MT_ENABLED
> > -       } else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_=
size) {
> > -               ismt =3D true;
> > -               ret =3D z_erofs_mt_compress(&ctx, ccfg, blkaddr, &compr=
essed_blocks);
> > -               if (ret)
> > +       } else if (z_erofs_mt_enabled) {
> > +               struct z_erofs_compress_ictx *l_ictx;
> > +
> > +               l_ictx =3D malloc(sizeof(*l_ictx));
> > +               if (!l_ictx) {
> > +                       ret =3D -ENOMEM;
> >                         goto err_free_idata;
> > +               }
> > +
> > +               memcpy(l_ictx, &ctx, sizeof(*l_ictx));
> > +               init_list_head(&l_ictx->extents);
> > +
> > +               ret =3D z_erofs_mt_compress(l_ictx, ccfg);
> > +               if (ret) {
> > +                       free(l_ictx);
> > +                       goto err_free_idata;
> > +               }
> > +               return 0;
> >  #endif
> >         } else {
> >                 sctx.queue =3D g_queue;
> > @@ -1352,10 +1512,6 @@ int erofs_write_compressed_file(struct erofs_ino=
de *inode, int fd, u64 fpos)
> >                 compressed_blocks =3D sctx.blkaddr - blkaddr;
> >         }
> >
> > -       /* fall back to no compression mode */
> > -       DBG_BUGON(compressed_blocks < !!inode->idata_size);
> > -       compressed_blocks -=3D !!inode->idata_size;
> > -
> >         /* generate an extent for the deduplicated fragment */
> >         if (inode->fragment_size && !ctx.fragemitted) {
> >                 struct z_erofs_extent_item *ei;
> > @@ -1377,69 +1533,10 @@ int erofs_write_compressed_file(struct erofs_in=
ode *inode, int fd, u64 fpos)
> >                 z_erofs_commit_extent(&sctx, ei);
> >         }
> >         z_erofs_fragments_commit(inode);
> > +       list_splice_tail(&sctx.extents, &ctx.extents);
> >
> > -       if (!ismt)
> > -               list_splice_tail(&sctx.extents, &ctx.extents);
> > -
> > -       z_erofs_write_indexes(&ctx);
> > -       legacymetasize =3D ctx.metacur - compressmeta;
> > -       /* estimate if data compression saves space or not */
> > -       if (!inode->fragment_size &&
> > -           compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
> > -           legacymetasize >=3D inode->i_size) {
> > -               z_erofs_dedupe_commit(true);
> > -               ret =3D -ENOSPC;
> > -               goto err_free_idata;
> > -       }
> > -       z_erofs_dedupe_commit(false);
> > -       z_erofs_write_mapheader(inode, compressmeta);
> > -
> > -       if (!ctx.fragemitted)
> > -               sbi->saved_by_deduplication +=3D inode->fragment_size;
> > -
> > -       /* if the entire file is a fragment, a simplified form is used.=
 */
> > -       if (inode->i_size <=3D inode->fragment_size) {
> > -               DBG_BUGON(inode->i_size < inode->fragment_size);
> > -               DBG_BUGON(inode->fragmentoff >> 63);
> > -               *(__le64 *)compressmeta =3D
> > -                       cpu_to_le64(inode->fragmentoff | 1ULL << 63);
> > -               inode->datalayout =3D EROFS_INODE_COMPRESSED_FULL;
> > -               legacymetasize =3D Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> > -       }
> > -
> > -       if (compressed_blocks) {
> > -               ret =3D erofs_bh_balloon(bh, erofs_pos(sbi, compressed_=
blocks));
> > -               DBG_BUGON(ret !=3D erofs_blksiz(sbi));
> > -       } else {
> > -               if (!cfg.c_fragments && !cfg.c_dedupe)
> > -                       DBG_BUGON(!inode->idata_size);
> > -       }
> > -
> > -       erofs_info("compressed %s (%llu bytes) into %u blocks",
> > -                  inode->i_srcpath, (unsigned long long)inode->i_size,
> > -                  compressed_blocks);
> > -
> > -       if (inode->idata_size) {
> > -               bh->op =3D &erofs_skip_write_bhops;
> > -               inode->bh_data =3D bh;
> > -       } else {
> > -               erofs_bdrop(bh, false);
> > -       }
> > -
> > -       inode->u.i_blocks =3D compressed_blocks;
> > -
> > -       if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_FULL) {
> > -               inode->extent_isize =3D legacymetasize;
> > -       } else {
> > -               ret =3D z_erofs_convert_to_compacted_format(inode, blka=
ddr,
> > -                                                         legacymetasiz=
e,
> > -                                                         compressmeta)=
;
> > -               DBG_BUGON(ret);
> > -       }
> > -       inode->compressmeta =3D compressmeta;
> > -       if (!erofs_is_packed_inode(inode))
> > -               erofs_droid_blocklist_write(inode, blkaddr, compressed_=
blocks);
> > -       return 0;
> > +       return z_erofs_finalize_compression(&ctx, bh, blkaddr,
> > +                                           compressed_blocks);
> >
> >  err_free_idata:
> >         if (inode->idata) {
> > @@ -1447,7 +1544,8 @@ err_free_idata:
> >                 inode->idata =3D NULL;
> >         }
> >  err_bdrop:
> > -       erofs_bdrop(bh, true);  /* revoke buffer */
> > +       if (bh)
> > +               erofs_bdrop(bh, true);  /* revoke buffer */
> >  err_free_meta:
> >         free(compressmeta);
> >         inode->compressmeta =3D NULL;
> > @@ -1598,8 +1696,8 @@ int z_erofs_compress_init(struct erofs_sb_info *s=
bi, struct erofs_buffer_head *s
> >         z_erofs_mt_enabled =3D false;
> >  #ifdef EROFS_MT_ENABLED
> >         if (cfg.c_mt_workers > 1) {
> > -               pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
> > -               pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
> > +               pthread_mutex_init(&z_erofs_mt_ctrl.file_mutex, NULL);
> > +               pthread_mutex_init(&z_erofs_mt_ctrl.work_mutex, NULL);
> >                 ret =3D erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
> >                                             cfg.c_mt_workers,
> >                                             cfg.c_mt_workers << 2,
> > @@ -1626,11 +1724,17 @@ int z_erofs_compress_exit(void)
> >                 ret =3D erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
> >                 if (ret)
> >                         return ret;
> > -               while (z_erofs_mt_ctrl.idle) {
> > +               while (z_erofs_mt_ctrl.work_idle) {
> >                         struct erofs_compress_work *tmp =3D
> > -                               z_erofs_mt_ctrl.idle->next;
> > -                       free(z_erofs_mt_ctrl.idle);
> > -                       z_erofs_mt_ctrl.idle =3D tmp;
> > +                               z_erofs_mt_ctrl.work_idle->next;
> > +                       free(z_erofs_mt_ctrl.work_idle);
> > +                       z_erofs_mt_ctrl.work_idle =3D tmp;
> > +               }
> > +               while (z_erofs_mt_ctrl.file_idle) {
> > +                       struct z_erofs_mt_file *tmp =3D
> > +                               z_erofs_mt_ctrl.file_idle->next;
> > +                       free(z_erofs_mt_ctrl.file_idle);
> > +                       z_erofs_mt_ctrl.file_idle =3D tmp;
> >                 }
> >  #endif
> >         }
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 7dfb021..6d1faae 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -29,6 +29,8 @@
> >  #include "erofs/fragments.h"
> >  #include "liberofs_private.h"
> >
> > +extern bool z_erofs_mt_enabled;
> > +
> >  #define S_SHIFT                 12
> >  static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] =3D {
> >         [S_IFREG >> S_SHIFT]  =3D EROFS_FT_REG_FILE,
> > @@ -1036,6 +1038,9 @@ struct erofs_inode *erofs_new_inode(void)
> >         inode->i_ino[0] =3D sbi.inos++;   /* inode serial number */
> >         inode->i_count =3D 1;
> >         inode->datalayout =3D EROFS_INODE_FLAT_PLAIN;
> > +#ifdef EROFS_MT_ENABLED
> > +       inode->mt_desc =3D NULL;
> > +#endif
> >
> >         init_list_head(&inode->i_hash);
> >         init_list_head(&inode->i_subdirs);
> > @@ -1100,6 +1105,10 @@ static void erofs_fixup_meta_blkaddr(struct erof=
s_inode *rootdir)
> >         rootdir->nid =3D (off - meta_offset) >> EROFS_ISLOTBITS;
> >  }
> >
> > +#ifdef EROFS_MT_ENABLED
> > +#define EROFS_MT_QUEUE_SIZE 256
> > +struct erofs_inode_fifo *z_erofs_mt_queue;
> > +#endif
> >
> >  static int erofs_mkfs_handle_symlink(struct erofs_inode *inode)
> >  {
> > @@ -1143,6 +1152,21 @@ static int erofs_mkfs_handle_file(struct erofs_i=
node *inode)
> >         return 0;
> >  }
> >
> > +static int erofs_mkfs_issue_compress(struct erofs_inode *inode)
> > +{
> > +       if (!inode->i_size || S_ISLNK(inode->i_mode))
> > +               return 0;
> > +
> > +       if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode=
)) {
> > +               int fd =3D open(inode->i_srcpath, O_RDONLY | O_BINARY);
> > +               if (fd < 0)
> > +                       return -errno;
> > +               return erofs_write_compressed_file(inode, fd, 0);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
> >                                  struct list_head *dirs)
> >  {
> > @@ -1152,6 +1176,14 @@ static int erofs_mkfs_handle_dir(struct erofs_in=
ode *dir,
> >         struct erofs_dentry *d;
> >         unsigned int nr_subdirs =3D 0, i_nlink;
> >
> > +       ret =3D erofs_scan_file_xattrs(dir);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D erofs_prepare_xattr_ibody(dir);
> > +       if (ret < 0)
> > +               return ret;
> > +
> >         _dir =3D opendir(dir->i_srcpath);
> >         if (!_dir) {
> >                 erofs_err("failed to opendir at %s: %s",
> > @@ -1159,7 +1191,6 @@ static int erofs_mkfs_handle_dir(struct erofs_ino=
de *dir,
> >                 return -errno;
> >         }
> >
> > -       nr_subdirs =3D 0;
> >         while (1) {
> >                 /*
> >                  * set errno to 0 before calling readdir() in order to
> > @@ -1195,13 +1226,15 @@ static int erofs_mkfs_handle_dir(struct erofs_i=
node *dir,
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D erofs_prepare_inode_buffer(dir);
> > -       if (ret)
> > -               return ret;
> > -       dir->bh->op =3D &erofs_skip_write_bhops;
> > +       if (!z_erofs_mt_enabled) {
> > +               ret =3D erofs_prepare_inode_buffer(dir);
> > +               if (ret)
> > +                       return ret;
> > +               dir->bh->op =3D &erofs_skip_write_bhops;
> >
> > -       if (IS_ROOT(dir))
> > -               erofs_fixup_meta_blkaddr(dir);
> > +               if (IS_ROOT(dir))
> > +                       erofs_fixup_meta_blkaddr(dir);
> > +       }
> >
> >         i_nlink =3D 0;
> >         list_for_each_entry(d, &dir->i_subdirs, d_child) {
> > @@ -1300,11 +1333,13 @@ static int erofs_mkfs_build_tree(struct erofs_i=
node *dir,
> >
> >         if (S_ISDIR(dir->i_mode))
> >                 return erofs_mkfs_handle_dir(dir, dirs);
> > +       else if (z_erofs_mt_enabled)
> > +               return erofs_mkfs_issue_compress(dir);
> >         else
> >                 return erofs_mkfs_handle_file(dir);
> >  }
> >
> > -struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> > +struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path=
)
> >  {
> >         LIST_HEAD(dirs);
> >         struct erofs_inode *inode, *root, *dumpdir;
> > @@ -1325,7 +1360,8 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pa=
th(const char *path)
> >                 list_del(&inode->i_subdirs);
> >                 init_list_head(&inode->i_subdirs);
> >
> > -               erofs_mkfs_print_progressinfo(inode);
> > +               if (!z_erofs_mt_enabled)
> > +                       erofs_mkfs_print_progressinfo(inode);
> >
> >                 err =3D erofs_mkfs_build_tree(inode, &dirs);
> >                 if (err) {
> > @@ -1333,15 +1369,215 @@ struct erofs_inode *erofs_mkfs_build_tree_from=
_path(const char *path)
> >                         break;
> >                 }
> >
> > +               if (!z_erofs_mt_enabled) {
> > +                       if (S_ISDIR(inode->i_mode)) {
> > +                               inode->next_dirwrite =3D dumpdir;
> > +                               dumpdir =3D inode;
> > +                       } else {
> > +                               erofs_iput(inode);
> > +                       }
> > +#ifdef EROFS_MT_ENABLED
>
> Missing the changes we discussed in v1 here ?
>
> > +               } else {
> > +                       erofs_push_inode_fifo(z_erofs_mt_queue, &inode)=
;
> > +#endif
> > +               }
> > +       } while (!list_empty(&dirs));
> > +
> > +       if (!z_erofs_mt_enabled)
> > +               erofs_mkfs_dumpdir(dumpdir);
> > +#ifdef EROFS_MT_ENABLED
> > +       else
> > +               erofs_push_inode_fifo(z_erofs_mt_queue, &dumpdir);
> > +#endif
> > +       return root;
> > +}
> > +
> > +#ifdef EROFS_MT_ENABLED
> > +pthread_t z_erofs_mt_traverser;
> > +
> > +void *z_erofs_mt_traverse_task(void *path)
> > +{
> > +       pthread_exit((void *)__erofs_mkfs_build_tree_from_path(path));
> > +}
> > +
> > +static int z_erofs_mt_reap_compressed(struct erofs_inode *inode)
> > +{
> > +       struct z_erofs_mt_file *desc =3D inode->mt_desc;
> > +       int fd =3D desc->fd;
> > +       int ret =3D 0;
> > +
> > +       pthread_mutex_lock(&desc->mutex);
> > +       while (desc->nfini !=3D desc->total)
> > +               pthread_cond_wait(&desc->cond, &desc->mutex);
> > +       pthread_mutex_unlock(&desc->mutex);
> > +
> > +       ret =3D z_erofs_mt_reap(desc);
> > +       if (ret =3D=3D -ENOSPC) {
> > +               ret =3D lseek(fd, 0, SEEK_SET);
> > +               if (ret < 0)
> > +                       return -errno;
> > +
> > +               ret =3D write_uncompressed_file_from_fd(inode, fd);
> > +       }
> > +
> > +       close(fd);
> > +       return ret;
> > +}
> > +
> > +static int z_erofs_mt_reap_inodes()
> > +{
> > +       struct erofs_inode *inode, *dumpdir;
> > +       int ret =3D 0;
> > +
> > +       dumpdir =3D NULL;
> > +       while (true) {
> > +               inode =3D *(struct erofs_inode **)erofs_pop_inode_fifo(
> > +                       z_erofs_mt_queue);
> > +               if (!inode)
> > +                       break;
> > +
> > +               erofs_mkfs_print_progressinfo(inode);
> > +
> >                 if (S_ISDIR(inode->i_mode)) {
> > +                       ret =3D erofs_prepare_inode_buffer(inode);
> > +                       if (ret)
> > +                               goto out;
> > +                       inode->bh->op =3D &erofs_skip_write_bhops;
> > +
> > +                       if (IS_ROOT(inode))
> > +                               erofs_fixup_meta_blkaddr(inode);
> > +
> >                         inode->next_dirwrite =3D dumpdir;
> >                         dumpdir =3D inode;
> > +                       continue;
> > +               }
> > +
> > +               if (inode->mt_desc) {
> > +                       ret =3D z_erofs_mt_reap_compressed(inode);
> > +               } else if (S_ISLNK(inode->i_mode)) {
> > +                       ret =3D erofs_mkfs_handle_symlink(inode);
> > +               } else if (!inode->i_size) {
> > +                       ret =3D 0;
> >                 } else {
> > -                       erofs_iput(inode);
> > +                       int fd =3D open(inode->i_srcpath, O_RDONLY | O_=
BINARY);
> > +                       if (fd < 0)
> > +                               return -errno;
> > +
> > +                       if (cfg.c_chunkbits)
> > +                               ret =3D erofs_write_chunked_file(inode,=
 fd, 0);
> > +                       else
> > +                               ret =3D write_uncompressed_file_from_fd=
(inode,
> > +                                                                     f=
d);
> > +                       close(fd);
> >                 }
> > -       } while (!list_empty(&dirs));
> > +               if (ret)
> > +                       goto out;
> > +
> > +               erofs_prepare_inode_buffer(inode);
> > +               erofs_write_tail_end(inode);
> > +               erofs_iput(inode);
> > +       }
> >
> >         erofs_mkfs_dumpdir(dumpdir);
> > +
> > +out:
> > +       return ret;
> > +}
> > +
> > +struct erofs_inode_fifo *erofs_alloc_inode_fifo(size_t size, size_t el=
em_size)
> > +{
> > +       struct erofs_inode_fifo *q =3D malloc(sizeof(*q));
> > +
> > +       pthread_mutex_init(&q->lock, NULL);
> > +       pthread_cond_init(&q->empty, NULL);
> > +       pthread_cond_init(&q->full, NULL);
> > +
> > +       q->size =3D size;
> > +       q->elem_size =3D elem_size;
> > +       q->head =3D 0;
> > +       q->tail =3D 0;
> > +       q->buf =3D calloc(size, elem_size);
> > +       if (!q->buf)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       return q;
> > +}
> > +
> > +void erofs_push_inode_fifo(struct erofs_inode_fifo *q, void *elem)
> > +{
> > +       pthread_mutex_lock(&q->lock);
> > +
> > +       while ((q->tail + 1) % q->size =3D=3D q->head)
> > +               pthread_cond_wait(&q->full, &q->lock);
> > +
> > +       memcpy(q->buf + q->tail * q->elem_size, elem, q->elem_size);
> > +       q->tail =3D (q->tail + 1) % q->size;
> > +
> > +       pthread_cond_signal(&q->empty);
> > +       pthread_mutex_unlock(&q->lock);
> > +}
> > +
> > +void *erofs_pop_inode_fifo(struct erofs_inode_fifo *q)
> > +{
> > +       void *elem;
> > +
> > +       pthread_mutex_lock(&q->lock);
> > +
> > +       while (q->head =3D=3D q->tail)
> > +               pthread_cond_wait(&q->empty, &q->lock);
> > +
> > +       elem =3D q->buf + q->head * q->elem_size;
> > +       q->head =3D (q->head + 1) % q->size;
> > +
> > +       pthread_cond_signal(&q->full);
> > +       pthread_mutex_unlock(&q->lock);
> > +
> > +       return elem;
> > +}
> > +
> > +void erofs_destroy_inode_fifo(struct erofs_inode_fifo *q)
> > +{
> > +       pthread_mutex_destroy(&q->lock);
> > +       pthread_cond_destroy(&q->empty);
> > +       pthread_cond_destroy(&q->full);
> > +       free(q->buf);
> > +       free(q);
> > +}
> > +
> > +#endif
> > +
> > +struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> > +{
> > +#ifdef EROFS_MT_ENABLED
> > +       int err;
> > +#endif
> > +       struct erofs_inode *root =3D NULL;
> > +
> > +       if (!z_erofs_mt_enabled)
> > +               return __erofs_mkfs_build_tree_from_path(path);
> > +
> > +#ifdef EROFS_MT_ENABLED
> > +       z_erofs_mt_queue =3D erofs_alloc_inode_fifo(EROFS_MT_QUEUE_SIZE=
,
> > +                                            sizeof(struct erofs_inode =
*));
>
> Nit:
> z_erofs_mt_fifo or z_erofs_mt_inode_fifo ?
>
> In addition=EF=BC=8C
> the element in the fifo is struct erofs_inode **, so better to use
> sizeof(struct erofs_inode **),
> although they are both pointers ...

Sorry, I misunderstood the usage, just ignore this.

Thanks,
Jianan

>
> > +       if (IS_ERR(z_erofs_mt_queue))
> > +               return ERR_CAST(z_erofs_mt_queue);
> > +
> > +       err =3D pthread_create(&z_erofs_mt_traverser, NULL,
> > +                            z_erofs_mt_traverse_task, (void *)path);
> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       err =3D z_erofs_mt_reap_inodes();
> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       err =3D pthread_join(z_erofs_mt_traverser, (void *)&root);
> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       erofs_destroy_inode_fifo(z_erofs_mt_queue);
> > +#endif
> > +
> >         return root;
> >  }
> >
> > --
> > 2.44.0
> >
>
> Thanks,
> Jianan
