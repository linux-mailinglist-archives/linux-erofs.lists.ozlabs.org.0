Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C3D87C8F5
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 08:18:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2ve6JHfS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwwZy0xfRz3dW7
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 18:18:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2ve6JHfS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwwZp0R4jz3bX9
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 18:18:25 +1100 (AEDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-60a15449303so20125527b3.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1710487102; x=1711091902; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ulWcbSs4jaOi7dVwsfQXfXqHAGJ8oqdQLnRADireGY=;
        b=2ve6JHfSVPqgbKFd7lzEYrSVvY23DBzvk1O3g3OzgfRTwJ6HZd9x/5cs31Ixw627lN
         WkHcvjNO8xPLYVcNH4zyWu5fCT4VXdPEeLlu4k8Dc6HlOlOya1kQ5JD2QkgtHOi/Ylx+
         EWdAHus7RvxrbtobJNCoeNnz+08wqgASpwusuESIAUbD/PF5t2QMUjw/gZl78GOLcFkV
         uCpT4BORqyS0yM8irUFxuXMwZwxvzRBxuo/fw024XX6UE0W5DsDzCwpFscEZcE9LYkV1
         Z0CC62qmTg3poEnnATcKRvo75EevG0dGo2M6p5qPjhtQtmUZbblJOge1JtrbmLVNAY/r
         wo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710487102; x=1711091902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ulWcbSs4jaOi7dVwsfQXfXqHAGJ8oqdQLnRADireGY=;
        b=JPt77Rybs0NxTBWYbnpF0i2iMuDmQS/6EVBdK2SL/Tg/Bo7jQFmycvGVBz9CsrNeq2
         fpDemMlOhh8hnTUcftr6eYBP2fqyj4LjkcmInuo4oB2eaEPln9CX52jCKUoWybSG2CVt
         07LfU8eREX28pei+UHKvfnLagJgA5DmUt+LkRsYLBl8HtAb5RNrdh2VjxSCZlcan34hE
         5rzot0m/spZP31rHyYH3Vdz0C75S+iIm+zaz81LwseEXwWxwp7vo/dXWWNM2dYBKYYVt
         JzfGKxBjiWA48wcPKpLoV1VUxkD9m+02OQBdAH2U1Re3C5lwS8enouQJGP4hMzGWUIuP
         2jcw==
X-Gm-Message-State: AOJu0YwTXLTa5rugMcIdiGU0tvPV0kTUFMY19I1ijjNB8lD+1a/OwGpC
	eQCNx59mhEoR53dLB2nouJERDKxlAcF+TtvN6HrIq6aWZDREsp4HDiIIGr+dwetGJTPGdKqZD1q
	owVQgpwFq82Av1KjdSCnTcmeVGityuQxpoSb9UBuvAaVi59+m8AQ=
X-Google-Smtp-Source: AGHT+IHD15K+3vE5qavJZ29f/eNmLQZWruYvge7S5dpwbCd6DXePXNbGo+VpRs0+ilY1ZrG0xydshmdeTPpLcmgr3aI=
X-Received: by 2002:a0d:eb06:0:b0:609:e3b3:afdf with SMTP id
 u6-20020a0deb06000000b00609e3b3afdfmr4536755ywe.26.1710487101570; Fri, 15 Mar
 2024 00:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com> <20240315011019.610442-5-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240315011019.610442-5-hsiangkao@linux.alibaba.com>
From: Noboru Asai <asai@sijam.com>
Date: Fri, 15 Mar 2024 16:18:10 +0900
Message-ID: <CAFoAo-JakJCcf9aW-Wdk+OHS092PRzpeTusAz817N7FUT0ExFQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] erofs-utils: mkfs: introduce inner-file
 multi-threaded compression
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org, Tong Xin <xin_tong@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I think it is easier to understand the source code if the names of
variables and pointers in the same structure are unified.

struct z_erofs_compress_ictx inode_ctx; // i stands for inode?
struct z_erofs_compress_ictx *ictx;

struct z_erofs_compress_sctx seg_ctx;
struct z_erofs_compress_sctx *sctx;

2024=E5=B9=B43=E6=9C=8815=E6=97=A5(=E9=87=91) 10:11 Gao Xiang <hsiangkao@li=
nux.alibaba.com>:
>
> From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
>
> Currently, the creation of EROFS compressed image creation is
> single-threaded, which suffers from performance issues. This patch
> attempts to address it by compressing the large file in parallel.
>
> Specifically, each input file larger than 16MB is splited into segments,
> and each worker thread compresses a segment as if it were a separate
> file. Finally, the main thread merges all the compressed segments.
>
> Multi-threaded compression is not compatible with -Ededupe,
> -E(all-)fragments and -Eztailpacking for now.
>
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v7:
>  - support -Eztailpacking;
>  - wq_private -> wq_tls;
>  - minor updates.
>
>  include/erofs/compress.h |   3 +-
>  lib/compress.c           | 548 ++++++++++++++++++++++++++++++++-------
>  lib/compressor.c         |   2 +
>  mkfs/main.c              |   8 +-
>  4 files changed, 464 insertions(+), 97 deletions(-)
>
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index b3272f7..3253611 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -14,7 +14,8 @@ extern "C"
>
>  #include "internal.h"
>
> -#define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
> +#define EROFS_CONFIG_COMPR_MAX_SZ      (4000 * 1024)
> +#define Z_EROFS_COMPR_QUEUE_SZ         (EROFS_CONFIG_COMPR_MAX_SZ * 2)
>
>  void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
>  int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
> diff --git a/lib/compress.c b/lib/compress.c
> index 4101009..0d796c8 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -20,6 +20,9 @@
>  #include "erofs/block_list.h"
>  #include "erofs/compress_hints.h"
>  #include "erofs/fragments.h"
> +#ifdef EROFS_MT_ENABLED
> +#include "erofs/workqueue.h"
> +#endif
>
>  /* compressing configuration specified by users */
>  struct erofs_compress_cfg {
> @@ -33,29 +36,77 @@ struct z_erofs_extent_item {
>         struct z_erofs_inmem_extent e;
>  };
>
> -struct z_erofs_vle_compress_ctx {
> -       u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
> +struct z_erofs_compress_ictx {
> +       struct erofs_inode *inode;
> +       int fd;
> +       unsigned int pclustersize;
> +
> +       u32 tof_chksum;
> +       bool fix_dedupedfrag;
> +       bool fragemitted;
> +
> +       /* fields for write indexes */
> +       u8 *metacur;
> +       struct list_head extents;
> +       u16 clusterofs;
> +};
> +
> +struct z_erofs_compress_sctx {         /* segment context */
> +       struct z_erofs_compress_ictx *ictx;
> +
> +       u8 *queue;
>         struct list_head extents;
>         struct z_erofs_extent_item *pivot;
>
> -       struct erofs_inode *inode;
> -       struct erofs_compress_cfg *ccfg;
> +       struct erofs_compress *chandle;
> +       char *destbuf;
>
> -       u8 *metacur;
>         unsigned int head, tail;
>         erofs_off_t remaining;
> -       unsigned int pclustersize;
>         erofs_blk_t blkaddr;            /* pointing to the next blkaddr *=
/
>         u16 clusterofs;
>
> -       u32 tof_chksum;
> -       bool fix_dedupedfrag;
> -       bool fragemitted;
> +       int seg_num, seg_idx;
> +
> +       void *membuf;
> +       erofs_off_t memoff;
> +};
> +
> +#ifdef EROFS_MT_ENABLED
> +struct erofs_compress_wq_tls {
> +       u8 *queue;
> +       char *destbuf;
> +       struct erofs_compress_cfg *ccfg;
>  };
>
> +struct erofs_compress_work {
> +       /* Note: struct erofs_work must be the first member */
> +       struct erofs_work work;
> +       struct z_erofs_compress_sctx ctx;
> +       struct erofs_compress_work *next;
> +
> +       unsigned int alg_id;
> +       char *alg_name;
> +       unsigned int comp_level;
> +       unsigned int dict_size;
> +
> +       int errcode;
> +};
> +
> +static struct {
> +       struct erofs_workqueue wq;
> +       struct erofs_compress_work *idle;
> +       pthread_mutex_t mutex;
> +       pthread_cond_t cond;
> +       int nfini;
> +} z_erofs_mt_ctrl;
> +#endif
> +
> +static bool z_erofs_mt_enabled;
> +
>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE Z_EROFS_FULL_INDEX_ALIGN(0)
>
> -static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx =
*ctx)
> +static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ct=
x)
>  {
>         const unsigned int type =3D Z_EROFS_LCLUSTER_TYPE_PLAIN;
>         struct z_erofs_lcluster_index di;
> @@ -71,7 +122,7 @@ static void z_erofs_write_indexes_final(struct z_erofs=
_vle_compress_ctx *ctx)
>         ctx->metacur +=3D sizeof(di);
>  }
>
> -static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
> +static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
>                                  struct z_erofs_inmem_extent *e)
>  {
>         struct erofs_inode *inode =3D ctx->inode;
> @@ -170,7 +221,7 @@ static void z_erofs_write_extent(struct z_erofs_vle_c=
ompress_ctx *ctx,
>         ctx->clusterofs =3D clusterofs + count;
>  }
>
> -static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
> +static void z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
>  {
>         struct z_erofs_extent_item *ei, *n;
>
> @@ -184,15 +235,16 @@ static void z_erofs_write_indexes(struct z_erofs_vl=
e_compress_ctx *ctx)
>         z_erofs_write_indexes_final(ctx);
>  }
>
> -static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
> +static bool z_erofs_need_refill(struct z_erofs_compress_sctx *ctx)
>  {
>         const bool final =3D !ctx->remaining;
>         unsigned int qh_aligned, qh_after;
> +       struct erofs_inode *inode =3D ctx->ictx->inode;
>
>         if (final || ctx->head < EROFS_CONFIG_COMPR_MAX_SZ)
>                 return false;
>
> -       qh_aligned =3D round_down(ctx->head, erofs_blksiz(ctx->inode->sbi=
));
> +       qh_aligned =3D round_down(ctx->head, erofs_blksiz(inode->sbi));
>         qh_after =3D ctx->head - qh_aligned;
>         memmove(ctx->queue, ctx->queue + qh_aligned, ctx->tail - qh_align=
ed);
>         ctx->tail -=3D qh_aligned;
> @@ -204,7 +256,7 @@ static struct z_erofs_extent_item dummy_pivot =3D {
>         .e.length =3D 0
>  };
>
> -static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
> +static void z_erofs_commit_extent(struct z_erofs_compress_sctx *ctx,
>                                   struct z_erofs_extent_item *ei)
>  {
>         if (ei =3D=3D &dummy_pivot)
> @@ -212,14 +264,13 @@ static void z_erofs_commit_extent(struct z_erofs_vl=
e_compress_ctx *ctx,
>
>         list_add_tail(&ei->list, &ctx->extents);
>         ctx->clusterofs =3D (ctx->clusterofs + ei->e.length) &
> -                       (erofs_blksiz(ctx->inode->sbi) - 1);
> -
> +                         (erofs_blksiz(ctx->ictx->inode->sbi) - 1);
>  }
>
> -static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
> +static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx,
>                                    unsigned int *len)
>  {
> -       struct erofs_inode *inode =3D ctx->inode;
> +       struct erofs_inode *inode =3D ctx->ictx->inode;
>         const unsigned int lclustermask =3D (1 << inode->z_logical_cluste=
rbits) - 1;
>         struct erofs_sb_info *sbi =3D inode->sbi;
>         struct z_erofs_extent_item *ei =3D ctx->pivot;
> @@ -315,16 +366,17 @@ out:
>         return 0;
>  }
>
> -static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ct=
x,
> +static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
>                                      unsigned int len, char *dst)
>  {
> -       struct erofs_sb_info *sbi =3D ctx->inode->sbi;
> +       struct erofs_inode *inode =3D ctx->ictx->inode;
> +       struct erofs_sb_info *sbi =3D inode->sbi;
>         unsigned int count =3D min(erofs_blksiz(sbi), len);
>         unsigned int interlaced_offset, rightpart;
>         int ret;
>
>         /* write interlaced uncompressed data if needed */
> -       if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
> +       if (inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
>                 interlaced_offset =3D ctx->clusterofs;
>         else
>                 interlaced_offset =3D 0;
> @@ -335,11 +387,17 @@ static int write_uncompressed_extent(struct z_erofs=
_vle_compress_ctx *ctx,
>         memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rightpart=
);
>         memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart=
);
>
> -       erofs_dbg("Writing %u uncompressed data to block %u",
> -                 count, ctx->blkaddr);
> -       ret =3D blk_write(sbi, dst, ctx->blkaddr, 1);
> -       if (ret)
> -               return ret;
> +       if (ctx->membuf) {
> +               erofs_dbg("Writing %u uncompressed data to membuf", count=
);
> +               memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi))=
;
> +               ctx->memoff +=3D erofs_blksiz(sbi);
> +       } else {
> +               erofs_dbg("Writing %u uncompressed data to block %u", cou=
nt,
> +                         ctx->blkaddr);
> +               ret =3D blk_write(sbi, dst, ctx->blkaddr, 1);
> +               if (ret)
> +                       return ret;
> +       }
>         return count;
>  }
>
> @@ -379,12 +437,12 @@ static int z_erofs_fill_inline_data(struct erofs_in=
ode *inode, void *data,
>         return len;
>  }
>
> -static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
> +static void tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
>                                    struct erofs_compress *ec,
>                                    void *in, unsigned int *insize,
>                                    void *out, unsigned int *compressedsiz=
e)
>  {
> -       struct erofs_sb_info *sbi =3D ctx->inode->sbi;
> +       struct erofs_sb_info *sbi =3D ctx->ictx->inode->sbi;
>         static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
>         unsigned int count;
>         int ret =3D *compressedsize;
> @@ -406,10 +464,11 @@ static void tryrecompress_trailing(struct z_erofs_v=
le_compress_ctx *ctx,
>         *compressedsize =3D ret;
>  }
>
> -static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_c=
tx *ctx,
> +static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx =
*ctx,
>                                            unsigned int len)
>  {
> -       struct erofs_inode *inode =3D ctx->inode;
> +       struct z_erofs_compress_ictx *ictx =3D ctx->ictx;
> +       struct erofs_inode *inode =3D ictx->inode;
>         struct erofs_sb_info *sbi =3D inode->sbi;
>         const unsigned int newsize =3D ctx->remaining + len;
>
> @@ -417,9 +476,10 @@ static bool z_erofs_fixup_deduped_fragment(struct z_=
erofs_vle_compress_ctx *ctx,
>
>         /* try to fix again if it gets larger (should be rare) */
>         if (inode->fragment_size < newsize) {
> -               ctx->pclustersize =3D min_t(erofs_off_t, z_erofs_get_max_=
pclustersize(inode),
> -                                         roundup(newsize - inode->fragme=
nt_size,
> -                                                 erofs_blksiz(sbi)));
> +               ictx->pclustersize =3D min_t(erofs_off_t,
> +                               z_erofs_get_max_pclustersize(inode),
> +                               roundup(newsize - inode->fragment_size,
> +                                       erofs_blksiz(sbi)));
>                 return false;
>         }
>
> @@ -436,29 +496,32 @@ static bool z_erofs_fixup_deduped_fragment(struct z=
_erofs_vle_compress_ctx *ctx,
>         return true;
>  }
>
> -static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> +static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
>                                   struct z_erofs_inmem_extent *e)
>  {
> -       static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SI=
ZE];
> -       struct erofs_inode *inode =3D ctx->inode;
> +       static char g_dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_=
SIZE];
> +       char *dstbuf =3D ctx->destbuf ?: g_dstbuf;
> +       struct z_erofs_compress_ictx *ictx =3D ctx->ictx;
> +       struct erofs_inode *inode =3D ictx->inode;
>         struct erofs_sb_info *sbi =3D inode->sbi;
>         unsigned int blksz =3D erofs_blksiz(sbi);
>         char *const dst =3D dstbuf + blksz;
> -       struct erofs_compress *const h =3D &ctx->ccfg->handle;
> +       struct erofs_compress *const h =3D ctx->chandle;
>         unsigned int len =3D ctx->tail - ctx->head;
>         bool is_packed_inode =3D erofs_is_packed_inode(inode);
>         bool final =3D !ctx->remaining;
> -       bool may_packing =3D (cfg.c_fragments && final && !is_packed_inod=
e);
> +       bool may_packing =3D (cfg.c_fragments && final && !is_packed_inod=
e &&
> +                           !z_erofs_mt_enabled);
>         bool may_inline =3D (cfg.c_ztailpacking && final && !may_packing)=
;
>         unsigned int compressedsize;
>         int ret;
>
> -       if (len <=3D ctx->pclustersize) {
> +       if (len <=3D ictx->pclustersize) {
>                 if (!final || !len)
>                         return 1;
>                 if (may_packing) {
> -                       if (inode->fragment_size && !ctx->fix_dedupedfrag=
) {
> -                               ctx->pclustersize =3D roundup(len, blksz)=
;
> +                       if (inode->fragment_size && !ictx->fix_dedupedfra=
g) {
> +                               ictx->pclustersize =3D roundup(len, blksz=
);
>                                 goto fix_dedupedfrag;
>                         }
>                         e->length =3D len;
> @@ -470,7 +533,7 @@ static int __z_erofs_compress_one(struct z_erofs_vle_=
compress_ctx *ctx,
>
>         e->length =3D min(len, cfg.c_max_decompressed_extent_bytes);
>         ret =3D erofs_compress_destsize(h, ctx->queue + ctx->head,
> -                                     &e->length, dst, ctx->pclustersize)=
;
> +                                     &e->length, dst, ictx->pclustersize=
);
>         if (ret <=3D 0) {
>                 erofs_err("failed to compress %s: %s", inode->i_srcpath,
>                           erofs_strerror(ret));
> @@ -507,16 +570,16 @@ nocompression:
>                 e->compressedblks =3D 1;
>                 e->raw =3D true;
>         } else if (may_packing && len =3D=3D e->length &&
> -                  compressedsize < ctx->pclustersize &&
> -                  (!inode->fragment_size || ctx->fix_dedupedfrag)) {
> +                  compressedsize < ictx->pclustersize &&
> +                  (!inode->fragment_size || ictx->fix_dedupedfrag)) {
>  frag_packing:
>                 ret =3D z_erofs_pack_fragments(inode, ctx->queue + ctx->h=
ead,
> -                                            len, ctx->tof_chksum);
> +                                            len, ictx->tof_chksum);
>                 if (ret < 0)
>                         return ret;
>                 e->compressedblks =3D 0; /* indicate a fragment */
>                 e->raw =3D false;
> -               ctx->fragemitted =3D true;
> +               ictx->fragemitted =3D true;
>         /* tailpcluster should be less than 1 block */
>         } else if (may_inline && len =3D=3D e->length && compressedsize <=
 blksz) {
>                 if (ctx->clusterofs + len <=3D blksz) {
> @@ -545,8 +608,8 @@ frag_packing:
>                  */
>                 if (may_packing && len =3D=3D e->length &&
>                     (compressedsize & (blksz - 1)) &&
> -                   ctx->tail < sizeof(ctx->queue)) {
> -                       ctx->pclustersize =3D roundup(compressedsize, blk=
sz);
> +                   ctx->tail < Z_EROFS_COMPR_QUEUE_SZ) {
> +                       ictx->pclustersize =3D roundup(compressedsize, bl=
ksz);
>                         goto fix_dedupedfrag;
>                 }
>
> @@ -569,34 +632,45 @@ frag_packing:
>                 }
>
>                 /* write compressed data */
> -               erofs_dbg("Writing %u compressed data to %u of %u blocks"=
,
> -                         e->length, ctx->blkaddr, e->compressedblks);
> +               if (ctx->membuf) {
> +                       erofs_off_t sz =3D e->compressedblks * blksz;
> +                       erofs_dbg("Writing %u compressed data to membuf o=
f %u blocks",
> +                                 e->length, e->compressedblks);
>
> -               ret =3D blk_write(sbi, dst - padding, ctx->blkaddr,
> -                               e->compressedblks);
> -               if (ret)
> -                       return ret;
> +                       memcpy(ctx->membuf + ctx->memoff, dst - padding, =
sz);
> +                       ctx->memoff +=3D sz;
> +               } else {
> +                       erofs_dbg("Writing %u compressed data to %u of %u=
 blocks",
> +                                 e->length, ctx->blkaddr, e->compressedb=
lks);
> +
> +                       ret =3D blk_write(sbi, dst - padding, ctx->blkadd=
r,
> +                                       e->compressedblks);
> +                       if (ret)
> +                               return ret;
> +               }
>                 e->raw =3D false;
>                 may_inline =3D false;
>                 may_packing =3D false;
>         }
>         e->partial =3D false;
>         e->blkaddr =3D ctx->blkaddr;
> +       if (ctx->blkaddr !=3D EROFS_NULL_ADDR)
> +               ctx->blkaddr +=3D e->compressedblks;
>         if (!may_inline && !may_packing && !is_packed_inode)
>                 (void)z_erofs_dedupe_insert(e, ctx->queue + ctx->head);
> -       ctx->blkaddr +=3D e->compressedblks;
>         ctx->head +=3D e->length;
>         return 0;
>
>  fix_dedupedfrag:
>         DBG_BUGON(!inode->fragment_size);
>         ctx->remaining +=3D inode->fragment_size;
> -       ctx->fix_dedupedfrag =3D true;
> +       ictx->fix_dedupedfrag =3D true;
>         return 1;
>  }
>
> -static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
> +static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
>  {
> +       struct z_erofs_compress_ictx *ictx =3D ctx->ictx;
>         unsigned int len =3D ctx->tail - ctx->head;
>         struct z_erofs_extent_item *ei;
>
> @@ -624,7 +698,7 @@ static int z_erofs_compress_one(struct z_erofs_vle_co=
mpress_ctx *ctx)
>
>                 len -=3D ei->e.length;
>                 ctx->pivot =3D ei;
> -               if (ctx->fix_dedupedfrag && !ctx->fragemitted &&
> +               if (ictx->fix_dedupedfrag && !ictx->fragemitted &&
>                     z_erofs_fixup_deduped_fragment(ctx, len))
>                         break;
>
> @@ -912,13 +986,268 @@ void z_erofs_drop_inline_pcluster(struct erofs_ino=
de *inode)
>         inode->eof_tailraw =3D NULL;
>  }
>
> +int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
> +                            u64 offset, erofs_blk_t blkaddr)
> +{
> +       int fd =3D ctx->ictx->fd;
> +
> +       ctx->blkaddr =3D blkaddr;
> +       while (ctx->remaining) {
> +               const u64 rx =3D min_t(u64, ctx->remaining,
> +                                    Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
> +               int ret;
> +
> +               ret =3D (offset =3D=3D -1 ?
> +                       read(fd, ctx->queue + ctx->tail, rx) :
> +                       pread(fd, ctx->queue + ctx->tail, rx, offset));
> +               if (ret !=3D rx)
> +                       return -errno;
> +
> +               ctx->remaining -=3D rx;
> +               ctx->tail +=3D rx;
> +               if (offset !=3D -1)
> +                       offset +=3D rx;
> +
> +               ret =3D z_erofs_compress_one(ctx);
> +               if (ret)
> +                       return ret;
> +       }
> +       DBG_BUGON(ctx->head !=3D ctx->tail);
> +
> +       if (ctx->pivot) {
> +               z_erofs_commit_extent(ctx, ctx->pivot);
> +               ctx->pivot =3D NULL;
> +       }
> +       return 0;
> +}
> +
> +#ifdef EROFS_MT_ENABLED
> +void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
> +{
> +       struct erofs_compress_wq_tls *tls;
> +
> +       tls =3D calloc(1, sizeof(*tls));
> +       if (!tls)
> +               return NULL;
> +
> +       tls->queue =3D malloc(Z_EROFS_COMPR_QUEUE_SZ);
> +       if (!tls->queue)
> +               goto err_free_priv;
> +
> +       tls->destbuf =3D calloc(1, EROFS_CONFIG_COMPR_MAX_SZ +
> +                             EROFS_MAX_BLOCK_SIZE);
> +       if (!tls->destbuf)
> +               goto err_free_queue;
> +
> +       tls->ccfg =3D calloc(EROFS_MAX_COMPR_CFGS, sizeof(*tls->ccfg));
> +       if (!tls->ccfg)
> +               goto err_free_destbuf;
> +       return tls;
> +
> +err_free_destbuf:
> +       free(tls->destbuf);
> +err_free_queue:
> +       free(tls->queue);
> +err_free_priv:
> +       free(tls);
> +       return NULL;
> +}
> +
> +int z_erofs_mt_wq_tls_init_compr(struct erofs_sb_info *sbi,
> +                                struct erofs_compress_wq_tls *tls,
> +                                unsigned int alg_id, char *alg_name,
> +                                unsigned int comp_level,
> +                                unsigned int dict_size)
> +{
> +       struct erofs_compress_cfg *lc =3D &tls->ccfg[alg_id];
> +       int ret;
> +
> +       if (likely(lc->enable))
> +               return 0;
> +
> +       ret =3D erofs_compressor_init(sbi, &lc->handle, alg_name,
> +                                   comp_level, dict_size);
> +       if (ret)
> +               return ret;
> +       lc->algorithmtype =3D alg_id;
> +       lc->enable =3D true;
> +       return 0;
> +}
> +
> +void *z_erofs_mt_wq_tls_free(struct erofs_workqueue *wq, void *priv)
> +{
> +       struct erofs_compress_wq_tls *tls =3D priv;
> +       int i;
> +
> +       for (i =3D 0; i < EROFS_MAX_COMPR_CFGS; i++)
> +               if (tls->ccfg[i].enable)
> +                       erofs_compressor_exit(&tls->ccfg[i].handle);
> +
> +       free(tls->ccfg);
> +       free(tls->destbuf);
> +       free(tls->queue);
> +       free(tls);
> +       return NULL;
> +}
> +
> +void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
> +{
> +       struct erofs_compress_work *cwork =3D (struct erofs_compress_work=
 *)work;
> +       struct erofs_compress_wq_tls *tls =3D tlsp;
> +       struct z_erofs_compress_sctx *ctx =3D &cwork->ctx;
> +       u64 offset =3D ctx->seg_idx * cfg.c_segment_size;
> +       int ret =3D 0;
> +
> +       ret =3D z_erofs_mt_wq_tls_init_compr(ctx->ictx->inode->sbi, tls,
> +                                          cwork->alg_id, cwork->alg_name=
,
> +                                          cwork->comp_level,
> +                                          cwork->dict_size);
> +       if (ret)
> +               goto out;
> +
> +       ctx->queue =3D tls->queue;
> +       ctx->destbuf =3D tls->destbuf;
> +       ctx->chandle =3D &tls->ccfg[cwork->alg_id].handle;
> +
> +       ctx->membuf =3D malloc(ctx->remaining);
> +       if (!ctx->membuf) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +       ctx->memoff =3D 0;
> +
> +       ret =3D z_erofs_compress_segment(ctx, offset, EROFS_NULL_ADDR);
> +
> +out:
> +       cwork->errcode =3D ret;
> +       pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> +       ++z_erofs_mt_ctrl.nfini;
> +       pthread_cond_signal(&z_erofs_mt_ctrl.cond);
> +       pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> +}
> +
> +int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
> +                         struct z_erofs_compress_sctx *ctx)
> +{
> +       struct z_erofs_extent_item *ei, *n;
> +       struct erofs_sb_info *sbi =3D ictx->inode->sbi;
> +       erofs_blk_t blkoff =3D 0;
> +       int ret =3D 0, ret2;
> +
> +       list_for_each_entry_safe(ei, n, &ctx->extents, list) {
> +               list_del(&ei->list);
> +               list_add_tail(&ei->list, &ictx->extents);
> +
> +               if (ei->e.blkaddr !=3D EROFS_NULL_ADDR)   /* deduped exte=
nts */
> +                       continue;
> +
> +               ei->e.blkaddr =3D ctx->blkaddr;
> +               ctx->blkaddr +=3D ei->e.compressedblks;
> +
> +               ret2 =3D blk_write(sbi, ctx->membuf + blkoff * erofs_blks=
iz(sbi),
> +                                ei->e.blkaddr, ei->e.compressedblks);
> +               blkoff +=3D ei->e.compressedblks;
> +               if (ret2) {
> +                       ret =3D ret2;
> +                       continue;
> +               }
> +       }
> +       free(ctx->membuf);
> +       return ret;
> +}
> +
> +int z_erofs_mt_compress(struct z_erofs_compress_ictx *ctx,
> +                       struct erofs_compress_cfg *ccfg,
> +                       erofs_blk_t blkaddr,
> +                       erofs_blk_t *compressed_blocks)
> +{
> +       struct erofs_compress_work *cur, *head =3D NULL, **last =3D &head=
;
> +       struct erofs_inode *inode =3D ctx->inode;
> +       int nsegs =3D DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
> +       int ret, i;
> +
> +       z_erofs_mt_ctrl.nfini =3D 0;
> +
> +       for (i =3D 0; i < nsegs; i++) {
> +               if (z_erofs_mt_ctrl.idle) {
> +                       cur =3D z_erofs_mt_ctrl.idle;
> +                       z_erofs_mt_ctrl.idle =3D cur->next;
> +                       cur->next =3D NULL;
> +               } else {
> +                       cur =3D calloc(1, sizeof(*cur));
> +                       if (!cur)
> +                               return -ENOMEM;
> +               }
> +               *last =3D cur;
> +               last =3D &cur->next;
> +
> +               cur->ctx =3D (struct z_erofs_compress_sctx) {
> +                       .ictx =3D ctx,
> +                       .seg_num =3D nsegs,
> +                       .seg_idx =3D i,
> +                       .pivot =3D &dummy_pivot,
> +               };
> +               init_list_head(&cur->ctx.extents);
> +
> +               if (i =3D=3D nsegs - 1)
> +                       cur->ctx.remaining =3D inode->i_size -
> +                                             inode->fragment_size -
> +                                             i * cfg.c_segment_size;
> +               else
> +                       cur->ctx.remaining =3D cfg.c_segment_size;
> +
> +               cur->alg_id =3D ccfg->handle.alg->id;
> +               cur->alg_name =3D ccfg->handle.alg->name;
> +               cur->comp_level =3D ccfg->handle.compression_level;
> +               cur->dict_size =3D ccfg->handle.dict_size;
> +
> +               cur->work.fn =3D z_erofs_mt_workfn;
> +               erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
> +       }
> +
> +       pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> +       while (z_erofs_mt_ctrl.nfini !=3D nsegs)
> +               pthread_cond_wait(&z_erofs_mt_ctrl.cond,
> +                                 &z_erofs_mt_ctrl.mutex);
> +       pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> +
> +       ret =3D 0;
> +       while (head) {
> +               cur =3D head;
> +               head =3D cur->next;
> +
> +               if (cur->errcode) {
> +                       ret =3D cur->errcode;
> +               } else {
> +                       int ret2;
> +
> +                       cur->ctx.blkaddr =3D blkaddr;
> +                       ret2 =3D z_erofs_merge_segment(ctx, &cur->ctx);
> +                       if (ret2)
> +                               ret =3D ret2;
> +
> +                       *compressed_blocks +=3D cur->ctx.blkaddr - blkadd=
r;
> +                       blkaddr =3D cur->ctx.blkaddr;
> +               }
> +
> +               cur->next =3D z_erofs_mt_ctrl.idle;
> +               z_erofs_mt_ctrl.idle =3D cur;
> +       }
> +       return ret;
> +}
> +#endif
> +
>  int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  {
> +       static u8 g_queue[Z_EROFS_COMPR_QUEUE_SZ];
>         struct erofs_buffer_head *bh;
> -       static struct z_erofs_vle_compress_ctx ctx;
> -       erofs_blk_t blkaddr, compressed_blocks;
> +       static struct z_erofs_compress_ictx ctx;
> +       static struct z_erofs_compress_sctx sctx;
> +       struct erofs_compress_cfg *ccfg;
> +       erofs_blk_t blkaddr, compressed_blocks =3D 0;
>         unsigned int legacymetasize;
>         int ret;
> +       bool ismt =3D false;
>         struct erofs_sb_info *sbi =3D inode->sbi;
>         u8 *compressmeta =3D malloc(BLK_ROUND_UP(sbi, inode->i_size) *
>                                   sizeof(struct z_erofs_lcluster_index) +
> @@ -963,8 +1292,8 @@ int erofs_write_compressed_file(struct erofs_inode *=
inode, int fd)
>                 }
>         }
>  #endif
> -       ctx.ccfg =3D &erofs_ccfg[inode->z_algorithmtype[0]];
> -       inode->z_algorithmtype[0] =3D ctx.ccfg[0].algorithmtype;
> +       ccfg =3D &erofs_ccfg[inode->z_algorithmtype[0]];
> +       inode->z_algorithmtype[0] =3D ccfg[0].algorithmtype;
>         inode->z_algorithmtype[1] =3D 0;
>
>         inode->idata_size =3D 0;
> @@ -983,50 +1312,45 @@ int erofs_write_compressed_file(struct erofs_inode=
 *inode, int fd)
>         blkaddr =3D erofs_mapbh(bh->block);       /* start_blkaddr */
>         ctx.inode =3D inode;
>         ctx.pclustersize =3D z_erofs_get_max_pclustersize(inode);
> -       ctx.blkaddr =3D blkaddr;
>         ctx.metacur =3D compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> -       ctx.head =3D ctx.tail =3D 0;
> -       ctx.clusterofs =3D 0;
> -       ctx.pivot =3D &dummy_pivot;
>         init_list_head(&ctx.extents);
> -       ctx.remaining =3D inode->i_size - inode->fragment_size;
> +       ctx.fd =3D fd;
>         ctx.fix_dedupedfrag =3D false;
>         ctx.fragemitted =3D false;
> +       sctx =3D (struct z_erofs_compress_sctx) { .ictx =3D &ctx, };
> +       init_list_head(&sctx.extents);
> +
>         if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
>             !inode->fragment_size) {
>                 ret =3D z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chks=
um);
>                 if (ret)
>                         goto err_free_idata;
> +#ifdef EROFS_MT_ENABLED
> +       } else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_si=
ze) {
> +               ismt =3D true;
> +               ret =3D z_erofs_mt_compress(&ctx, ccfg, blkaddr, &compres=
sed_blocks);
> +               if (ret)
> +                       goto err_free_idata;
> +#endif
>         } else {
> -               while (ctx.remaining) {
> -                       const u64 rx =3D min_t(u64, ctx.remaining,
> -                                            sizeof(ctx.queue) - ctx.tail=
);
> -
> -                       ret =3D read(fd, ctx.queue + ctx.tail, rx);
> -                       if (ret !=3D rx) {
> -                               ret =3D -errno;
> -                               goto err_bdrop;
> -                       }
> -                       ctx.remaining -=3D rx;
> -                       ctx.tail +=3D rx;
> -
> -                       ret =3D z_erofs_compress_one(&ctx);
> -                       if (ret)
> -                               goto err_free_idata;
> -               }
> +               sctx.queue =3D g_queue;
> +               sctx.destbuf =3D NULL;
> +               sctx.chandle =3D &ccfg->handle;
> +               sctx.remaining =3D inode->i_size - inode->fragment_size;
> +               sctx.seg_num =3D 1;
> +               sctx.seg_idx =3D 0;
> +               sctx.pivot =3D &dummy_pivot;
> +
> +               ret =3D z_erofs_compress_segment(&sctx, -1, blkaddr);
> +               if (ret)
> +                       goto err_free_idata;
> +               compressed_blocks =3D sctx.blkaddr - blkaddr;
>         }
> -       DBG_BUGON(ctx.head !=3D ctx.tail);
>
>         /* fall back to no compression mode */
> -       compressed_blocks =3D ctx.blkaddr - blkaddr;
>         DBG_BUGON(compressed_blocks < !!inode->idata_size);
>         compressed_blocks -=3D !!inode->idata_size;
>
> -       if (ctx.pivot) {
> -               z_erofs_commit_extent(&ctx, ctx.pivot);
> -               ctx.pivot =3D NULL;
> -       }
> -
>         /* generate an extent for the deduplicated fragment */
>         if (inode->fragment_size && !ctx.fragemitted) {
>                 struct z_erofs_extent_item *ei;
> @@ -1042,13 +1366,16 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd)
>                         .compressedblks =3D 0,
>                         .raw =3D false,
>                         .partial =3D false,
> -                       .blkaddr =3D ctx.blkaddr,
> +                       .blkaddr =3D sctx.blkaddr,
>                 };
>                 init_list_head(&ei->list);
> -               z_erofs_commit_extent(&ctx, ei);
> +               z_erofs_commit_extent(&sctx, ei);
>         }
>         z_erofs_fragments_commit(inode);
>
> +       if (!ismt)
> +               list_splice_tail(&sctx.extents, &ctx.extents);
> +
>         z_erofs_write_indexes(&ctx);
>         legacymetasize =3D ctx.metacur - compressmeta;
>         /* estimate if data compression saves space or not */
> @@ -1257,8 +1584,25 @@ int z_erofs_compress_init(struct erofs_sb_info *sb=
i, struct erofs_buffer_head *s
>                 return -EINVAL;
>         }
>
> -       if (erofs_sb_has_compr_cfgs(sbi))
> -               return z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size=
);
> +       if (erofs_sb_has_compr_cfgs(sbi)) {
> +               ret =3D z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_siz=
e);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       z_erofs_mt_enabled =3D false;
> +#ifdef EROFS_MT_ENABLED
> +       if (cfg.c_mt_workers > 1) {
> +               pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
> +               pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
> +               ret =3D erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
> +                                           cfg.c_mt_workers,
> +                                           cfg.c_mt_workers << 2,
> +                                           z_erofs_mt_wq_tls_alloc,
> +                                           z_erofs_mt_wq_tls_free);
> +               z_erofs_mt_enabled =3D !ret;
> +       }
> +#endif
>         return 0;
>  }
>
> @@ -1271,5 +1615,19 @@ int z_erofs_compress_exit(void)
>                 if (ret)
>                         return ret;
>         }
> +
> +       if (z_erofs_mt_enabled) {
> +#ifdef EROFS_MT_ENABLED
> +               ret =3D erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
> +               if (ret)
> +                       return ret;
> +               while (z_erofs_mt_ctrl.idle) {
> +                       struct erofs_compress_work *tmp =3D
> +                               z_erofs_mt_ctrl.idle->next;
> +                       free(z_erofs_mt_ctrl.idle);
> +                       z_erofs_mt_ctrl.idle =3D tmp;
> +               }
> +#endif
> +       }
>         return 0;
>  }
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 58eae2a..175259e 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -86,6 +86,8 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, st=
ruct erofs_compress *c,
>
>         /* should be written in "minimum compression ratio * 100" */
>         c->compress_threshold =3D 100;
> +       c->compression_level =3D -1;
> +       c->dict_size =3D 0;
>
>         if (!alg_name) {
>                 c->alg =3D NULL;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 126a049..5dbaf9f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -678,7 +678,7 @@ static int mkfs_parse_options_cfg(int argc, char *arg=
v[])
>
>                         processors =3D erofs_get_available_processors();
>                         if (cfg.c_mt_workers > processors)
> -                               erofs_warn("the number of workers %d is m=
ore than the number of processors %d, performance may be impacted.",
> +                               erofs_warn("%d workers exceed %d processo=
rs, potentially impacting performance.",
>                                            cfg.c_mt_workers, processors);
>                         break;
>                 }
> @@ -838,6 +838,12 @@ static int mkfs_parse_options_cfg(int argc, char *ar=
gv[])
>                 }
>                 cfg.c_pclusterblks_packed =3D pclustersize_packed >> sbi.=
blkszbits;
>         }
> +#ifdef EROFS_MT_ENABLED
> +       if (cfg.c_mt_workers > 1 && (cfg.c_dedupe || cfg.c_fragments)) {
> +               erofs_warn("Note that dedupe/fragments are NOT supported =
in multi-threaded mode for now, reseting --workers=3D1.");
> +               cfg.c_mt_workers =3D 1;
> +       }
> +#endif
>         return 0;
>  }
>
> --
> 2.39.3
>
