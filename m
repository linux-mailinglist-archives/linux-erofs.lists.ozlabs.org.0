Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99583D3D6
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 05:56:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1706245012;
	bh=74RQ2oIUc1ObkcR3+myxEPLduZaF3Pdh1Cwy7vDeVhE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jcryrzNRIiGn7cW1JLt7fPbHzAkA/Jnqn57qalOdt7yNBLHsKtnAUK3HN8U9Aqqg5
	 bhcIyPtsEJ4Qn8PVOVUzC5FuhlzSNXSsa5LmF+t+CsyQfD8U64DpF5gsAe+I1Pkdrq
	 0cOeuGJsApD6qtrQQO2X+sKEbfFV4SfBIZJ3gsnQSwwMjmBU2dR5KS+fGveAZMJP6e
	 /s1dTne0MVTYpOFA8DJW7sYbF4WkZOV50DYKk4pK0QIvEAhoYmsCApkCiZpNRCLhjX
	 bhrDEKc3gaEr210PPeDE/a4C9T9jTQKc7sZMTXCnLMbOZw585sDSeBMljtjHWiUTbi
	 CoOJgBxdrpp6w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLlm42Khyz3cNV
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 15:56:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=mFKAiIAF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLllS4thsz3cTZ
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 15:56:20 +1100 (AEDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6de424cef01so3877309a34.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jan 2024 20:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706244977; x=1706849777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74RQ2oIUc1ObkcR3+myxEPLduZaF3Pdh1Cwy7vDeVhE=;
        b=iwPrbZdeZYx5CwLY8gbCdpU6gxy+gwjh64g6usfC+rSmLv+1a9CvGLlhNlgUvlnpje
         BRnDFQTikxhzxjXo+MPiu7sok1hEceuLonCRsvpeQv6NGsFolRiSWXpA4rRzPfr5To6b
         edzcmCKXbP1/rTTIAl4pg9BGiSy1vaNCaZx/htad2LGUvu1oqGRSiHAobQuyHWzXDUVr
         9HxLCB949kMLuP2boaK+ll72Eyx284wKiatvOp5Jc4gDRuXfX6ZZ9XfqauRacSE2YCB6
         21wZ8GkaW7ZRC4OJpNvAVYd8qOm5eQUsDDDlEe3U2+yMFZgI4+o5+/z/ImI7zRcSUmsA
         bnQw==
X-Gm-Message-State: AOJu0Yw4o18U/iNJHll4kqlUiPQ6nB3Y38vgovJvcCD2boqmGO+wr0D9
	Wc2cO6Ed0NDTdqerWrwwcCr7TOsAHgfuog/DqIqsNoncuVe39db6ZjKUClkpHMOTFyyDDKni7YP
	S1sM7RrDBCVNyk5meLRcNrk6KtNL9G9h7i2eq
X-Google-Smtp-Source: AGHT+IFhmRJas2IvuqlY1vmoSoIIaVGnnCvEt9x3un3/Ksd+gKInTzvkP0/0W4UG1DQcxGYYmrDStIuf2mp/XAqKK6k=
X-Received: by 2002:a05:6830:3150:b0:6db:ffa6:6c4d with SMTP id
 c16-20020a056830315000b006dbffa66c4dmr972059ots.24.1706244977191; Thu, 25 Jan
 2024 20:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
Date: Thu, 25 Jan 2024 20:56:05 -0800
Message-ID: <CAB=BE-QPzipJ8iEjwoHx2_CN-WnRGvKRRZr_Xtm2wqmHWQHjsw@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix infinite loop due to a race of filling compressed_bvecs
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

On Thu, Jan 25, 2024 at 4:01=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> I encountered a race issue after lengthy (~594647 sec) stress tests on
> a 64k-page arm64 VM with several 4k-block EROFS images.  The timing
> is like below:
>
> z_erofs_try_inplace_io                  z_erofs_fill_bio_vec
>   cmpxchg(&compressed_bvecs[].page,
>           NULL, ..)
>                                         [access bufvec]
>   compressed_bvecs[] =3D *bvec;
>
> Previously, z_erofs_submit_queue() just accessed bufvec->page only, so
> other fields in bufvec didn't matter.  After the subpage block support
> is landed, .offset and .end can be used too, but filling bufvec isn't
> an atomic operation which can cause inconsistency.
>
> Let's use a spinlock to keep the atomicity of each bufvec.  More
> specifically, just reuse the existing spinlock `pcl->obj.lockref.lock`
> since it's rarely used (also it takes a short time if even used) as long
> as the pcluster has a reference.
>
> Fixes: 192351616a9d ("erofs: support I/O submission for sub-page compress=
ed blocks")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 74 +++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 583c062cd0e4..c1c77166b30f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -563,21 +563,19 @@ static void z_erofs_bind_cache(struct z_erofs_decom=
press_frontend *fe)
>                         __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>         unsigned int i;
>
> -       if (i_blocksize(fe->inode) !=3D PAGE_SIZE)
> -               return;
> -       if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
> +       if (i_blocksize(fe->inode) !=3D PAGE_SIZE ||
> +           fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
>                 return;
>
>         for (i =3D 0; i < pclusterpages; ++i) {
>                 struct page *page, *newpage;
>                 void *t;        /* mark pages just found for debugging */
>
> -               /* the compressed page was loaded before */
> +               /* Inaccurate check w/o locking to avoid unneeded lookups=
 */
>                 if (READ_ONCE(pcl->compressed_bvecs[i].page))
>                         continue;
>
>                 page =3D find_get_page(mc, pcl->obj.index + i);
> -
>                 if (page) {
>                         t =3D (void *)((unsigned long)page | 1);
>                         newpage =3D NULL;
> @@ -597,9 +595,13 @@ static void z_erofs_bind_cache(struct z_erofs_decomp=
ress_frontend *fe)
>                         set_page_private(newpage, Z_EROFS_PREALLOCATED_PA=
GE);
>                         t =3D (void *)((unsigned long)newpage | 1);
>                 }
> -
> -               if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL=
, t))
> +               spin_lock(&pcl->obj.lockref.lock);
> +               if (!pcl->compressed_bvecs[i].page) {
> +                       pcl->compressed_bvecs[i].page =3D t;
> +                       spin_unlock(&pcl->obj.lockref.lock);
>                         continue;
> +               }
> +               spin_unlock(&pcl->obj.lockref.lock);
>
>                 if (page)
>                         put_page(page);
> @@ -718,31 +720,25 @@ int erofs_init_managed_cache(struct super_block *sb=
)
>         return 0;
>  }
>
> -static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *f=
e,
> -                                  struct z_erofs_bvec *bvec)
> -{
> -       struct z_erofs_pcluster *const pcl =3D fe->pcl;
> -
> -       while (fe->icur > 0) {
> -               if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> -                            NULL, bvec->page)) {
> -                       pcl->compressed_bvecs[fe->icur] =3D *bvec;
> -                       return true;
> -               }
> -       }
> -       return false;
> -}
> -
>  /* callers must be with pcluster lock held */
>  static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
>                                struct z_erofs_bvec *bvec, bool exclusive)
>  {
> +       struct z_erofs_pcluster *pcl =3D fe->pcl;
>         int ret;
>
>         if (exclusive) {
>                 /* give priority for inplaceio to use file pages first */
> -               if (z_erofs_try_inplace_io(fe, bvec))
> +               spin_lock(&pcl->obj.lockref.lock);
> +               while (fe->icur > 0) {
> +                       if (pcl->compressed_bvecs[--fe->icur].page)
> +                               continue;
> +                       pcl->compressed_bvecs[fe->icur] =3D *bvec;
> +                       spin_unlock(&pcl->obj.lockref.lock);
>                         return 0;
> +               }
> +               spin_unlock(&pcl->obj.lockref.lock);
> +
>                 /* otherwise, check if it can be used as a bvpage */
>                 if (fe->mode >=3D Z_EROFS_PCLUSTER_FOLLOWED &&
>                     !fe->candidate_bvpage)
> @@ -1423,23 +1419,26 @@ static void z_erofs_fill_bio_vec(struct bio_vec *=
bvec,
>  {
>         gfp_t gfp =3D mapping_gfp_mask(mc);
>         bool tocache =3D false;
> -       struct z_erofs_bvec *zbv =3D pcl->compressed_bvecs + nr;
> +       struct z_erofs_bvec zbv;
>         struct address_space *mapping;
> -       struct page *page, *oldpage;
> +       struct page *page;
>         int justfound, bs =3D i_blocksize(f->inode);
>
>         /* Except for inplace pages, the entire page can be used for I/Os=
 */
>         bvec->bv_offset =3D 0;
>         bvec->bv_len =3D PAGE_SIZE;
>  repeat:
> -       oldpage =3D READ_ONCE(zbv->page);
> -       if (!oldpage)
> +       spin_lock(&pcl->obj.lockref.lock);
> +       zbv =3D pcl->compressed_bvecs[nr];
> +       page =3D zbv.page;
> +       justfound =3D (unsigned long)page & 1UL;
> +       page =3D (struct page *)((unsigned long)page & ~1UL);
> +       pcl->compressed_bvecs[nr].page =3D page;
> +       spin_unlock(&pcl->obj.lockref.lock);
> +       if (!page)
>                 goto out_allocpage;
>
> -       justfound =3D (unsigned long)oldpage & 1UL;
> -       page =3D (struct page *)((unsigned long)oldpage & ~1UL);
>         bvec->bv_page =3D page;
> -
>         DBG_BUGON(z_erofs_is_shortlived_page(page));
>         /*
>          * Handle preallocated cached pages.  We tried to allocate such p=
ages
> @@ -1448,7 +1447,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bv=
ec,
>          */
>         if (page->private =3D=3D Z_EROFS_PREALLOCATED_PAGE) {
>                 set_page_private(page, 0);
> -               WRITE_ONCE(zbv->page, page);
>                 tocache =3D true;
>                 goto out_tocache;
>         }
> @@ -1459,9 +1457,9 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bv=
ec,
>          * therefore it is impossible for `mapping` to be NULL.
>          */
>         if (mapping && mapping !=3D mc) {
> -               if (zbv->offset < 0)
> -                       bvec->bv_offset =3D round_up(-zbv->offset, bs);
> -               bvec->bv_len =3D round_up(zbv->end, bs) - bvec->bv_offset=
;
> +               if (zbv.offset < 0)
> +                       bvec->bv_offset =3D round_up(-zbv.offset, bs);
> +               bvec->bv_len =3D round_up(zbv.end, bs) - bvec->bv_offset;
>                 return;
>         }
>
> @@ -1471,7 +1469,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bv=
ec,
>
>         /* the cached page is still in managed cache */
>         if (page->mapping =3D=3D mc) {
> -               WRITE_ONCE(zbv->page, page);
>                 /*
>                  * The cached page is still available but without a valid
>                  * `->private` pcluster hint.  Let's reconnect them.
> @@ -1503,11 +1500,15 @@ static void z_erofs_fill_bio_vec(struct bio_vec *=
bvec,
>         put_page(page);
>  out_allocpage:
>         page =3D erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
> -       if (oldpage !=3D cmpxchg(&zbv->page, oldpage, page)) {
> +       spin_lock(&pcl->obj.lockref.lock);
> +       if (pcl->compressed_bvecs[nr].page) {
>                 erofs_pagepool_add(&f->pagepool, page);
> +               spin_unlock(&pcl->obj.lockref.lock);
>                 cond_resched();
>                 goto repeat;
>         }
> +       pcl->compressed_bvecs[nr].page =3D page;
> +       spin_unlock(&pcl->obj.lockref.lock);
>         bvec->bv_page =3D page;
>  out_tocache:
>         if (!tocache || bs !=3D PAGE_SIZE ||
> @@ -1685,6 +1686,7 @@ static void z_erofs_submit_queue(struct z_erofs_dec=
ompress_frontend *f,
>
>                         if (cur + bvec.bv_len > end)
>                                 bvec.bv_len =3D end - cur;
> +                       DBG_BUGON(bvec.bv_len < sb->s_blocksize);
>                         if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
>                                           bvec.bv_offset))
>                                 goto submit_bio_retry;
> --
> 2.39.3
>

LGTM!

Reviewed-by: Sandeep Dhavale <dhavale@google.com>
